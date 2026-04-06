# nix-darwin: system + Home Manager user profile (Darwin-only HM imports).
{
  config,
  lib,
  pkgs,
  dotfilesRoot,
  username,
  ...
}:
{
  imports = [ ../nix/darwin-system.nix ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.extraSpecialArgs = {
    inherit dotfilesRoot username;
    sketchybarConfig = ../users/jordanp/config/sketchybar;
  };
  home-manager.users.${username} = {
    imports = [
      ../users/jordanp/modules/default.nix
      ../users/jordanp/modules/darwin.nix
    ];
  };
}
