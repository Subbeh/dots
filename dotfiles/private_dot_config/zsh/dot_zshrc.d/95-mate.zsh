#!/bin/zsh

if [ "$PROFILE_OS" = "darwin" ]; then
  _bin=${PROJECT_DIR}/statemate/dist/mate-darwin-arm64
elif [ "$PROFILE_OS" = "linux" ]; then
  _bin=${PROJECT_DIR}/statemate/dist/mate-linux-amd64
fi

source <($_bin completion zsh)
mate() {
  $_bin "$@"
}
