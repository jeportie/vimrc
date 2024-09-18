#!/bin/bash

# This script updates the g:ycm_global_ycm_extra_conf line in ~/.vimrc

if [ $# -ne 1 ]; then
  echo "Usage: $0 /path/to/ycm_extra_conf.py"
  exit 1
fi

YCM_CONF_PATH="$1"
VIMRC_PATH="$HOME/.vimrc"

# Backup .vimrc
cp "$VIMRC_PATH" "$VIMRC_PATH.bak"

# Use sed to find and replace the g:ycm_global_ycm_extra_conf line
sed -i.bak '/let g:ycm_global_ycm_extra_conf/c\let g:ycm_global_ycm_extra_conf = "'"$YCM_CONF_PATH"'"' "$VIMRC_PATH"

echo "Updated .vimrc with YCM config path: $YCM_CONF_PATH"
