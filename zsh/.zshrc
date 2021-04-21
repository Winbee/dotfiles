# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Add brew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

function addPath(){
  test -e $1 && export PATH=$PATH:$1
}

## Add Home Bin
addPath "$HOME/bin"
## Add python libs
addPath "$HOME/Library/Python/3.9/bin"

# Lazyload NVM
lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  ## [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  . $(brew --prefix nvm)/nvm.sh
  nvm use default
}

nvm() {
  lazynvm
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

yarn() {
  lazynvm
  yarn $@
}


alias ll='ls -lah'
alias ping='prettyping --nolegend'
alias top="sudo htop" # alias top and fix high sierra bug
alias help='tldr'
alias k='kubectl'
alias cls="clear"
alias h="history"
alias doco="docker-compose"

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

alias weather='curl -4 http://wttr.in'


# Don't forget to put tat in the $PATH
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

# Unbind "^S" history-incremental-pattern-search-forwar to be able to use it in tmux
bindkey -r "^S"
# Emacs mode
bindkey -e
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
