# macOS (nix-darwin)

macOS uses **nix-darwin** with **Home Manager**. The flake target is
**`jordanp@macbook`** (see [Repository structure](../structure.md)). System
configuration is `machines/darwin.nix`; it imports shared Home Manager modules
plus `users/jordanp/modules/darwin.nix` (SketchyBar, AeroSpace, and other
macOS-only pieces).

## Prerequisites

1.  Install **Nix** with **flakes** (for example the
    [Determinate installer](https://github.com/DeterminateSystems/nix-installer)).
2.  Clone this repository and run **`git submodule update --init --recursive`**
    if you use the Neovim submodule.
3.  Edit **`flake.nix`** if you need a different **`username`** or Mac
    **`system`** (`aarch64-darwin` vs `x86_64-darwin`).

## Apply this flake

### First Time Building

`darwin-rebuild` is often **not** on `PATH` (and `sudo` uses root’s Nix
config). Use **`nix run`** with the **same nix-darwin revision as `flake.lock`**:

```bash
cd /path/to/dotfiles

REV=$(jq -r '.nodes.darwin.locked.rev' flake.lock)
sudo nix run "github:LnL7/nix-darwin/${REV}#darwin-rebuild" -- switch --flake '.#jordanp@macbook'
```

If **`sudo nix`** fails with flakes disabled for root, add
**`--extra-experimental-features 'nix-command flakes'`** after `sudo nix`, or
put **`extra-experimental-features = nix-command flakes`** in
**`/etc/nix/nix.conf`**.

The **`$HOME` is not owned by you** warning under `sudo` is normal.

After you change this repo, run the same two lines again from the repo root (no
`jq` shortcut: copy **`rev`** from **`flake.lock`** → **`nodes.darwin.locked`**).

### Subsequent Rebuilds

Now that we have installed the `nix-darwin` flake, and our system for the first time, subsequent builds
can be rebuilt via the following commands:

```bash
sudo darwin-rebuild switch --flake '.#jordanp@macbook'
```

## Sanity build (no `sudo`, no switch)

```bash
nix build '.#darwinConfigurations."jordanp@macbook".system'
```

## See also

*   [Documentation index](../index.md)
*   [Repository structure](../structure.md)
