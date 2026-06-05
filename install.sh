#!/usr/bin/env bash
# Bootstrap chezmoi on a fresh machine

set -euo pipefail

REPO="Subbeh/dots.git"

case "$(uname -s)" in
  Darwin) SOURCE_DIR="${SOURCE_DIR:-$HOME/workspace/chezmoi}" ;;
  Linux) SOURCE_DIR="${SOURCE_DIR:-/data/workspace/chezmoi}" ;;
  *)
    echo "Unsupported OS" >&2
    exit 1
    ;;
esac

install_darwin() {
  if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install --quiet age bitwarden-cli chezmoi
}

install_linux() {
  sudo pacman -Syu --needed --noconfirm age bitwarden-cli chezmoi
}

echo "==> Installing prerequisites..."
case "$(uname -s)" in
  Darwin) install_darwin ;;
  Linux) install_linux ;;
esac

# export GPG_TTY=$(tty)
# export BITWARDENCLI_APPDATA_DIR="${BITWARDENCLI_APPDATA_DIR:-$HOME/.local/share/bitwardencli}"

echo "==> Logging in to Bitwarden..."
if [[ -z "${BW_SESSION:-}" ]]; then
  if ! bw login --check &>/dev/null; then
    BW_SESSION="$(bw login --raw)" || {
      echo "Bitwarden login failed" >&2
      exit 1
    }
  else
    BW_SESSION="$(bw unlock --raw)" || {
      echo "Bitwarden unlock failed" >&2
      exit 1
    }
  fi
  if [[ -z "${BW_SESSION:-}" ]]; then
    echo "Failed to obtain Bitwarden session" >&2
    exit 1
  fi
fi
export BW_SESSION

bw sync

chezmoi init --apply --source "$SOURCE_DIR" "$REPO"
