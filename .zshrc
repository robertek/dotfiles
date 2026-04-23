#
# variables
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$HOME/bin:$PATH
export GIT_AUTHOR_NAME="Robert David"
export EDITOR="hx"

autotmux() {
  if [[ -z "$ZELLIJ" && -z "$TMUX" ]]; then
    which tmux >/dev/null 2>&1 || return 1

    if tmux has -t "$USER"; then
      exec tmux -2 attach -d -t "$USER"
    else
      exec tmux -2 new -s "$USER"
    fi
  fi
}

autozellij() {
  if [[ -z "$ZELLIJ" && -z "$TMUX" ]]; then
    which zellij >/dev/null 2>&1 || return 1

    SYSTEMD_RUN=""
    which systemd-run >/dev/null 2>&1 && SYSTEMD_RUN="systemd-run --scope --user"

    exec $SYSTEMD_RUN zellij attach -c "$USER"
  fi
}

[[ -z $SSH_CLIENT ]] || autozellij || autotmux

#
# aliases
#

# colored ls and its shortcuts
if which eza >/dev/null; then
  EZA_DEF="--icons --group-directories-first"
  EZA_DEFL="$EZA_DEF --octal-permissions --no-permissions --long"
  alias ls="eza $EZA_DEF"
  alias ll="eza $EZA_DEFL"
  alias la="eza $EZA_DEF --all"
  alias lt="eza $EZA_DEF --tree"
  alias l="eza $EZA_DEFL --all"
else
  alias ll="ls -lh"
  alias la="ls -A"
  alias l="ls -lAh"
fi

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

autoload -U compinit
compinit

#
# Zinit
#
declare -A ZINIT
ZINIT[NO_ALIASES]=1
mkdir -p "${HOME}/.zinit"
source "${HOME}/.dotfiles/zinit/zinit.zsh"

#
# plugins
#

zinit light zsh-users/zsh-completions

[[ $(uname -o) == "GNU/Linux" ]] && zinit light Multirious/zsh-helix-mode

# fzf
if which fzf >/dev/null; then
  zinit light Aloxaf/fzf-tab
  zhm_wrap_widget fzf-tab-complete zhm_fzf_tab_complete
  bindkey '^I' zhm_fzf_tab_complete
  which atuin >/dev/null || zinit light joshskidmore/zsh-fzf-history-search
fi

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light mdumitru/git-aliases

# autosugestions with helix support
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
  zhm_history_prev
  zhm_history_next
  zhm_prompt_accept
  zhm_accept
  zhm_accept_or_insert_newline
)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(
  zhm_move_right
  zhm_clear_selection_move_right
)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(
  zhm_move_next_word_start
  zhm_move_next_word_end
)

# atuin
if which atuin >/dev/null; then
  # export ATUIN_NOBIND="true"
  eval "$(atuin init zsh)"
  bindkey -M hxnor '^r' atuin-up-search-vicmd
  bindkey -M hxnor '^[[A' atuin-up-search
  bindkey -M hxnor '^[OA' atuin-up-search
  bindkey -M hxins '^r' atuin-up-search-vicmd
  bindkey -M hxins '^[[A' atuin-up-search
  bindkey -M hxins '^[OA' atuin-up-search
fi

# init the zoxide
which zoxide >/dev/null && eval "$(zoxide init zsh)"

# start the starship theme
export STARSHIP_CONFIG=~/.dotfiles/starship.toml
which starship >/dev/null && eval "$(starship init zsh)"


#
# load nix-pkg on Linux
#
[[ $(uname -o) == "GNU/Linux" ]] && source "$HOME/.dotfiles/nix-pkg.sh"

#
# Load local profile
#
[[ -e $HOME/.profile ]] && source $HOME/.profile
