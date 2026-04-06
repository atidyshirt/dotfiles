{ dotfilesRoot, ... }:
{
  xdg.configFile."libinput-gestures.conf".source =
    dotfilesRoot + "/config/libinput-gestures.conf";
}
