#
# variables 
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=~/bin:/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin
export GIT_AUTHOR_NAME="Robert David"
export GIT_AUTHOR_EMAIL="robert.david.public@gmail.com"

[[ -e $HOME/.profile ]] && source $HOME/.profile


#
# aliases
#

# colored ls and its shortcuts
export LSCOLORS='exfxcxdxbxegedAbAgacad'
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=1;;41:sg=1;;46:tw=0;42:ow=0;43:"
ls --color -d . &>/dev/null && alias ls='ls --color' || { ls -G . &>/dev/null && alias ls='ls -G' }
alias ll="ls -lh"
alias la="ls -A"
alias l="ls -lAh"

alias vimpager="~/.vim/bundle/vimpager/vimpager"


#
# ZPM
#

source $HOME/.dotfiles/zpm.zsh

