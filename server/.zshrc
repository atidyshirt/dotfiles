export EDITOR='nvim'
export VMUX_EDITOR='nvim'
export VMUX_REALEDITOR_NVIM='/opt/homebrew/bin/nvim'

# prefer the `neovim` .config dir if it exists over `nvim`
if [ -d "$HOME/.config/neovim" ]; then
    export NVIM_APPNAME="neovim"
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# completion
autoload -Uz compinit
compinit

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

set -o vi
bindkey -v
source ~/dev_scripts/aliases

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
bindkey -M viins '^R' history-incremental-search-backward
