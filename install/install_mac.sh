# Installing homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Using Stow to stow both the standard and macOS dotfiles
gh repo clone atidyshirt/dotfiles
cd dotfiles
stow -t=$HOME standard mac

# Install dependencies from Brewfile in ~/ directory
cd
brew bundle

