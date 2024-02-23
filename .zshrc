# ============================================================
# System stuff
# ============================================================

export EDITOR=nvim

# Additional executable pathes
path+=(~/go/bin)
path+=(~/.local/bin)
path+=(~/.yarn/bin)

if [[ $(uname) == "Linux" ]] && [ -d "/home/linuxbrew" ]; then
  path+=(/home/linuxbrew/.linuxbrew/bin)
fi

export PATH

source "$HOME/.cargo/env"

# ============================================================
# MacOS Spesific 
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

  # init autocomplits
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
# Keybindings
# ============================================================

bindkey '^R' .history-incremental-search-backward # for TMUX compatibility

# ============================================================
# Asiases 
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

# conditional aliases
if [ "$TERM" = "xterm-kitty" ]; then
	alias ssh="kitty +kitten ssh"
fi

# ============================================================
# Init starship
# ============================================================
eval "$(starship init zsh)"

