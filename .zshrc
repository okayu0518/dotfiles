# ~/.zshrc: executed by zsh for non-login shells.

# Exit if not running interactively
[[ $- != *i* ]] && return

# History Configuration
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE APPEND_HISTORY
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%F %T"

# Prompt Configuration
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git*' formats ' (%b)'
zstyle ':vcs_info:git*' actionformats ' (%b|%a)'

if [[ "$TERM" == xterm-color || "$TERM" == *-256color ]]; then
  color_prompt=yes
fi

if [[ "$color_prompt" == yes ]]; then
  PROMPT='%F{cyan}%n@%m %F{green}%~%f%F{yellow}${vcs_info_msg_0_}%f %# '
else
  PROMPT='%n@%m:%~ ${vcs_info_msg_0_} %# '
fi

# Aliases
if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# Completion Configuration
autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Key Bindings
bindkey -e  # Use emacs keybindings

# Custom Functions
cdf() {
  local dir
  dir=$(fdfind --type d --hidden --exclude .git | fzf) && cd "$dir"
}

# Final Setup
setopt histignorealldups

# Tmux Autostart Configuration
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  # Check if there are existing sessions
  if tmux ls &> /dev/null; then
    # Attach to the most recent session
    exec tmux attach
  else
    # Create a new session
    exec tmux
  fi
fi
