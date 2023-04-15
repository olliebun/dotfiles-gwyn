# ~/.zhsrc
# Created 2023-04-11.
# For gwyn.

## HELPERS
log() {
  echo "$1" >&2
}

# ZSH
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# SYSTEM CONFIGURATION
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR=/usr/bin/nvim

# DOTFILES
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# SHELL ALIASES
alias dmesg="sudo dmesg"
alias ls="ls --color"
alias pacman="sudo pacman"
alias vim="nvim"

## ARCH LINUX
download_aur_package() {
  if [ "$#" -ne 1 ]; then
    echo "usage: download-aur-package PACKAGE" >&2
    exit 1
  fi

  package="$1"
  target="$HOME/src/aur/$package"

  if [ -d "$target" ]; then
    echo "$target exists" >&1
    exit 1
  fi

  (
    tempdir="$(mktemp -d)"

    cd "$tempdir"

    http --follow https://aur.archlinux.org/cgit/aur.git/snapshot/"$package".tar.gz > "$package".tar.gz
    tar -xf "$package".tar.gz
    mv "$package" "$target"
  )

  log "$target"
  cd "$target"
}

## ASDF
source ~/.asdf/asdf.sh

## AWS
export AWS_DEFAULT_REGION=ap-southeast-2
export AWS_VAULT_BACKEND=pass

## GO
export PATH=$PATH:$HOME/go/bin
