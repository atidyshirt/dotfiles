#!/bin/bash

warnnvim() {
  echo "Please install neovim"
  exit
}

warnnode() {
  echo "Please install node"
  exit
}

warngit() {
  echo "Please install git"
  exit
}

warntmux() {
  echo "Please install tmux"
  exit
}

warnzsh() {
  echo "Please install zsh"
  exit
}

warnkitty() {
  echo "Please install kitty"
  exit
}

installFonts() {
  echo "[-] Download fonts [-]"
  echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
  echo "[-] Installing fonts [-]"
  unzip FiraCode.zip -d ~/.local/share/fonts
  fc-cache -fv
}

packerhack() {
  mv $HOME/.config/nvim/packer_install.lua $HOME/.config/nvim/lua/vapour/user-config/init.lua
}

movetmux() {
  mv $HOME/.tmux.conf $HOME/tmux.old
  mv $HOME/.config/nvim/tmux/.tmux.conf $HOME/.tmux.conf
  mkdir $HOME/.bin
  mv $HOME/.config/nvim/tmux/t $HOME/.bin
  echo "Your existing tmux config has been changed to tmux.old"
}

movezsh() {
  mv $HOME/.zshrc $HOME/zshrc.old
  mv $HOME/.config/nvim/zsh/.zshrc $HOME/.zshrc
  mkdir $HOME/dev_scripts
  mv $HOME/.config/nvim/zsh/aliases $HOME/dev_scripts/aliases
  echo "Your existing zsh config has been changed to zsh.old"
}

movekitty() {
  mv $HOME/.config/kitty/kitty.conf $HOME/.config/kitty/kitty.old
  mv $HOME/.config/nvim/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
  mv $HOME/.config/nvim/kitty/gruvbox.conf $HOME/.config/kitty/gruvbox.conf
  mv $HOME/.config/nvim/kitty/github_light.conf $HOME/.config/kitty/github_light.conf
  mv $HOME/.config/nvim/kitty/github_dark.conf $HOME/.config/kitty/github_dark.conf
  echo "Your existing kitty config has been changed to kitty.old"
}

installDependencies() { # NOTE: NOT CALLED BY DEFAULT
  # Install homebrew package manager
  # NOTE: THIS IS FOR LINUX install
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
  # FOR MAC
  # which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install ohmyzsh
  which ohmyzsh || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Install fzf for <C-t> tmux
  which fzf || brew install fzf
  which lazygit || brew install lazygit
  which lazydocker || brew install lazydocker
}

changedirname() {
  mv $HOME/.config/nvim $HOME/.config/neovim.old
  echo "Your existing nvim config has been changed to neovim.old"
  git clone git@github.com:atidyshirt/nvim.git $HOME/.config/nvim
  packerhack
  nvim +PackerSync
  rm -rf $HOME/.config/nvim/FiraCode*
}

clonerepo() {
  echo "[-] Cloning repo [-]"
  git clone https://github.com/atidyshirt/nvim $HOME/.config/nvim
}

which nvim >/dev/null && echo "[-] Neovim is installed [-]" && installFonts || warnnvim
which node >/dev/null && echo "[-] Node is installed [-]" || warnnode
which tmux >/dev/null && echo "[-] Tmux is installed [-]" && movetmux || warntmux
which zsh >/dev/null && echo "[-] Zsh is installed [-]" && movezsh || warnzsh
which kitty >/dev/null && echo "[-] Kitty is installed [-]" && movekitty || warnkitty
which git >/dev/null && echo "[-] Git is installed [-]" || warngit

[ -d "$HOME/.config/nvim" ] && changedirname || clonerepo
