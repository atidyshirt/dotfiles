{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      _1password-cli
      cargo
      claude-code
      clippy
      devenv
      fzf
      go
      jq
      kind
      lazydocker
      lazygit
      lua5_4
      nodejs_24
      pandoc
      python313
      ripgrep
      rust-analyzer
      rustc
      rustfmt
      tectonic
      tmux
      zig
      zsh
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      _1password-gui
      raycast
      orbstack
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      kubectl
      nerd-fonts.fira-code
    ];
}
