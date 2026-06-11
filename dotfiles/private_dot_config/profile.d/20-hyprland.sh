#!/bin/sh

if [ "$PROFILE_OS" = "linux" ]; then
  # Reset HYPRLAND_INSTANCE_SIGNATURE to newest Hyprland instance
  update_hyprland_signature() {
    # if [ "$HYPRLAND_INSTANCE_SIGNATURE" != "" ]; then
    newest_socket="$(ls -t "$XDG_RUNTIME_DIR"/hypr/*/.socket.sock 2>/dev/null | head -1)"
    if [ "$newest_socket" != "" ]; then
      export HYPRLAND_INSTANCE_SIGNATURE="$(basename "$(dirname "$newest_socket")")"
    fi
    # fi
  }
  update_hyprland_signature

  # hyprland
  alias hl="uwsm check may-start && uwsm start hyprland-uwsm.desktop"
  alias hyprlogs='less $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 1)/hyprland.log'
  alias hyprdir='cd $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/'
  alias hyprstop='uwsm stop'
  alias hyprkill='loginctl terminate-session 1'
  alias hyprnuke='loginctl terminate-user ""'
fi
