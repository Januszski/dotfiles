#!/usr/bin/env bash
set -e

echo "Starting installation of dependencies..."

# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

# Install required packages
for pkg in ghostty zsh neovim fzf tmux stow; do
  if brew list "$pkg" &>/dev/null; then
    echo "$pkg already installed."
  else
    echo "Installing $pkg..."
    brew install "$pkg"
  fi
done

# Install Nerd Font via Homebrew Cask Fonts
if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
  echo "JetBrains Mono Nerd Font already installed."
else
  echo "Installing JetBrains Mono Nerd Font..."
  brew tap homebrew/cask-fonts
  brew install --cask font-jetbrains-mono-nerd-font
fi

# Now run stow to symlink your dotfiles
# Assumes you run this script from the root directory of your dotfiles repo,
# and that each dotfile set is in its own subfolder (e.g. neovim/, tmux/, zsh/)
if command -v stow &>/dev/null; then
  echo "Running GNU Stow to symlink dotfiles..."
  # Example: stow all folders except README or scripts
  # Customize the list of folders you want to stow:
  DOTFOLDERS=(neovim tmux zsh fzf ghostty)

  for folder in "${DOTFOLDERS[@]}"; do
    if [ -d "$folder" ]; then
      echo "Stowing $folder..."
      stow "$folder"
    else
      echo "Folder $folder not found, skipping."
    fi
  done
else
  echo "Stow not installed, skipping symlink step."
fi

echo "Done! Your dependencies are installed and dotfiles are linked."
