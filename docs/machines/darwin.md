# System Setup (macOS + Linux)

This repository is managed using (macOS) and NixOS/Home Manager (Linux).

All system operations are exposed through a unified CLI:

```bash
nix run .#sys <command>
````

This replaces manual use of:

* `darwin-rebuild`
* `nixos-rebuild`
* manual flake revision handling

---

# Prerequisites

## 1. Install Nix

Install Nix with flakes enabled (recommended: Determinate installer).

Ensure flakes are enabled:

```bash
nix --version
```

---

## 2. Clone repository

```bash
git clone <repo-url> ~/projects/dotfiles
cd ~/projects/dotfiles
```

(Optional if used)

```bash
git submodule update --init --recursive
```

---

# First-time setup

Run the unified system command:

```bash
nix run .#sys rebuild
```

This will:

* detect your OS (macOS or Linux)
* apply the correct system configuration
* activate the flake-defined environment

---

# Daily workflow

## Rebuild system

```bash
nix run .#sys rebuild
```

## Update inputs

```bash
nix run .#sys update
```

## Garbage collect store

```bash
nix run .#sys gc
```

## Clean aggressively

```bash
nix run .#sys clean
```

## Inspect flake outputs

```bash
nix run .#sys show
```

---

## Initial Bootstrapping

```bash
REV=$(jq -r '.nodes.darwin.locked.rev' flake.lock)
sudo nix run "github:LnL7/nix-darwin/${REV}#darwin-rebuild" -- switch --flake .#jordanp@macbook
```

---

# Sanity check (no activation)

Build system without switching:

```bash
nix build .#darwinConfigurations."jordanp@macbook".system   # macOS
```
