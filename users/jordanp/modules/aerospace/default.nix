# AeroSpace, JankyBorders, startpage — Darwin-only (via darwin.nix).
{
  config,
  lib,
  pkgs,
  dotfilesRoot,
  username,
  ...
}:
let
  aerospaceToml = pkgs.replaceVars (dotfilesRoot + "/config/aerospace/aerospace.toml") {
    bash_bin = lib.getExe pkgs.bash;
    sketchybar_bin = lib.getExe pkgs.sketchybar;
    borders_bin = lib.getExe pkgs.jankyborders;
  };

  aerospaceApp = "${pkgs.aerospace}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace";
in
{
  home.activation.teardownDarwinDesktopXdgTrees = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    rm -rf "${config.xdg.configHome}/borders"
  '';

  home.packages = with pkgs; [
    aerospace
    jankyborders
  ];

  xdg.configFile."aerospace/aerospace.toml" = {
    source = aerospaceToml;
    force = true;
  };

  xdg.configFile."borders" = {
    source = dotfilesRoot + "/config/borders";
    recursive = true;
    force = true;
  };

  # Run the app binary (long-lived), not `open`, so KeepAlive does not respawn a finished `open` process.
  launchd.agents.org-nix-aerospace = {
    enable = true;
    config = {
      Label = "org.nix-aerospace";
      ProgramArguments = [ aerospaceApp ];
      RunAtLoad = true;
      KeepAlive = true;
      WorkingDirectory = config.home.homeDirectory;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/aerospace.stdout.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/aerospace.stderr.log";
      EnvironmentVariables = {
        HOME = config.home.homeDirectory;
        USER = username;
        # So exec callbacks and CLI spawned from the app see the same aerospace as HM.
        PATH = lib.makeBinPath [ pkgs.aerospace ];
      };
    };
  };
}
