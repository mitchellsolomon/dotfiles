#! /bin/zsh

# dotfiles
# git clone https://github.com/mitchellsolomon/dotfiles.git

# homebrew install
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "/Users/$(whoami)/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# oh my zsh install
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

aliases=(
  "brewup='brew update; brew upgrade; brew cleanup; brew doctor'"
)

for alias in "${aliases[@]}"; do
  alias_name=$(echo "$alias" | cut -d'=' -f1 | cut -d' ' -f2)
  if ! grep -q "alias $alias_name=" ~/.zprofile; then
    echo "alias $alias" >> ~/.zprofile
    echo "Added: alias $alias"
  else
    echo "Alias '$alias_name' already exists."
  fi
done

brew update
brew upgrade

casks=(
    "google-chrome"
    "notion"
    "1password"
    "iterm2"
    "raycast"
    "spotify"
    "discord"
    "plex"
    "visual-studio-code"
    "cleanmymac"
    "httpie"
    "vlc"
    "zoom"
    "cloudflare-warp"
    "warp"
    "arc"
    "steam"
    "minecraft"
    "docker"
)

# Loop through each cask and install it with Homebrew
for cask in "${casks[@]}"; do
    brew install --cask "$cask"
done

formulae=(
    "git"
    "wget"
    "nmap"
    "htop"
    "docker"
    "node"
    "pnpm"
    "gh"
    "httpie"
    "speedtest-cli"
    "imagemagick"
    "yt-dlp"
    "jq"
)

# loop through formulae and install
for formula in "${formulae[@]}"; do
    brew install "$formula"
done

brew cleanup
brew doctor

# download other apps
# Evo Control

# trackpad
defaults write -g com.apple.swipescrolldirection -bool NO
defaults write NSGlobalDomain com.apple.mouse.scaling -float "2"

# dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "mineffect" -string "scale"

# safari
defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# finder
defaults write com.apple.Finder AppleShowAllFiles true

# screenshots
mkdir "$HOME/Pictures/screenshots"
defaults write com.apple.screencapture location "~/Pictures/screenshots"

# restart
killall Dock
killall Finder

sudo shutdown -r now