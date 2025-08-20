#!/bin/sh
cd ~/Documents/3_resources/dotfiles

# packages you likely want
pkgs=(nvim zellij starship wezterm ghostty karabiner sketchybar nushell nix hammerspoon skhd tmux ssh zsh atuin aerospace)

# helper that fixes conflicts automatically
fix_pkg() {
  local pkg="$1"
  if ! stow "$pkg"; then
    # if target exists but isn’t a stow-owned link, adopt it
    stow --adopt "$pkg"
    git add -A && git commit -m "stow(adopt): $pkg" || true
    stow "$pkg"
  fi
}
for p in "${pkgs[@]}"; do fix_pkg "$p"; done

chmod 600 ~/.ssh/config 2>/dev/null || true
