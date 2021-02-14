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

# directory bookmarks
zpm load zpm-zsh/zshmarks,async

# ctrl-z for fg (vim)
zpm load mdumitru/fancy-ctrl-z,async

# git and mercurial shortcuts
zpm load mdumitru/git-aliases,async
zpm load hcgraf/zsh-mercurial,async

# history substring search
zpm load zsh-users/zsh-history-substring-search,source:zsh-history-substring-search.zsh,async

# autosuggestions
zpm load zsh-users/zsh-autosuggestions,source:zsh-autosuggestions.zsh,async

# syntax highlighting 
zpm load zdharma/fast-syntax-highlighting,async

# history search
zpm load zdharma/history-search-multi-word,fpath:/,async

# vim mode
zpm load softmoth/zsh-vim-mode

#
# plugin settings
#
