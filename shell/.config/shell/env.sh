# Language and Locale
export LC_ALL=en_US.UTF-8

# PATH additions
export PATH="$HOME/.local/bin:$PATH"

# fnm (Node Version Manager)
if command -v fnm &> /dev/null; then
    # eval "$(fnm env --use-on-cd)"
    # Note: For some shells (like zsh), pure eval might be needed, but fnm supports both.
    export FNM_DIR="$HOME/.local/share/fnm"
    eval "$(fnm env --use-on-cd)"
fi

# ghcup (Haskell)
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
