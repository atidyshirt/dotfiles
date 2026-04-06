{ dotfilesRoot, ... }:
{
  xdg.configFile."hypr" = {
    source = dotfilesRoot + "/config/hypr";
    recursive = true;
  };
}
