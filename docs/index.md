# Dotfiles documentation

Nix-based dotfiles for macOS (nix-darwin + Home Manager) and Linux (Home
Manager). Packages are declared once via flakes; older Stow + Homebrew flows
are removed.

## Documentation map

*   [macOS (nix-darwin)](machines/darwin.md) — install and apply the flake.
*   [Linux (Home Manager)](machines/nixos.md) — apply on x86_64 and aarch64.
*   [Repository structure](structure.md) — flake targets, module flow, and paths.

Flake apply names are **`jordanp@macbook`**, **`jordanp@generic-linux`**, and
**`jordanp@generic-linux-aarch64`** (see [structure.md](structure.md)).

## Related repositories

*   [jordanp-env](https://github.com/atidyshirt/jordanp-env) — a simpler, containerized terminal environment (Docker image and install script).
*   [neovim](https://github.com/atidyshirt/neovim) — standalone Neovim config; this repo includes it as a submodule at `users/jordanp/config/nvim` (see
    `.gitmodules`).

## Updating flake inputs

After changing inputs in `flake.nix`, refresh the lockfile and re-apply on each
machine:

```bash
nix flake update
```

Then run the macOS or Linux apply command from [machines/darwin.md](machines/darwin.md)
or [machines/nixos.md](machines/nixos.md).

## Showcase

**macOS**

![Mac Preview](../preview-mac.png)

**Linux**

![Linux Preview](../preview-linux.png)

## See also

*   [Google Markdown style guide](https://google.github.io/styleguide/docguide/style.html)
*   Legacy Brewfile snapshot: [Brewfile.mac-legacy](Brewfile.mac-legacy)
