{ dotfilesRoot, ... }:
{
  xdg.configFile."picom.conf".source = dotfilesRoot + "/config/picom.conf";
}
