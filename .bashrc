# ~/.bashrc

# clean home:
export XDG_CONFIG_HOME=/home/justin/.config
export XDG_DATA_HOME=/home/justin/.local/share
export XDG_STATE_HOME=/home/justin/.local/state
export XDG_CACHE_HOME=/home/justin/.cache

export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup
export RXVT_SOCKET="${XDG_RUNTIME_DIR}"/urxvtd
export W3M_DIR="${XDG_DATA_HOME}"/w3m
export GOPATH="${XDG_DATA_HOME}"/go
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alert() {
    awesome-client "require('naughty').notify({text='$1', preset=require('naughty').config.presets.critical, timeout=3})"
}

alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -la'
alias grep='grep --color=auto'
alias vim='nvim'

alias monright='xrandr --output DisplayPort-0 --right-of DisplayPort-2 --rotate left'

# put .local/bin first for clang-format override
export PATH=/home/justin/.local/bin:$PATH
export PATH=$PATH:/home/justin/.config/go/bin

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILE="${XDG_STATE_HOME}"/bash/history
shopt -s histappend

linecolour='\[\e[0;37m\]'
datecolour='\[\e[1;36m\]'
if [[ $UID == 0  ]]; then
    usercolour='\[\e[1;31m\]';
else
    usercolour='\[\e[1;32m\]';
fi
hostcolour='\[\e[1;33m\]'
atcolour='\[\e[1;0m\]'
dircolour='\[\e[1;34m\]'
reset='\[\e[0m\]'
dateformat='%R'
gitcolour='\e[0;32m'

function gitPrompt() {
    if [[ -d ".git" ]]; then
        echo -e "-[${gitcolour}$(git branch | grep "*" | sed "s/* //")\e[0m]"
    fi
}

PS1="${linecolour}┌─[${usercolour}\u${linecolour}]-[${dircolour}\w${linecolour}]\$(gitPrompt)\n${linecolour}└─> ${reset} "
