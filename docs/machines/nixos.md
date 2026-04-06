# Linux (Home Manager)

This repo’s Linux path is driven by **`machines/nixos.nix`**, which lists extra
Home Manager imports for **standalone** `home-manager switch` (not a full
NixOS system configuration in this flake). Flake targets **`jordanp@generic-linux`**
and **`jordanp@generic-linux-aarch64`** map to **x86_64-linux** and
**aarch64-linux** (see [Repository structure](../structure.md)).

## Prerequisites

1.  Install **Nix** with **flakes** (for example the
    [Determinate installer](https://github.com/DeterminateSystems/nix-installer)).
2.  Clone this repository and run **`git submodule update --init --recursive`**
    if you use the Neovim submodule.
3.  Edit **`flake.nix`** if you need a different **`username`**.

## Apply Home Manager

On the Linux machine:

```bash
home-manager switch --flake '/path/to/dotfiles#jordanp@generic-linux'
```

Use **`jordanp@generic-linux-aarch64`** on aarch64. On the first run, if files
would be overwritten:

```bash
home-manager switch -b hm-backup --flake '/path/to/dotfiles#jordanp@generic-linux'
```

Linux-only modules (Hyprland, rofi, picom, libinput-gestures, and similar) are
pulled in via `users/jordanp/modules/linux.nix` through `machines/nixos.nix`.

## Bump inputs

After `nix flake update` in the repo, run the **`home-manager switch`** command
above again.

## See also

*   [Documentation index](../index.md)
*   [Repository structure](../structure.md)
