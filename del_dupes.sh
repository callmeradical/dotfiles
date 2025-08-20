#!/bin/sh

# Hammerspoon junk
git rm -r ./hammerspoon/"Spoons 2" hammerspoon/"Spoons 3" || true

# Sketchybar junk
git rm -r sketchybar/"helper 2" sketchybar/"helper 3" \
  sketchybar/"items 2" sketchybar/"items 3" \
  sketchybar/"plugins 2" sketchybar/"plugins 3" || true

# Zellij junk
git rm -r zellij/"themes 2" || true
