#!/bin/bash

echo ""
echo "============================================================"
echo "                    Nacos 服务启动程序"
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
    echo "请确保 Nacos 已解压到以下位置之一："
    echo "  1. ./nacos"
    echo "  2. ~/nacos"
    echo "  3. /opt/nacos"
    echo ""
    echo "如果 Nacos 在其他位置，请修改本脚本中的 NACOS_HOME 变量"
    echo ""
    exit 1
fi

# 检查 Nacos 是否已启动
if lsof -Pi :8848 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "[提示] Nacos 服务已在运行中（端口 8848）"
    echo ""
    echo "访问地址：http://localhost:8848/nacos"
    echo "默认用户名：nacos"
    echo "默认密码：nacos"
    echo ""
    exit 0
fi

echo "[1/3] 检查 Java 环境..."
if ! command -v java &> /dev/null; then
    echo "[错误] 未检测到 Java 环境！"
    echo "请先安装 JDK 1.8 或更高版本，并配置 JAVA_HOME 环境变量"
    echo ""
    exit 1
fi
echo "[✓] Java 环境检查通过"

echo ""
echo "[2/3] 正在启动 Nacos 服务..."
echo "Nacos 目录：$NACOS_HOME"
echo ""

cd "$NACOS_HOME/bin"
if [ ! -f "startup.sh" ]; then
    echo "[错误] 未找到 Nacos 启动脚本！"
    echo "请检查 Nacos 是否正确解压"
    echo ""
    exit 1
fi

echo "启动命令：sh startup.sh -m standalone"
echo ""
sh startup.sh -m standalone

echo ""
echo "[3/3] 等待 Nacos 启动完成..."
echo ""

# 等待 Nacos 启动（最多等待 60 秒）
count=0
while [ $count -lt 30 ]; do
    sleep 2
    if lsof -Pi :8848 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        echo "[✓] Nacos 启动成功！"
        echo ""
        echo "============================================================"
        echo "                    Nacos 启动完成"
        echo "============================================================"
        echo ""
        echo "访问地址：http://localhost:8848/nacos"
        echo "默认用户名：nacos"
        echo "默认密码：nacos"
        echo ""
        sleep 3
        
        # 根据操作系统打开浏览器
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open http://localhost:8848/nacos
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open http://localhost:8848/nacos 2>/dev/null || echo "请手动打开浏览器访问 http://localhost:8848/nacos"
        fi
        
        echo ""
        exit 0
    fi
    count=$((count + 1))
done

echo "[警告] Nacos 启动超时，请检查日志文件"
echo "日志位置：$NACOS_HOME/logs/start.out"
echo ""
exit 1


