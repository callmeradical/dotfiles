#!/usr/bin/env bash
# Fix and restow dotfiles cleanly
# - Removes wrong symlinks in $HOME and ~/.config
# - Ensures .stowrc targets $HOME
# - Restows packages, adopting if needed
set -euo pipefail

# --- CONFIG ---------------------------------------------------------------
# Change if your repo lives somewhere else:
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Documents/3_resources/dotfiles}"

# Packages to stow
PACKS=(nvim wezterm starship ghostty karabiner sketchybar nushell zellij nix hammerspoon skhd tmux ssh zsh atuin aerospace)

# --- GUARDS ---------------------------------------------------------------
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "✖ DOTFILES_DIR not found: $DOTFILES_DIR" >&2
  exit 1
fi

cd "$DOTFILES_DIR"

# --- 0) GIT SAFETY BRANCH (optional) -------------------------------------
if git rev-parse --git-dir >/dev/null 2>&1; then
  git switch -c refactor/stow-home 2>/dev/null || true
fi

# --- 1) NUKE BAD TOP-LEVEL SYMLINKS IN $HOME ------------------------------
# These should NOT be links living directly in $HOME
BAD_TOP=(.git .gitignore .stowrc Brewfile \
         aerospace atuin ghostty hammerspoon karabiner nix nix-darwin nushell \
         nvim sketchybar skhd ssh starship tmux wezterm zellij zsh)
for name in "${BAD_TOP[@]}"; do
  p="$HOME/$name"
  if [[ -L "$p" ]]; then
    echo "unlink $p"
    unlink "$p"
  fi
done

# --- 2) CLEAN WRONG LINKS UNDER ~/.config --------------------------------
# Remove only symlinks (safe). Leaves real dirs/files intact.
if [[ -d "$HOME/.config" ]]; then
  while IFS= read -r -d '' link; do
    tgt="$(readlink "$link" || true)"
    # Remove links that point into the dotfiles repo OR any top-level symlink junk
    if [[ "$tgt" == *"/dotfiles/"* ]] || [[ -L "$link" ]]; then
      echo "unlink $link"
      unlink "$link"
    fi
  done < <(find "$HOME/.config" -maxdepth 1 -type l -print0)
fi

# --- 3) ENSURE .stowrc & .stow-local-ignore ------------------------------
cat > .stowrc <<'EOF'
--target=$HOME
--verbose=2
--restow
EOF

cat > .stow-local-ignore <<'EOF'
^\.git/$
^\.DS_Store$
^README\.md$
^setup\.sh$
^Brewfile$
EOF

if git rev-parse --git-dir >/dev/null 2>&1; then
  git add .stowrc .stow-local-ignore || true
  git commit -m "stow: target \$HOME; add local ignore" || true
fi

# --- 4) UNSTOW ANY PREVIOUS STATE (best effort) --------------------------
for p in "${PACKS[@]}"; do
  stow -D "$p" 2>/dev/null || true
done

# --- 5) RESTOW (ADOPT ON CONFLICT) ---------------------------------------
for p in "${PACKS[@]}"; do
  echo "==> stow $p"
  if ! stow --restow "$p"; then
    echo "   conflict -> adopting $p"
    stow --adopt "$p"
    if git rev-parse --git-dir >/dev/null 2>&1; then
      git add -A && git commit -m "stow(adopt): $p" || true
    fi
    stow --restow "$p"
  fi
done

# --- 6) PERMISSIONS -------------------------------------------------------
chmod 600 "$HOME/.ssh/config" 2>/dev/null || true

# --- 7) VERIFY (summary) --------------------------------------------------
echo
echo "Symlink check (should all exist and be links):"
for path in \
  "$HOME/.config/nvim" \
  "$HOME/.config/wezterm/wezterm.lua" \
  "$HOME/.config/starship.toml" \
  "$HOME/.config/ghostty/config" \
  "$HOME/.config/karabiner/karabiner.json" \
  "$HOME/.config/sketchybar" \
  "$HOME/.config/nushell" \
  "$HOME/.config/zellij" \
  "$HOME/.config/nix" \
  "$HOME/.hammerspoon" \
  "$HOME/.skhdrc" \
  "$HOME/.tmux.conf" \
  "$HOME/.ssh/config" \
  "$HOME/.zshrc"
do
  if [[ -e "$path" ]]; then
    if [[ -L "$path" ]]; then
      echo "✓ link: $path -> $(readlink "$path")"
    else
      echo "• exists (not link): $path"
    fi
  else
    echo "✖ missing: $path"
  fi
done

echo
echo "Done."
