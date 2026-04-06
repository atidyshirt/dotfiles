# Magical shell history — https://atuin.sh/ (config mirrors users/jordanp/config/atuin/config.toml).
{ lib, dotfilesRoot, ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.importTOML (dotfilesRoot + "/config/atuin/config.toml");
  };
}
