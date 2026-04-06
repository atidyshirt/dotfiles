{ lib, dotfilesRoot, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.importTOML (dotfilesRoot + "/config/atuin/config.toml");
  };
}
