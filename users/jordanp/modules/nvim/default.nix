{ dotfilesRoot, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = false;
    # Provider disables go through the wrapper instead of writing
    # ~/.config/nvim/init.lua, which would conflict with the directory symlink.
    sideloadInitLua = true;
  };

  xdg.configFile."nvim".source = dotfilesRoot + "/config/nvim";
}
