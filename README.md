# dotfiles-gwyn
Dotfiles for my desktop  PC running Arch Linux.

```sh
git clone --bare git@github.com:olliebun/dotfiles-gwyn.git ~/.dotfiles
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dgit config status.showUntrackedFiles no
```

Paired with [`dotfiles-estoc`](https://github.com/olliebun/dotfiles-estoc).
