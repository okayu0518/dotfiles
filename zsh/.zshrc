# ~/.zshrc: executed by zsh for non-login shells.

# Exit if not running interactively
[[ $- != *i* ]] && return

# =====================
# Source Common Config
# =====================
[ -f ~/.config/shell/env.sh ] && source ~/.config/shell/env.sh
[ -f ~/.config/shell/aliases.sh ] && source ~/.config/shell/aliases.sh
[ -f ~/.config/shell/functions.sh ] && source ~/.config/shell/functions.sh

# =====================
# History Configuration
# =====================
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE APPEND_HISTORY histignorealldups
setopt EXTENDED_HISTORY
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%F %T"

# =====================
# Prompt Configuration
# =====================
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git*' formats ' (%b)'
zstyle ':vcs_info:git*' actionformats ' (%b|%a)'

PROMPT='
[%F{cyan}%n@%m%f:%F{green}%~%f%F{yellow}${vcs_info_msg_0_}%f]
%# '

# =====================
# Completion Configuration
# =====================
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

# =====================
# Key Bindings
# =====================
#bindkey -e  # Use emacs keybindings
