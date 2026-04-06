{
  description = "Dotfiles (macOS + NixOS-oriented)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    _inputs@{ self, nixpkgs, home-manager, darwin, ... }:
    let
      inherit (nixpkgs) lib;
      username = "jordanp";
      dotfilesRoot = self + "/users/jordanp";
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      darwinConfigurations."${username}@macbook" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit dotfilesRoot username; };
        modules = [
          ./machines/darwin.nix
          home-manager.darwinModules.home-manager
        ];
      };

      homeConfigurations = let
        linuxModule = { lib, ... }: {
          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "1password"
              "1password-cli"
              "1password-gui"
            ];
        };
        mkLinux =
          system:
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            extraSpecialArgs = {
              inherit dotfilesRoot username;
            };
            modules = [ linuxModule ] ++ import ./machines/nixos.nix;
          };
      in
      {
        "${username}@generic-linux" = mkLinux "x86_64-linux";
        "${username}@generic-linux-aarch64" = mkLinux "aarch64-linux";
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
