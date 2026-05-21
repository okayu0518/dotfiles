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
