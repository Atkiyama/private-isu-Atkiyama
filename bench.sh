#!/bin/bash

# ログファイルのパス
# benchmarkerからのパスであることに注意
LOG_FILE="../logs/benchmarker.log"

# コマンドの実行とログへの追記
cd benchmarker
docker run --network host -i private-isu-benchmarker /bin/benchmarker -t http://host.docker.internal -u /opt/userdata \
| while IFS= read -r line; do
    # 現在時刻を取得
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    # ログファイルに時刻と出力を追記
    echo "[$TIMESTAMP] $line"
    echo "[$TIMESTAMP] $line" >> "$LOG_FILE"
done
cd ../
