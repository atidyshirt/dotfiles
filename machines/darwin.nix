# nix-darwin: system + Home Manager user profile (Darwin-only HM imports).
{
  config,
  lib,
  pkgs,
  dotfilesRoot,
  username,
  ...
}:
{
  system.stateVersion = 5;
  system.primaryUser = username;

  # WezTerm, SketchyBar, and other UI: Fira Code Nerd Font (matches users/jordanp/config/wezterm + sketchybar).
  fonts.packages = [ pkgs.nerd-fonts.fira-code ];

  # 1Password GUI is unfree in nixpkgs
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (pkgs.lib.getName pkg) [
      "1password"
      "1password-cli"
      "1password-gui"
      "orbstack"
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.extraSpecialArgs = {
    inherit dotfilesRoot username;
    sketchybarConfig = ../users/jordanp/config/sketchybar;
  };
  home-manager.users.${username} = {
    imports = [
      ../users/jordanp/modules/default.nix
      ../users/jordanp/modules/darwin.nix
    ];
  };
}
