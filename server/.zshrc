# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# NOTE: To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit; compinit
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh; antidote load

export EDITOR='nvim'
export VMUX_EDITOR='nvim'
export VMUX_REALEDITOR_NVIM='/opt/homebrew/bin/nvim'

# prefer the `neovim` .config dir if it exists over `nvim`
if [ -d "$HOME/.config/neovim" ]; then
    export NVIM_APPNAME="neovim"
fi

# jeffreytse/zsh-vi-mode requires zvm to be installed and set up
# zvm does some async execution that causes greif when setting up
# keybinds that are conflicting. in order to make things play nice
# we must load our keymaps after zvm is complete (this is a async hook)
function zvm_after_init() {
   bindkey -e
   set -o vi
   source ~/dev_scripts/aliases
}
