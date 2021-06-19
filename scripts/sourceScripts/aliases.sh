# Alias Config File
alias ios='open -a Simulator'
alias todo='vi ~/.config/.todo.md'

# General shortcuts
alias copy='cp-improved'
alias remove='rm -rf'
alias move='mv -f'
alias send='ffsend upload'
alias zz='exit'
alias clear='printf "\033c"'

# tmux attatch
alias ts='tmux a || tmux'

## `cd` changes
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -G'

# Neovim + Coding
alias vi='nvim'
alias gvi='neovide'
alias svi='sudo nvim'
alias tg='lazygit'
alias gc='git clone'

# Config Files
alias arc='vi ~/scripts/sourceScripts/aliases.sh'
alias trc='vi ~/.config/kitty/kitty.conf'
alias zrc='vi ~/.zshrc'
alias src='vi ~/.skhdrc'
alias yrc='vi ~/.yabairc'
alias qsa='source ~/.zshrc'

#Asthetic aliases
alias wall='cd ~/.wallpaper && sh ~/scripts/themeScripts/gruvTheme.sh ./ `ls -d ~/.wallpaper/* | xargs -n 1 basename | fzf` && cd -'
alias light='sh ~/scripts/themeScripts/light-theme.sh'
alias dark='sh ~/scripts/themeScripts/dark-theme.sh'

# Functions
o(){
	cd `cat /Users/$USER/scripts/work_paths | fzf --height=20% --border=sharp `
}

lc() {
  find . -name "*.$*" -exec wc -l '{}' \; | awk '{ SUM += $0; } END { print SUM; }'
}
