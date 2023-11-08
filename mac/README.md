# mac dev set up

## Contents

- [warp](/warp): Things related to the Warp terminal
    - [themes](/warp/themes): Collection of custom themes for the Warp terminal
        - [retrowave.jpg](/warp/themesretrowave.jpg): Background image for custom theme
        - [retrowave.yaml](/warp/themesretrowave.yaml): Custom theme yaml
- [.aliases](.aliases): List of useful aliases for commands
- [.zshrc](.zshrc): Used to configure the zsh shell
- [extensions.txt](extensions.txt): List of VS Code extensions used
- [kotlin-setup.md](kotlin-setup.md): README on setting up the Kotlin Programming langauge and tooling surrounding it
- [setup-commands.sh](setup-commands.sh): List of commands to run when setting up for the first time
- [vscode-settings.json](vscode-settings.json): Collection of settings used for VS Code

## Usage

Checkout the [set up script](setup-commands.sh) for the actual commands to run, or download the whole file and run `sh setup-commands.sh`.

 - Install homebrew/iterm/bash via setup script above
 - Install Warp terminal too located at https://www.warp.dev/ 
 - OSX Productivity:
	 - Window Management (Spectacle) / Replace Quick Launcher (Alfred)
 - OSX Settings:
	 - Enable "Hot Corners"
		 - `System Preferences > Mission Control`
		 - `Hot Corners`, top right Notifications Centre, bottom right Desktop
	 - Remove non-useful apps, minimise & hide Dock 
	 - Update Finder settings 
		 - `cmd + shift + h` for home dir then can drag & drop (or File > Add to sidebar)
		 - Click on `Go` hold `option` and click library, drag & drop
	 - `Finder>Settings`
		 - `General` check hard disks and external disks
		 - `Advanced` keep folders on top, check both boxes
			- search in current folder, show filename extensions
		 - `Sidebar` uncheck tags
	 - `Finder>View`
		 - show status bar
		 - show tab bar
		 - show path bar
	- `Cmd + Shift + .` to show hidden files/folders
 - Web Browser Firefox
	 - Extensions:
		 - speed dial 2 (import my own settings.json)
		 - Bitwarden
		 - Grammarly
		 - FireFox Containers
		 - ReadAloud
		 - Video Speed Controller
		 - AdBlocker
		 - Grepper
	 - Settings `General`
		 - `command +,`
		 - Open previous windows & tabs
		 - Make default browser
		 - Always ask where to save files
	- Settings `Search`
		- Remove unwanted search shortcuts
		- Add/bookmark custom search shortcuts
		   - Such as gh (GitHub), so (StackOverflow), yt (YouTube), jira, stash/bitbucket, etc
	 - Settings
		 - Firefox Data Collection and Use, uncheck all
 - Install Bitwarden Desktop App
 - Install GitHub CLI
 - Install Node via NVM
	 - `nvm install node` for the latest version
	 - `nvm use node` to use the latest version
 - Add .alias file and .zshrc
 	 - this is inside the repo
 - Install VS Code
	 - Install extensions
- Install [Logi Options +](https://www.logitech.com/en-gb/software/logi-options-plus.html)
