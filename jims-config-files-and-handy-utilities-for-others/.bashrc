# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# # don't put duplicate lines or lines starting with space in the history.
# # See bash(1) for more options
# HISTCONTROL=ignoreboth
# 
# # append to the history file, don't overwrite it
# shopt -s histappend
# 
# # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]m@m\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}m@m:\w\$ '
fi

# User specific aliases and functions

# HISTCONTROL=ignoreboth
# HISTCONTROL=ignoredups:ignorespace
unset HISTCONTROL
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT="%F %T "
export HISTCONTROL
export HISTFILESIZE
export HISTSIZE
export HISTTIMEFORMAT
shopt -s histappend

append_to_path () {
    for d in "$@"; do
        if echo "${PATH}" | tr ':' '\n' | grep -q "^${d}$" -; then
            :
        else
            PATH="${PATH}${PATH+:}${d}"
        fi
    done
}
append_to_path "${HOME}/bin"

set -o vi
alias ll='ls -l'
alias lll='ls -l --full-time' ;# good on linux, but not macos
# alias lll='ls -l -T' ;# lame bsd
# alias lll='gls -l --full-time' ;# for macos: brew install coreutils
alias ltr='ls -l -t -r'
alias ltra='ls -l -t -r -a'
alias hd='xxd -g 1 -u'
# alias top='top -o cpu' ;# macos only
alias man=" \
    LESS_TERMCAP_mb=$'\e[1;32m' \
    LESS_TERMCAP_md=$'\e[1;32m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;4;31m' \
    man"; # colorized man pages
# man() {
#     env \
#     LESS_TERMCAP_mb=`printf "\e[1;31m"` \
#     LESS_TERMCAP_md=`printf "\e[1;31m"` \
#     LESS_TERMCAP_me=`printf "\e[0m"` \
#     LESS_TERMCAP_se=`printf "\e[0m"` \
#     LESS_TERMCAP_so=`printf "\e[1;44;33m"` \
#     LESS_TERMCAP_ue=`printf "\e[0m"` \
#     LESS_TERMCAP_us=`printf "\e[1;32m"` \
#     man "$@"
# }

export LINES
export COLUMNS
# EDITOR value is for git.
EDITOR=vim
export EDITOR
# PAGER is convenient for wide queries in psql.
PAGER='less -FRSX'
export PAGER
alias c='calendar -A 7 -B 2'
alias c='calendar -A 7'
alias c='cal | grep -v "^ *$";calendar -A 7'
alias d='date --iso-8601=ns'

alias gl='git lg'
alias gla='git lg --all'
alias gl1='git lg --all -10'
alias gl2='git lg --all -20'
alias gl3='git lg --all -30'
alias gl4='git lg --all -40'
alias gl5='git lg --all -50'
alias gll='git lg --all --color=always | less -FRSX'
alias gd='git difftool -t meld'
alias gy='git difftool -t meld -y'
alias fa='git fetch --all'

alias oepn='open'
alias opne='open'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

md() {
    mkdir "$@"
    cd "$@"
}

# per Tharun Mechineni 2022-07-12 09:32 in Python Center of Excellence webex channel:
# webexteams://im?space=1f237bb0-adbf-11eb-8173-3b2c971796ca
# set HTTP_PROXY=http://internet.ford.com:83
# set HTTPS_PROXY=http://internet.ford.com:83
# set NO_PROXY=.ford.com

# per Proxy Guide Command Line Tools
# https://github.ford.com/DevEnablement/pcfdev-guides/tree/master/proxy-configuration#command-line-tools
# export http_proxy=http://internet.ford.com:83
# export https_proxy=http://internet.ford.com:83
# export no_proxy=localhost,127.0.0.1,19.0.0.0/8,10.0.0.0/8,172.16.0.0/12,.ford.com

# umask 0277
# umask 0057
# umask 0037
# umask 0027
# umask 0000 ;# for installing node.js
# PS1='\h:\W \u\$ ' # original
# PS1='\u@\h:\w\$ '
# PS1='m@m:\w\$ '
PS1='m@m:\[\033[01;32m\]\w\[\033[00m\]\$ '
export PS1
