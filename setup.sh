#!/usr/bin/env bash
set -euo pipefail

PACKS=(nvim zellij starship wezterm ghostty karabiner sketchybar nushell nix hammerspoon skhd tmux ssh zsh atuin aerospace)

for p in "${PACKS[@]}"; do
  if ! stow "$p"; then
    echo "⚠️ Conflict with $p — adopting existing files..."
    stow --adopt "$p"
    git add -A && git commit -m "stow(adopt): $p" || true
  fi
done

chmod 600 "$HOME/.ssh/config" 2>/dev/null || true
