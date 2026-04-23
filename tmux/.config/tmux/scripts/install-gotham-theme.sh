#!/usr/bin/env bash
# Symlink the Gotham theme into the tmux-tokyo-night plugin's theme directory.
# Run after TPM install (prefix + I).

PLUGIN_THEMES="$HOME/.tmux/plugins/tmux-tokyo-night/src/themes/gotham"
CUSTOM_THEME="$HOME/.config/tmux/themes/gotham.sh"

if [[ -d "$HOME/.tmux/plugins/tmux-tokyo-night/src/themes" ]]; then
  mkdir -p "$PLUGIN_THEMES"
  ln -sf "$CUSTOM_THEME" "$PLUGIN_THEMES/gotham.sh"
  echo "Gotham theme linked. Run: tmux source ~/.tmux.conf"
else
  echo "tmux-tokyo-night plugin not installed yet. Run prefix + I first."
fi
