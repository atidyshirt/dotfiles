{ dotfilesRoot, ... }:
{
  xdg.configFile."rofi" = {
    source = dotfilesRoot + "/config/rofi";
    recursive = true;
  };
}
