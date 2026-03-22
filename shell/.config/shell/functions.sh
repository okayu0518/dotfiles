# fdfind + fzf + cd key binding
cdf() {
  local dir
  dir=$(fdfind --type d --hidden --exclude .git | fzf) && cd "$dir"
}

# Sort file in-place
mysort() {
    sort "$1" -o "$1"
}

# List recently modified files
recentfiles() {
    local count=${1:-10}
    find . -type f -printf '%T@ %P\n' | sort -nr | head -n "$count" | cut -d' ' -f2-
}
