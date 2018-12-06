#
# variables
#
export LSCOLORS='exfxcxdxbxegedAbAgacad'
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=1;;41:sg=1;;46:tw=0;42:ow=0;43:"


#
# aliases
#
source $HOME/.dotfiles/.shortcuts

alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -A"
alias l="ls -lA"

#
# config
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

# completion
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' list-colors ''


#
# ZPLUG
#

source $HOME/.dotfiles/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "ael-code/zsh-colored-man-pages"
zplug "softmoth/zsh-vim-mode"
zplug "mdumitru/git-aliases"
zplug "hcgraf/zsh-mercurial"

zplug "zsh-users/zsh-syntax-highlighting", defer:2

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
