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
              "claude-code"
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
      apps = forAllSystems (pkgs: {
        sys = {
          type = "app";
          program = "${pkgs.writeShellScript "sys" ''
            set -e

            cmd="''${1:-}"
            shift || true

            # Re-resolve the flake from the live checkout (not the store path
            # baked in at build time) and always pull in git submodules -
            # a clean tree otherwise silently drops submodule content
            # (e.g. the nvim config), since git submodules are commit
            # pointers, not blobs, in the superproject's git history.
            flake_ref() {
              echo "$(git rev-parse --show-toplevel)?submodules=1"
            }

            case "$cmd" in
              rebuild)
                case "$(uname -s)" in
                  Darwin)
                    # darwin-rebuild defaults to darwinConfigurations.$(hostname),
                    # which won't match unless this Mac is literally named
                    # "${username}@macbook" - pin the attr explicitly instead.
                    exec sudo darwin-rebuild switch --flake "$(flake_ref)#${username}@macbook"
                    ;;
                  Linux)
                    exec sudo nixos-rebuild switch --flake "$(flake_ref)"
                    ;;
                esac
                ;;

              update)
                exec nix flake update --flake "$(git rev-parse --show-toplevel)"
                ;;

              gc)
                exec nix store gc "$@"
                ;;

              clean)
                exec nix-collect-garbage -d "$@"
                ;;

              show)
                exec nix flake show "$(flake_ref)"
                ;;

              *)
                echo "Usage: sys {rebuild|update|gc|clean|show}"
                exit 1
                ;;
            esac
          ''}";
        };
      });
    };
}
