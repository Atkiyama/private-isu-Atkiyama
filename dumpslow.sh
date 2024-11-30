#!/bin/bash

# 設定
TIMESTAMP=$(date +"%Y%m%d_%H%M%S") 
SLOW_QUERY_LOG="webapp/logs/mysql/mysql-slow.log"  # スロークエリログのパス
OUTPUT_FILE="logs/dump/dumpslow$TIMESTAMP.log"               # 上位10件を出力するファイルのパス
BACKUP_DIR="logs/slow-query-backup"                 # バックアップ先ディレクトリ


# 1. スロークエリログを解析して実行時間順にソートし、上位10件を出力
echo "解析中: 実行時間順にソートして上位10件を $OUTPUT_FILE に出力します..."
mysqldumpslow -s t -t 10 "$SLOW_QUERY_LOG" > "$OUTPUT_FILE"

# 2. スロークエリログをタイムスタンプ付きでバックアップ
echo "バックアップ中: $BACKUP_DIR/mysql-slow-$TIMESTAMP.log に保存します..."
mkdir -p "$BACKUP_DIR"
cp "$SLOW_QUERY_LOG" "$BACKUP_DIR/mysql-slow-$TIMESTAMP.log"

# 3. オリジナルのスロークエリログを初期化
echo "スロークエリログを初期化します: $SLOW_QUERY_LOG"
echo "" > "$SLOW_QUERY_LOG"

echo "処理完了！"
