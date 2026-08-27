{
  inputs,
  pkgs,
  dotfilesRoot,
  ...
}:
{
  home.packages = [ inputs.workmux.packages.${pkgs.system}.default ];

  xdg.configFile."workmux/config.yaml".source = dotfilesRoot + "/config/workmux/config.yaml";
}
