# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# =====================
# Source Common Config
# =====================
[ -f ~/.config/shell/env.sh ] && . ~/.config/shell/env.sh
[ -f ~/.config/shell/aliases.sh ] && . ~/.config/shell/aliases.sh
[ -f ~/.config/shell/functions.sh ] && . ~/.config/shell/functions.sh

# =====================
# History settings
# =====================
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
export HISTTIMEFORMAT="%F %T "

# Check window size after each command
shopt -s checkwinsize

# Lesspipe for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set chroot variable if needed
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# =====================
# Prompt Configuration
# =====================
# Git branch in prompt
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/^/ (/;s/$/)/'
}

# Enhanced prompt with colored hostname
export PS1="[\[\033[32m\]\u\[\033[00m\]@\[\033[35m\]\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\]]\n\$ "

# =====================
# Completion Features
# =====================
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alert alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
