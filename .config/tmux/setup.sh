#!/bin/bash

rmdir ~/.config/tmux/plugins/*
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

echo "From tmux, use the command <prefix> + I"
