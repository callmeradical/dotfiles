#!/bin/sh
set -e

echo "d0t: post-apply on $D0T_HOST"

# TPM: install tmux plugins if not already installed
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
