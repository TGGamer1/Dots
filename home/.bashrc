#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --lha --icons --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
