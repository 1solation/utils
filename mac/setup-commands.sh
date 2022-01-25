xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install --cask iterm2 # update iterm2 settings -> colors, keep directory open new shell, keyboard shortcuts
brew install bash # latest version of bash
brew install git
brew install --cask spectacle #window management tool similar to windows os
brew install --cask alfred # remove spotlight keyboard shortcut and set CMD+space to launch alfred
brew install --cask firefox
# install nvm/node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install stable
mkdir ~/workspace
npm install -g lite-server eslint
brew install --cask visual-studio-code
# update vscode settings & install extensions 
