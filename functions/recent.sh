# 最近変更されたファイルを再帰的に表示する関数 (デフォルト10件)
# 使用例: recent_mtime         (上位10件表示)
# 使用例: recent_mtime 5       (上位5件表示)
# 使用例: recent_mtime -h      (ヘルプ表示)
recent_mtime() {
    local num_files=${1:-10} # 引数がなければデフォルトで10を設定
    if [[ "$num_files" == "-h" || "$num_files" == "--help" ]]; then
        echo "Usage: recent_mtime [NUMBER]"
        echo "Displays the most recently modified files recursively."
        echo "NUMBER: The number of files to display (default: 10)."
        return 0
    fi

    echo "Searching for the $num_files most recently modified files..."
    find . -type f -print0 | xargs -0 ls -lt | head -n "$((num_files + 1))" | tail -n "$num_files"
    # 解説: head -n "$((num_files + 1))" で ls -lt のヘッダ行も含めて取得し、
    # tail -n "$num_files" でヘッダ行を除いたファイル行のみを表示します。
    # または、ls -lt の出力を加工してヘッダ行を除外することも考えられますが、
    # この方法がシンプルです。
    # ただし、ls -lt の出力にヘッダ行がない場合（例えば出力がファイルだけの場合）、
    # tail -n "$num_files" で1行減ってしまう可能性があるので注意が必要です。
    # 確実なのは、grepでヘッダを除外する、またはsedを使う方法です。
    # 例: find . -type f -print0 | xargs -0 ls -lt | grep -v 'total' | head -n "$num_files"
    # この例では 'total' 行を単純に除外しています。
}

# 最近アクセスされたファイルを再帰的に表示する関数 (デフォルト10件)
# 注意: ファイルシステムのatime設定によっては正確でない場合があります。
# 使用例: recent_atime         (上位10件表示)
# 使用例: recent_atime 5       (上位5件表示)
# 使用例: recent_atime -h      (ヘルプ表示)
recent_atime() {
    local num_files=${1:-10} # 引数がなければデフォルトで10を設定
    if [[ "$num_files" == "-h" || "$num_files" == "--help" ]]; then
        echo "Usage: recent_atime [NUMBER]"
        echo "Displays the most recently accessed files recursively."
        echo "NUMBER: The number of files to display (default: 10)."
        echo "Note: Accuracy depends on your filesystem's atime settings."
        return 0
    fi

    echo "Searching for the $num_files most recently accessed files..."
    find . -type f -printf '%A@ %p\n' | sort -nr | head -n "$num_files" | awk '{print $2}'
}
