#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export VISUAL="nvim"


# Added by Antigravity CLI installer
export PATH="/home/bennett/.local/bin:$PATH"
