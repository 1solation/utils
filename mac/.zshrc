# shorten shell prompt
PROMPT="%n %1~ %# "
# load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# add and load separate alias file
source $HOME/.aliases
# set default editor to Vim
export EDITOR=vim
# set zsh asdf path
. /usr/local/opt/asdf/libexec/asdf.sh
# add plugins
plugins=(asdf brew)
