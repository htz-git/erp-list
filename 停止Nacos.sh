#!/bin/bash

echo ""
echo "============================================================"
echo "                   停止 Nacos 服务"
echo "============================================================"
echo ""

# 检查 Nacos 目录
NACOS_HOME=""
if [ -d "./nacos" ]; then
    NACOS_HOME="./nacos"
elif [ -d "$HOME/nacos" ]; then
    NACOS_HOME="$HOME/nacos"
elif [ -d "/opt/nacos" ]; then
    NACOS_HOME="/opt/nacos"
else
    echo "[错误] 未找到 Nacos 目录！"
    echo ""
    exit 1
fi

echo "Nacos 目录：$NACOS_HOME"
echo ""

# 检查 Nacos 是否在运行
if ! lsof -Pi :8848 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "[提示] Nacos 服务未运行"
    echo ""
    exit 0
fi

echo "正在停止 Nacos 服务..."
echo ""

cd "$NACOS_HOME/bin"
if [ -f "shutdown.sh" ]; then
    sh shutdown.sh
    echo ""
    echo "[✓] Nacos 服务已停止"
else
    echo "[错误] 未找到停止脚本！"
fi

echo ""


