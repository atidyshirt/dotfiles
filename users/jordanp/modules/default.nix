{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../packages.nix
    ./shell.nix
    ./atuin/default.nix
    ./git/default.nix
    ./nvim/default.nix
    ./1password/default.nix
    ./tmux/default.nix
    ./wezterm/default.nix
  ];

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = lib.mkIf pkgs.stdenv.isLinux true;

  home = {
    inherit username;
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
    stateVersion = "24.11";
    sessionVariables = {
      EDITOR = "nvim";
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";
    };
  };
}
