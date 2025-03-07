xcode-select --install
# for intel macs
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# for m1/arm macs
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew install --cask iterm2 # update iterm2 settings -> colors, keep directory open new shell, keyboard shortcuts
brew install bash # latest version of bash
brew install git
brew install --cask spectacle #window management tool similar to windows os
brew install --cask alfred # remove spotlight keyboard shortcut and set CMD+space to launch alfred
brew install --cask firefox
# bpytop for monitoring system level metrics on device
brew install bpytop
# install GitHub CLI
brew install gh
# run the following to authenticate with GitHub account interactively
gh auth login 
# set default editor got gh
gh config set editor vim
# install nvm/node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# reload terminal, may get nvm is not a command error
# if above error occurs if in zsh, cd ~, vi .zshrc and add in source lines from snippet in readme located at https://github.com/nvm-sh/nvm 
nvm install stable
mkdir ~/workspace
npm install -g eslint liveserver
brew install --cask visual-studio-code
# update vscode settings & install extensions 
# add vs code extensions to txt file and then run
while read line; do code --install-extension "$line";done < extensions.txt
# install the best cli tool out there for when you get a command wrong
# if you have warp terminal, you don't need thefuck
brew install thefuck
# download & install asdf version manager
brew install asdf &&  echo "plugins=(asdf)" >> ~/.zshrc && source ~/.zshrc
# for kubernetes
brew install kubernetes-cli
brew install kubectx
brew install helm
# for kafka
brew install kcat
