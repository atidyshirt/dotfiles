# SketchyBar + SbarLua (built inline) + LaunchAgent. Darwin-only (via darwin.nix).
{
  config,
  lib,
  pkgs,
  dotfilesRoot,
  username,
  sketchybarConfig ? dotfilesRoot + "/config/sketchybar",
  ...
}:
let
  sbarlua = pkgs.stdenv.mkDerivation rec {
    pname = "sbarlua";
    version = "0-unstable-2026-04-06";

    src = pkgs.fetchFromGitHub {
      owner = "FelixKratz";
      repo = "SbarLua";
      rev = "dba9cc421b868c918d5c23c408544a28aadf2f2f";
      sha256 = "1wkfygk3qk8navj42n48wnqzksilc2virfb44w5p00wzvfnx64ln";
    };

    postPatch = ''
      substituteInPlace lua-5.5.0/src/Makefile \
        --replace-fail 'CC= gcc -std=gnu99' 'CC= cc -std=gnu99'
    '';

    buildInputs = with pkgs; [
      readline
      ncurses
    ];

    dontConfigure = true;

    buildPhase = ''
      runHook preBuild
      make -j$NIX_BUILD_CORES
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      export HOME=$(pwd)/fakehome
      mkdir -p "$HOME/.local/share/sketchybar_lua"
      make install
      mkdir -p $out/lib/sketchybar_lua
      cp "$HOME/.local/share/sketchybar_lua/sketchybar.so" $out/lib/sketchybar_lua/
      runHook postInstall
    '';

    meta = {
      description = "SketchyBar Lua module (sketchybar.so)";
      homepage = "https://github.com/FelixKratz/SbarLua";
      license = lib.licenses.mit;
      platforms = lib.platforms.darwin;
    };
  };

  sketchybarAppFont = pkgs.fetchurl {
    url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf";
    sha256 = "1ppis4k4g35gc7zbfhlq9rk4jq92k3c620kw5r666rya38lf77p4";
  };
  sketchybarConfigSrc = builtins.toString sketchybarConfig;

  firaNerdFonts = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode";

  sketchybarLaunch = pkgs.writeShellApplication {
    name = "sketchybar-launch";
    runtimeInputs = with pkgs; [
      lua5_5
      sketchybar
      aerospace
      switchaudio-osx
      nowplaying-cli
      gnumake
      clang
    ];
    text = ''
      export PATH="${pkgs.lua5_5}/bin:$PATH"
      exec sketchybar --config "${config.home.homeDirectory}/.config/sketchybar/sketchybarrc"
    '';
  };
in
{
  home.packages = with pkgs; [
    switchaudio-osx
    nowplaying-cli
    sketchybar
    sketchybarLaunch
  ];

  home.file.".local/share/sketchybar_lua/sketchybar.so".source =
    "${sbarlua}/lib/sketchybar_lua/sketchybar.so";

  home.file."Library/Fonts/sketchybar-app-font.ttf".source = sketchybarAppFont;

  home.file."Library/Fonts/FiraCodeNerd" = {
    source = firaNerdFonts;
    recursive = true;
  };

  home.activation.sketchybarConfigCopy = lib.hm.dag.entryBetween [ "setupLaunchAgents" ] [ "linkGeneration" ] ''
    set -eu
    src=${lib.escapeShellArg sketchybarConfigSrc}
    dst=${lib.escapeShellArg "${config.xdg.configHome}/sketchybar"}
    umask 022
    tmp="''${dst}.new.$$"
    rm -rf "$tmp"
    cp -R -L "$src" "$tmp"
    chmod -R u+w "$tmp"
    rm -rf "$dst"
    mv "$tmp" "$dst"
  '';

  launchd.agents.org-nix-sketchybar = {
    enable = true;
    config = {
      Label = "org.nix-sketchybar";
      ProgramArguments = [ "${sketchybarLaunch}/bin/sketchybar-launch" ];
      RunAtLoad = true;
      KeepAlive = true;
      WorkingDirectory = "${config.home.homeDirectory}/.config/sketchybar";
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/sketchybar.stdout.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/sketchybar.stderr.log";
      EnvironmentVariables = {
        HOME = config.home.homeDirectory;
        USER = username;
        SKETCHYBAR_BIN = lib.getExe pkgs.sketchybar;
      };
    };
  };
}
