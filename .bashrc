#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export VISUAL="nvim"

# If this is started from tty1 then start X. This is a way to get around having
# a greeter.
[ "$(tty)" = "/dev/tty1" ] && startx
