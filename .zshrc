#
# variables 
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=~/bin:/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin
export GIT_AUTHOR_NAME="Robert David"
export GIT_AUTHOR_EMAIL="robert.david@posteo.net"
export STARSHIP_CONFIG=~/.dotfiles/starship.toml

[[ -e $HOME/.profile ]] && source $HOME/.profile


#
# aliases
#

# colored ls and its shortcuts
LS=""
which lsd >/dev/null && LS="lsd"
which eza >/dev/null && LS="eza"

case $LS in
	"eza")
		EZA_DEF="--icons --group-directories-first"
		EZA_DEFL="$EZA_DEF --octal-permissions --no-permissions --long"
		alias ls="eza $EZA_DEF"
		alias ll="eza $EZA_DEFL"
		alias la="eza $EZA_DEF --all"
		alias lt="eza $EZA_DEF --tree"
		alias l="eza $EZA_DEFL --all"
		;;
	"lsd")
		LSD_DEF="--group-directories-first"
		LSD_DEFL="$LSD_DEF --permission octal --blocks permission,size,user,date,name"
		alias ls="lsd $LSD_DEF"
		alias ll="lsd $LSD_DEFL --human-readable"
		alias la="lsd $LSD_DEF --almost-all"
		alias lt="lsd $LSD_DEF --tree --depth 3"
		alias l="lsd $LSD_DEFL --almost-all --human-readable"
		;;
	*)
		export LSCOLORS='exfxcxdxbxegedAbAgacad'
		export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=1;;41:sg=1;;46:tw=0;42:ow=0;43:"
		ls --color -d . &>/dev/null && alias ls='ls --color' || { ls -G . &>/dev/null && alias ls='ls -G' }

		alias ll="ls -lh"
		alias la="ls -A"
		alias l="ls -lAh"
		;;
esac

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

zinit wait lucid for \
	zdharma-continuum/history-search-multi-word \
	atinit"zicompinit; zicdreplay" \
		zdharma-continuum/fast-syntax-highlighting \
	zsh-users/zsh-autosuggestions \
	mdumitru/git-aliases \
	hcgraf/zsh-mercurial \
	jeffreytse/zsh-vi-mode

#
# misc settings
#

# enable the multi search
zvm_after_init_commands+=("bindkey '^R' history-search-multi-word")

# start the starship theme
eval "$(starship init zsh)"
