#!/usr/bin/env bash
# Bootstrap chezmoi on a fresh machine

set -euo pipefail

REPO="Subbeh/dots.git"

case "$(uname -s)" in
  Darwin) SOURCE_DIR="$HOME/workspace/chezmoi" ;;
  Linux) SOURCE_DIR="/data/workspace/chezmoi" ;;
  *)
    echo "Unsupported OS" >&2
    exit 1
    ;;
esac

# Install chezmoi if missing
if ! command -v chezmoi &>/dev/null; then
  echo "==> Installing chezmoi..."
  case "$(uname -s)" in
    Darwin) brew install chezmoi ;;
    Linux) sudo pacman -Syu --needed --noconfirm chezmoi ;;
  esac
fi

chezmoi init --apply --source "$SOURCE_DIR" "$REPO"
