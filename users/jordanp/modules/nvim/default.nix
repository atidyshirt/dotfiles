{ config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = false;
    sideloadInitLua = true;
  };
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/projects/neovim";

  assertions = [
    {
      assertion = builtins.pathExists "${config.home.homeDirectory}/projects/neovim";
      message = ''
        ~/projects/neovim is missing - clone it before rebuilding:
          git clone git@github.com:atidyshirt/neovim.git ~/projects/neovim
      '';
    }
  ];
}
