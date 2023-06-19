# ============================================================
# System stuff
# ============================================================

# Additional executable pathes
path+=(~/go/bin)
path+=(~/.local/bin)
path+=(~/.yarn/bin)
path+=(/home/linuxbrew/.linuxbrew/bin)

export PATH

# ============================================================
# Asiases 
# ============================================================

# alias -g history='history -E'

# vim
alias -g v='nvim'

# ls
TREE_IGNORE="cache|log|logs|node_modules|vendor|venv|.vscode|.git"

alias -g exa='exa --group-directories-first --icons'

# ls is not global cos it can brake some 3rd party, i.e. nvm 
alias ls=' exa '
alias -g ll=' exa --git -lahg'
alias -g lt=' exa --tree -D -L 2 -I ${TREE_IGNORE}'
alias -g ltt=' exa --tree -D -L 3 -I ${TREE_IGNORE}'
alias -g lttt=' exa --tree -D -L 4 -I ${TREE_IGNORE}'
alias -g ltttt=' exa --tree -D -L 5 -I ${TREE_IGNORE}'

alias hl="history | less"

# conditional aliases
if [ "$TERM" = "xterm-kitty" ]; then
	alias ssh="kitty +kitten ssh"
fi

# ============================================================
# Dockertex stuff
# ============================================================

export DOCKERTEX_DEFAULT_TAG="texlive2018"
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
# Miniconda stuff
# ============================================================

if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
  . "$HOME/miniconda3/etc/profile.d/conda.sh"
fi

# ============================================================
# Plugin stuff
# ============================================================

source ~/.zplug/init.zsh

HIST_STAMPS="dd.mm.yyyy"

export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')
zplug "lukechilds/zsh-nvm"

zplug "lib/history",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/history",   from:oh-my-zsh
zplug "plugins/virtualenv",   from:oh-my-zsh
zplug "greymd/docker-zsh-completion"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# ============================================================
# Init starship
# ============================================================
eval "$(starship init zsh)"

