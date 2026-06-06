#!/bin/sh

if [ -d "$WORKSPACE_DIR/chezmoi/dotfiles" ]; then
  DOT_DIR="$WORKSPACE_DIR/chezmoi/dotfiles"
fi
export DOT_DIR

alias cd.="cd \${DOT_DIR:?not set}"
alias ds='chezmoi status'
alias ddiff='chezmoi diff'
alias da='chezmoi apply'
alias dad='chezmoi apply --dry-run -v'
alias de='chezmoi edit'
alias dup='chezmoi update'
alias ddoc='chezmoi doctor'
