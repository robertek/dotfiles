#
# variables
#

export EDITOR="vim"
export GIT_AUTHOR_NAME="Robert David"
export GIT_AUTHOR_EMAIL="robert.david.public@gmail.com"


#
# aliases
#

# colored ls and its shortcuts
export LSCOLORS='exfxcxdxbxegedAbAgacad'
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=1;;41:sg=1;;46:tw=0;42:ow=0;43:"
ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }
alias ll="ls -lh"
alias la="ls -A"
alias l="ls -lA"


#
# general zsh config
#

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# completion menu
zstyle ':completion:*:*:*:*:*' menu select
# completion color
zstyle ':completion:*' list-colors ''
# completion case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'


#
# ZPLUG
#

print "Loading ZPLUG"

source $HOME/.dotfiles/.zplug/init.zsh

print "Loading modules"

zplug "ael-code/zsh-colored-man-pages"
zplug "softmoth/zsh-vim-mode"
zplug "mdumitru/git-aliases"
zplug "hcgraf/zsh-mercurial"

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

zplug 'themes/gentoo', from:oh-my-zsh, as:theme


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load


#
# plugin settings
#

# history sustring search attach to UP and DOWN key
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
