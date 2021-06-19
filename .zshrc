export EDITOR='nvim'

alias uniDatabase='ssh jpy19@linux.cosc.canterbury.ac.nz -L 3306:db2.csse.canterbury.ac.nz:3306 -N'

source ~/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

# Plugins
export NODE_PATH='/usr/local/lib/node_modules'
export PATH="/usr/local/opt/python@3.9/libexec/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

bindkey -v '^?' backward-delete-char
zplug "jeffreytse/zsh-vi-mode"

# Keybinds
source ~/scripts/sourceScripts/aliases.sh

clear; coffeefetch
