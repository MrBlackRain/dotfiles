# ============================================================
# System stuff
# ============================================================

export EDITOR=nvim

# Additional executable paths
path+=(~/go/bin)
path+=(~/.local/bin)
path+=(~/.yarn/bin)

if [[ $(uname) == "Linux" ]] && [ -d "/home/linuxbrew" ]; then
  path+=(/home/linuxbrew/.linuxbrew/bin)
fi

export PATH

if [ -d "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

# ============================================================
# MacOS Specific 
# ============================================================

if [[ $(uname) == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  source ~/.orbstack/shell/init.zsh 2>/dev/null || : 
fi

# ============================================================
# Dockertex stuff
# ============================================================

if [ $(uname -m) = "arm64" ]; then
  export DOCKERTEX_DEFAULT_TAG="arm64-texlive2018"
else
  export DOCKERTEX_DEFAULT_TAG="texlive2018"
fi
export DOCKERTEX_ENGINE="docker"

# ============================================================
# Homebrew stuff
# ============================================================

if [ type brew &>/dev/null ];
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  # init autocompletes
  autoload -Uz compinit
  compinit
fi

# ============================================================
# Python stuff
# ============================================================

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]];
then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

if command -v pyenv &>/dev/null
then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# ============================================================
# Plugin stuff
# ============================================================

source ~/.zplug/init.zsh

HIST_STAMPS="dd.mm.yyyy"

export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')
zplug "lukechilds/zsh-nvm"

zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/functions", from:oh-my-zsh
zplug "lib/history",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/history",   from:oh-my-zsh
zplug "plugins/virtualenv",   from:oh-my-zsh
zplug "greymd/docker-zsh-completion"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug raabf/dockertex, \
    from:gitlab, \
    hook-build:"./posthook.sh --menu-tag latest --menu-volume /media/ext/=/home/ext/"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# ============================================================
# Plugin options
# ============================================================

unsetopt autocd

# ============================================================
# Keybindings
# ============================================================

bindkey "ç" fzf-cd-widget # MacOS rebind Alt-C

# ============================================================
# Aliases 
# ============================================================

# vim
alias -g v='nvim'

# ls
TREE_IGNORE="cache|log|logs|node_modules|vendor|venv|.vscode|.git"

alias -g eza='eza --group-directories-first --icons'

# ls is not global cos it can brake some 3rd party, i.e. nvm 
alias ls=' eza '
alias -g ll=' eza --git -lahg' # override definition from oh-my-zsh lib/directories
alias -g lt=' eza --tree -D -L 2 -I ${TREE_IGNORE}'
alias -g ltt=' eza --tree -D -L 3 -I ${TREE_IGNORE}'
alias -g lttt=' eza --tree -D -L 4 -I ${TREE_IGNORE}'
alias -g ltttt=' eza --tree -D -L 5 -I ${TREE_IGNORE}'

alias hg="history | grep"

alias lg="lazygit"

# conditional aliases
if [ "$TERM" = "xterm-kitty" ]; then
    alias ssh="kitty +kitten ssh"
fi

# ============================================================
# Init starship
# ============================================================
eval "$(starship init zsh)"

# ============================================================
# Init fzf
# ============================================================
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

