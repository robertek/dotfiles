#
# ZPM base
#

TMPDIR="${HOME}/.cache"

if [[ ! -f ~/.zpm/zpm.zsh ]]; then
  git clone --recursive https://github.com/zpm-zsh/zpm ~/.zpm
fi
source ~/.zpm/zpm.zsh

#
# plugins
#

# load base
zpm load zpm-zsh/core-config

# load colors
zpm load zpm-zsh/colors

# theme
zpm load robertek/slimline

# load env from directory (use .in, .out files)
zpm load zpm-zsh/autoenv,async

# ctrl-z for fg (vim)
zpm load mdumitru/fancy-ctrl-z,async

# git and mercurial shortcuts
zpm load mdumitru/git-aliases,async
zpm load hcgraf/zsh-mercurial,async

# autosuggestions
zpm load zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh,async

# syntax highlighting 
zpm load zdharma-continuum/fast-syntax-highlighting,async

# vim mode
zpm load jeffreytse/zsh-vi-mode,async

#
# plugin settings
#
