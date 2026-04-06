# Linux-only HM modules (mirrors config/{hypr,rofi,…}; via machines/nixos.nix).
{
  imports = [
    ./hypr/default.nix
    ./rofi/default.nix
    ./picom/default.nix
    ./libinput-gestures/default.nix
  ];
}
