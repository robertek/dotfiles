#
# Nix pkg
#
_pkg_die() {
  local msg=$1
  [ -n "$msg" ] && echo "$msg"
  exit 1
}
_pkg_install() {
  nix-env --install "$@"
}

_pkg_uninstall() {
  nix-env --uninstall "$@"
}

_pkg_search() {
  nix search nixpkgs "$@" | bat
}

_pkg_list() {
  nix-env --query --installed "$@"
}

_pkg_upgradable() {
  _pkg_list --compare-versions 2>/dev/null | grep -v " = "
}

_pkg_update() {
  nix-channel --update

  echo "Upgradable packages, if any:"
  _pkg_upgradable
}

_pkg_upgrade() {
  nix-env --upgrade "$@"
}

_pkg_fzf() {
  nix-env --query --available --attr-path --compare-versions 2>/dev/null | fzf
}

_pkg_hold() {
  nix-env --set-flag keep true "$@"
}

_pkg_release() {
  nix-env --set-flag keep false "$@"
}

_pkg_contents() {
  local pkg=$1
  [ -z "$pkg" ] && _pkg_die "Missing package name"
  find "$(nix-env -q --no-name --out-path "$1")" -type f
}

pkg() {
  local ret=0
  local cmd=$1
  [[ -z $cmd ]] && return 0

  shift

  ("_pkg_${cmd}" "$@")
  ret=$?

  return $ret
}

# completion

_pkg_compl_opts() {
  local -a opts

  # shellcheck disable=SC2034
  opts=("--dry-run" "--help" "--verbose")

  _describe 'Common opts' opts
}

_pkg_compl_installed() {
  local -a pkgs

  # shellcheck disable=SC2034,SC2207
  IFS=$'\n' pkgs=($(nix-env --query --installed --json | jq -r ".[].pname"))

  _describe 'Packages' pkgs
}

_pkg_compl() {
  local -a pkg_cmds
  local cmd

  if [[ "$CURRENT" -lt 3 ]]; then
    # shellcheck disable=SC2034
    pkg_cmds=(
      "install:Install package"
      "search:Search for package"
      "list:List installed packages"
      "upgradable:List upgradable packages"
      "update:Update repos"
      "upgrade:Upgrade packages"
      "fzf:Fuzy search packages"
      "uninstall:Uninstall package"
      "hold:Hold package"
      "release:Release package"
      "contents:List package contents"
    )

    _describe "pkg commands" pkg_cmds
  else
    # shellcheck disable=SC2154
    cmd="${words[2]}"

    _pkg_compl_opts

    case "$cmd" in
      upgrade | uninstall | release | hold | contents)
        _pkg_compl_installed
        ;;
    esac
  fi
}

[[ -n $ZSH_VERSION ]] && compdef _pkg_compl pkg

### Nix pkg
