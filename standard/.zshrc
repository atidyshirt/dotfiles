export EDITOR='nvim'

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

# Linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" 
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH" 
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# Autocomplete
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"

# Scripts
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Keybinds
source ~/dev_scripts/aliases
bindkey -v

if [[ -f .projectconfig && -r .projectconfig ]]; then
    source .projectconfig &> /dev/null
elif [[ -f ../.projectconfig && -r ../.projectconfig ]]; then
    cd .. && source .projectconfig && cd - &> /dev/null
fi
export PATH=$PATH:/home/jordanp/.spicetify
