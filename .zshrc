# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# zsh settings
#
setopt appendhistory
setopt autocd
setopt autopushd
setopt autoremoveslash
setopt banghist
setopt braceccl
setopt chaselinks
setopt combiningchars
setopt correct
setopt extendedglob
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt histsavenodups
setopt histverify
setopt incappendhistory
setopt interactivecomments
setopt pushdignoredups
setopt pushdsilent
setopt pushdtohome

# history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

#
# Zinit
#
mkdir -p ${HOME}/.zinit
source "${HOME}/.dotfiles/zinit/zinit.zsh"

#
# plugins
#

# theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# load env from directory (use .in, .out files)
zinit light zpm-zsh/autoenv

# ctrl-z for fg (vim)
zinit light mdumitru/fancy-ctrl-z

# git and mercurial shortcuts
zinit light mdumitru/git-aliases
zinit light hcgraf/zsh-mercurial

# autosuggestions
zinit ice depth=1
zinit light zsh-users/zsh-autosuggestions

# history search
zinit ice depth=1
zinit light zdharma-continuum/history-search-multi-word

# syntax highlighting
zinit ice depth=1
zinit light zdharma-continuum/fast-syntax-highlighting

# vim mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

#
# misc settings
#

# enable the multi search
zvm_after_init_commands+=("bindkey '^R' history-search-multi-word")

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
