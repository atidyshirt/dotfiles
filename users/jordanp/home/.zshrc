# Portable baseline for Nix + Home Manager.
# Starship prompt, completions, Nix-provided languages/CLIs: users/jordanp/modules/shell.nix + packages.nix (after this block).
[[ -f "$HOME/dev_scripts/aliases" ]] && source "$HOME/dev_scripts/aliases"
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

set -o vi
