{
  pkgs,
  dotfilesRoot,
  username,
  inputs,
  ...
}:
{
  system.stateVersion = 5;
  system.primaryUser = username;

  fonts.packages = [ pkgs.nerd-fonts.fira-code ];

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (pkgs.lib.getName pkg) [
      "1password"
      "1password-cli"
      "1password-gui"
      "orbstack"
      "claude-code"
      "raycast"
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 3;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 4;
      Minute = 0;
    };
  };

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.extraSpecialArgs = {
    inherit dotfilesRoot username inputs;
    sketchybarConfig = ../users/jordanp/config/sketchybar;
  };
  home-manager.users.${username} = {
    imports = [
      ../users/jordanp/modules/default.nix
      ../users/jordanp/modules/darwin.nix
    ];
  };
}
