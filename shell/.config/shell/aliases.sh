# Color support for ls and grep
if command -v dircolors > /dev/null; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  # Fallback for systems without dircolors
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# Standard aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Custom aliases
alias tenki="curl wttr.in/香美市"

# Source user-specific aliases if present (compatible with both shells)
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
