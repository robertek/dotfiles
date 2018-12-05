#
# variables 
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=~/bin:/usr/bin:/bin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin

#
# aliases
#
source $HOME/.dotfiles/.shortcuts

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

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "ael-code/zsh-colored-man-pages"
zplug "zpm-zsh/colors"
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
