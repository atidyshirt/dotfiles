# Install (this flake)

You need **Nix** with **flakes** ([Determinate installer](https://github.com/DeterminateSystems/nix-installer) or similar). Clone this repo and run **`git submodule update --init --recursive`** if you use the nvim submodule.

Edit **`flake.nix`** if you need a different **`username`** or Mac **`system`** (`aarch64-darwin` vs `x86_64-darwin`).

---

## macOS (nix-darwin)

`darwin-rebuild` is often **not** on `PATH` (and `sudo` uses root’s Nix config). Use **`nix run`** with the **same nix-darwin revision as `flake.lock`**:

```bash
cd /path/to/dotfiles

REV=$(jq -r '.nodes.darwin.locked.rev' flake.lock)
sudo nix run "github:LnL7/nix-darwin/${REV}#darwin-rebuild" -- switch --flake .#dotfiles-mac
```

If **`sudo nix`** fails with flakes disabled for root, add **`--extra-experimental-features 'nix-command flakes'`** after `sudo nix`, or put **`extra-experimental-features = nix-command flakes`** in **`/etc/nix/nix.conf`**.

The **`$HOME` is not owned by you** warning under `sudo` is normal.

**After you change this repo**, run the same two lines again from the repo root (no `jq` shortcut: copy **`rev`** from **`flake.lock`** → **`nodes.darwin.locked`**).

**Sanity build (no `sudo`, no switch):**

```bash
nix build .#darwinConfigurations.dotfiles-mac.system
```

---

## Linux (Home Manager only)

On the Linux machine:

```bash
home-manager switch --flake /path/to/dotfiles#jordanp@generic-linux
```

Use **`jordanp@generic-linux-aarch64`** on aarch64. First run, if files would be overwritten: **`home-manager switch -b hm-backup --flake …`**.

---

## Bump inputs

```bash
nix flake update
```

Then run the **macOS** or **Linux** command above again.
