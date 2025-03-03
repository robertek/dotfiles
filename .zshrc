#
# variables
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$HOME/bin:/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin
export GIT_AUTHOR_NAME="Robert David"
export GIT_AUTHOR_EMAIL="robert.david@posteo.net"
export EDITOR="vim"

autotmux() {
	if [[ -z "$ZELLIJ" && -z "$TMUX" ]]
	then
		which tmux >/dev/null 2>&1
		[[ $? -ne 0 ]] && return 1

		tmux has -t $USER
		if [[ $? -eq 0 ]]
		then
			exec tmux -2 attach -d -t $USER
		else
			exec tmux -2 new -s $USER
		fi
	fi
}

autozellij() {
	if [[ -z "$ZELLIJ" && -z "$TMUX" ]]
	then
		which zellij >/dev/null 2>&1
		[[ $? -ne 0 ]] && return 1

		exec zellij attach -c $USER
	fi
}

[[ -e $HOME/.profile ]] && source $HOME/.profile

[[ -z $SSH_CLIENT ]] || autozellij || autotmux


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
setopt autocd
setopt autopushd
setopt braceccl
setopt combiningchars
setopt correct
setopt extendedhistory
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt histsavenodups
setopt histverify
setopt incappendhistory
setopt pushdignoredups
setopt pushdsilent
setopt pushdtohome

# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

autoload -U compinit; compinit

#
# extra keybindings
#

# Add text object extension -- eg ci" da(:
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# ctrl-w removed word backwards as in emacs mode
bindkey '^w' backward-kill-word

#
# Zinit
#
declare -A ZINIT
ZINIT[NO_ALIASES]=1
mkdir -p ${HOME}/.zinit
source "${HOME}/.dotfiles/zinit/zinit.zsh"

#
# plugins
#

zinit light zsh-users/zsh-completions

# fzf
which fzf >/dev/null && zinit light Aloxaf/fzf-tab
which fzf >/dev/null && zinit light joshskidmore/zsh-fzf-history-search

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light mdumitru/git-aliases

# init the zoxide
which zoxide >/dev/null && eval "$(zoxide init zsh)"

# start the starship theme
export STARSHIP_CONFIG=~/.dotfiles/starship.toml
which starship >/dev/null && eval "$(starship init zsh)"
