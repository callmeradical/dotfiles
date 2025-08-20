#!/usr/bin/env bash
set -euo pipefail
PACKS=(nvim zellij starship wezterm ghostty karabiner sketchybar nushell nix hammerspoon skhd tmux ssh zsh atuin aerospace)
for p in "${PACKS[@]}"; do stow "$p"; done
chmod 600 "$HOME/.ssh/config" 2>/dev/null || true
