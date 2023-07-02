eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(gh completion -s zsh)"

# paths
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" 
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH" 
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export CPATH="/opt/homebrew/include:$CPATH:$CONAN_INCLUDE_DIRS"
export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
export PATH="/usr/local/texlive/2022/bin:$PATH"
export PATH=$PATH:/home/jordanp/.spicetify

