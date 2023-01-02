source ~/.config/zsh/zsh-snap/znap.zsh
export EDITOR='nvim'

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
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

# Scripts
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export CPATH="/opt/homebrew/include:$CPATH:$CONAN_INCLUDE_DIRS"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"

# Keybinds
source ~/dev_scripts/aliases
bindkey -v

if [[ -f .projectconfig && -r .projectconfig ]]; then
    source .projectconfig &> /dev/null
elif [[ -f ../.projectconfig && -r ../.projectconfig ]]; then
    cd .. && source .projectconfig && cd - &> /dev/null
fi
export PATH=$PATH:/home/jordanp/.spicetify

# 7081
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# Plugins
znap source zsh-users/zsh-autosuggestions
bindkey '^[[Z' autosuggest-accept 
znap source zsh-users/zsh-syntax-highlighting

