{
  config,
  lib,
  pkgs,
  dotfilesRoot,
  ...
}:
let
  tpm = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "v3.1.0";
    sha256 = "18i499hhxly1r2bnqp9wssh0p1v391cxf10aydxaa7mdmrd3vqh9";
  };

  tmuxNvr = pkgs.fetchFromGitHub {
    owner = "daplay";
    repo = "tmux_nvr";
    rev = "27e5e72023ab8d43311e6a55a1d1b4295495521e";
    sha256 = "1567icwixkapnravdl0zsfrlrmi9lxk15h80l2qlr20gyff448s5";
  };
in
{
  home.activation.teardownTmuxConfigForHm = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    rm -rf "${config.xdg.configHome}/tmux"
  '';

  home.activation.teardownTmuxPluginsForHm = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    rm -rf "${config.home.homeDirectory}/.tmux/plugins"
  '';

  home.file.".tmux.conf".source = dotfilesRoot + "/home/.tmux.conf";

  xdg.configFile."tmux" = {
    source = dotfilesRoot + "/config/tmux";
    recursive = true;
    force = true;
  };

  home.file.".tmux/plugins/tpm" = {
    source = tpm;
    recursive = true;
  };

  home.file.".tmux/plugins/tmux-yank" = {
    source = "${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank";
    recursive = true;
  };

  home.file.".tmux/plugins/tmux_nvr" = {
    source = tmuxNvr;
    recursive = true;
  };

  home.file.".bin" = {
    source = dotfilesRoot + "/bin";
    recursive = true;
  };

  home.file.".Xresources" = lib.mkIf (!pkgs.stdenv.isDarwin) {
    source = dotfilesRoot + "/home/.Xresources";
  };
}
