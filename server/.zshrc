export EDITOR='nvim'
export VMUX_EDITOR='nvim'
export VMUX_REALEDITOR_NVIM='/opt/homebrew/bin/nvim'

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '(%F{blue}%b%c%u%F{white})'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' •'
zstyle ':vcs_info:*' stagedstr ' +'
PROMPT='%(?.%F{green}λ.%F{red}! %?)%f [%B%F{240}%1~%f%b] '

# Keybinds
set -o vi
bindkey -v
source ~/dev_scripts/aliases

if [[ -f .projectconfig && -r .projectconfig ]]; then
    source .projectconfig &> /dev/null
elif [[ -f ../.projectconfig && -r ../.projectconfig ]]; then
    cd .. && source .projectconfig && cd - &> /dev/null
fi
