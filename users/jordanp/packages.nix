{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      tmux
      zsh
      lazygit
      lazydocker
      kind
      go
      jq
      lua5_4
      nodejs_24
      python313
      ripgrep
      fzf
      zig
      rustc
      cargo
      clippy
      rustfmt
      rust-analyzer
      _1password-cli
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      _1password-gui
      orbstack
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      kubectl
      nerd-fonts.fira-code
    ];
}
