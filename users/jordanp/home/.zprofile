# Login shell (sourced before .zshrc). Managed in-repo; Home Manager can install this — see users/jordanp/modules/shell.nix.
# Intentionally no Homebrew: use Nix / nix-darwin for CLI tools.

export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$HOME/.1password/agent.sock}"

# Optional: merge kubeconfigs (add paths as needed)
if [[ -f "$HOME/.kube/config" ]]; then
  export KUBECONFIG="$HOME/.kube/config"
  [[ -f "$HOME/.kube/home-server.kubeconfig" ]] && KUBECONFIG="$KUBECONFIG:$HOME/.kube/home-server.kubeconfig"
fi

# User-local executables (outside Nix)
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
case ":$PATH:" in
  *":$HOME/.bin:"*) ;;
  *) export PATH="$HOME/.bin:$PATH" ;;
esac
