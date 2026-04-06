{ dotfilesRoot, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile."nvim".source = "${dotfilesRoot}/config/nvim";
}
