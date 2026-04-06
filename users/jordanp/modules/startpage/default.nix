{ dotfilesRoot, config, lib, ... }:
{
  home.activation.teardownDarwinSafariStartpage = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
    rm -rf "${config.xdg.configHome}/startpage_osx"
  '';

  xdg.configFile."startpage_osx" = {
    source = dotfilesRoot + "/config/startpage_osx";
    recursive = true;
    force = true;
  };

  xdg.configFile."startpage_config.json".source = dotfilesRoot + "/config/startpage_config.json";
}
