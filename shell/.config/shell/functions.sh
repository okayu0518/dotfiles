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

# Open today's diary anytime (initialize from latest markdown)
today() {
    local diary_dir today_file latest_file

    diary_dir="$HOME/syncthing/notes/diary"
    today_file="$diary_dir/$(date +%F).md"

    mkdir -p "$diary_dir"

    if [ ! -f "$today_file" ]; then
        latest_file=$(ls -1 "$diary_dir"/*.md 2>/dev/null | sort | tail -n 1 || true)

        if [ -n "$latest_file" ]; then
            cp "$latest_file" "$today_file"
            printf 'Copied: %s -> %s\n' "$(basename "$latest_file")" "$(basename "$today_file")"
        else
            : > "$today_file"
            printf 'No existing markdown found. Created: %s\n' "$(basename "$today_file")"
        fi
    fi

    "${EDITOR:-nvim}" "$today_file"
}

# Backward compatible aliases
memo() {
    today "$@"
}

begin() {
    today "$@"
}
