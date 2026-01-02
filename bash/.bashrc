# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# History settings
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

# Prompt color settings
case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
esac

# Uncomment to force color prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Set xterm title
case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *) ;;
esac

# Enable color support for ls and grep, and add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# More ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alert alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Source user aliases if present
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Git branch in prompt
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/^/ (/;s/$/)/'
}

# Enhanced prompt with colored hostname
export PS1="[\[\033[32m\]\u\[\033[00m\]@\[\033[35m\]\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\]]\n\$ "
# fdfind + fzf + cd key binding
cdf() {
  local dir
  dir=$(fdfind --type d --hidden --exclude .git | fzf) && cd "$dir"
}

mysort() {
    sort "$1" -o "$1"
}

recentfiles() {
    local count=${1:-10}
    find . -type f -printf '%T@ %P\n' | sort -nr | head -n "$count" | cut -d' ' -f2-
}

alias tenki="curl wttr.in/香美市"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
# wayland+brave
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export PATH="$HOME/.local/bin:$PATH"

# fnm
if command -v fnm &> /dev/null; then
    export FNM_DIR="$HOME/.local/share/fnm"
    eval "$(fnm env --use-on-cd)"
fi
# paruの補完時に出る警告を抑制するためのエイリアス
# (補完スクリプトが内部で呼び出すコマンドに影響を与える)
export LC_ALL=en_US.UTF-8
