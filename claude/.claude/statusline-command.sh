#!/bin/bash
# Claude Code statusLine, converted from the PS1 defined in ~/.bashrc:
#   export PS1="[\[\033[32m\]\u\[\033[00m\]@\[\033[35m\]\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\]]\n\$ "
#
# Line 1 renders: [user@host:cwd (git-branch) model]
# (trailing "$ " prompt char from the original PS1 is dropped, as it has no
# meaning in a non-interactive statusline; model name appended on request)
#
# Line 2 (added on request) shows context usage and Claude usage-limit status:
#   [ctx NN% | 5h NN% remain 1h23m | 7d NN% remain 3d2h]
# Colors avoid blue (reported hard to read) in favor of red/yellow.

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$cwd" ] && cwd=$(pwd)

user=$(whoami)
host=$(hostname -s)

# git commands skip optional locks so they never block on a concurrent git process
branch=$(git --no-optional-locks -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
git_part=""
[ -n "$branch" ] && git_part=" ($branch)"

model=$(echo "$input" | jq -r '.model.display_name // empty')
model_part=""
[ -n "$model" ] && model_part=$(printf ' \033[95m%s\033[0m' "$model")

line1=$(printf '[\033[32m%s\033[0m@\033[35m%s\033[0m:\033[36m%s\033[0m\033[33m%s\033[0m%s]' \
  "$user" "$host" "$cwd" "$git_part" "$model_part")

# --- usage-reset line -------------------------------------------------
now=$(date +%s)

format_remaining() {
  local diff=$(( $1 - now ))
  [ "$diff" -lt 0 ] && diff=0
  local d=$((diff / 86400))
  local h=$(((diff % 86400) / 3600))
  local m=$(((diff % 3600) / 60))
  if [ "$d" -gt 0 ]; then printf '%dd%dh' "$d" "$h"
  elif [ "$h" -gt 0 ]; then printf '%dh%dm' "$h" "$m"
  else printf '%dm' "$m"
  fi
}

ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

parts=()
if [ -n "$ctx_pct" ]; then
  parts+=("$(printf '\033[36mctx %s%%\033[0m' "$ctx_pct")")
fi
if [ -n "$five_pct" ] && [ -n "$five_reset" ]; then
  parts+=("$(printf '\033[91m5h %s%% remain %s\033[0m' "$five_pct" "$(format_remaining "$five_reset")")")
fi
if [ -n "$seven_pct" ] && [ -n "$seven_reset" ]; then
  parts+=("$(printf '\033[93m7d %s%% remain %s\033[0m' "$seven_pct" "$(format_remaining "$seven_reset")")")
fi

if [ "${#parts[@]}" -gt 0 ]; then
  joined="${parts[0]}"
  for p in "${parts[@]:1}"; do
    joined="$joined | $p"
  done
  printf '%s\n[%s]' "$line1" "$joined"
else
  printf '%s' "$line1"
fi
