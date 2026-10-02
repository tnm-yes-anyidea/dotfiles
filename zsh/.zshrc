# ==============================================================================
# 1. ENVIRONMENT PATHS & SYSTEM EXPORTS
# ==============================================================================

# Ensure local binaries (including Starship and Go) take path precedence
export PATH="$HOME/.local/bin:$PATH:~/go/bin"

# Default Editor
export EDITOR='nvim'

# Cap Node.js memory usage to 2GB to prevent background processes from eating RAM
export NODE_OPTIONS="--max-old-space-size=2048"

# ==============================================================================
# 2. PROMPT INITIALIZATION (STARSHIP)
# ==============================================================================

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ==============================================================================
# 3. INTERNAL CORE HISTORY CONFIGURATION
# ==============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Share history instantly across tabs and strip useless spacing/duplicates
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# ==============================================================================
# 4. HISTORY SUBSTRING SEARCH KEYS (UP / DOWN ARROWS)
# ==============================================================================

# Pressing Up/Down arrows searches history based on what you have already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search   # Maps Physical Up Arrow
bindkey '^[[B' down-line-or-beginning-search # Maps Physical Down Arrow

# ==============================================================================
# 5. LIGHTWEIGHT PLUGIN MANAGEMENT (FEDORA PATHS)
# ==============================================================================

# Initialize native Zsh completion system cleanly using cache optimizations
autoload -Uz compinit && compinit -C

# Load Fedora's native Autosuggestions
if [ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  # Force matching ghost-text previews to a distinct, legible light-grey color
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
fi

# Load Fedora's native Syntax Highlighting (Must stay loaded absolute last)
if [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ==============================================================================
# 6. CUSTOM ALIASES & UTILITIES
# ==============================================================================

# Native UI Color Flags & Listing
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'

# Application Shorthands
alias v='nvim'
alias vim='nvim'
alias vi='nvim'
alias down='uv run ~/Music/down.py'

# Fedora Package Management
alias update='sudo dnf upgrade --refresh'
alias clean='sudo dnf clean all'

# Git Shorthands
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
