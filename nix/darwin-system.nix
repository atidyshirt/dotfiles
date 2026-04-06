# nix-darwin system module — change `username` in flake.nix if needed
{ pkgs, username, ... }:
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
}
