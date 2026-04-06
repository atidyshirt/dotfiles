{ pkgs, dotfilesRoot, ... }:
{
  home.packages = [ pkgs.wezterm ];

  xdg.configFile."wezterm" = {
    source = dotfilesRoot + "/config/wezterm";
    recursive = true;
  };
}
