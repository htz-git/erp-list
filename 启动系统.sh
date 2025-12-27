#!/bin/bash

echo ""
echo "============================================================"
echo "          ERP跨境电商管理系统 - 一键启动程序"
echo "============================================================"
echo ""
echo "本程序将自动启动所有微服务"
echo ""
echo "请确保："
echo "  1. Nacos服务已启动（默认端口8848）"
echo "     - 如果未启动，请先运行 './启动Nacos.sh'"
echo "     - 或使用 './下载Nacos.sh' 下载并解压 Nacos"
echo "  2. MySQL数据库已启动并创建了相应数据库"
echo "  3. 已修改各服务的数据库连接配置"
echo ""
read -p "是否已启动 Nacos？(Y/N): " nacos_ready
if [ "$nacos_ready" != "Y" ] && [ "$nacos_ready" != "y" ]; then
    echo ""
    echo "请先启动 Nacos 服务！"
    echo "运行 './启动Nacos.sh' 启动 Nacos"
    echo ""
    exit 1
fi
echo ""

echo ""
echo "[1/9] 正在启动网关服务..."
cd erp-gateway
mvn spring-boot:run > ../logs/gateway.log 2>&1 &
GATEWAY_PID=$!
cd ..
sleep 8

echo "[2/9] 正在启动用户服务..."
cd erp_user
mvn spring-boot:run > ../logs/user.log 2>&1 &
USER_PID=$!
cd ..
sleep 5

echo "[3/9] 正在启动订单服务..."
cd erp_order
mvn spring-boot:run > ../logs/order.log 2>&1 &
ORDER_PID=$!
cd ..
sleep 5

echo "[4/9] 正在启动支付服务..."
cd erp_pay
mvn spring-boot:run > ../logs/pay.log 2>&1 &
PAY_PID=$!
cd ..
sleep 5

echo "[5/9] 正在启动促销服务..."
cd erp_promotion
mvn spring-boot:run > ../logs/promotion.log 2>&1 &
PROMOTION_PID=$!
cd ..
sleep 5

echo "[6/9] 正在启动采购服务..."
cd erp_purchase
mvn spring-boot:run > ../logs/purchase.log 2>&1 &
PURCHASE_PID=$!
cd ..
sleep 5

echo "[7/9] 正在启动退款服务..."
cd erp_refund
mvn spring-boot:run > ../logs/refund.log 2>&1 &
REFUND_PID=$!
cd ..
sleep 5

echo "[8/9] 正在启动补货服务..."
cd erp_replenishment
mvn spring-boot:run > ../logs/replenishment.log 2>&1 &
REPLENISHMENT_PID=$!
cd ..
sleep 5

echo "[9/9] 正在启动系统入口页面..."
cd erp-starter
mvn spring-boot:run > ../logs/starter.log 2>&1 &
STARTER_PID=$!
cd ..
sleep 5

echo ""
echo "============================================================"
echo "                   所有服务启动完成！"
echo "============================================================"
echo ""
echo "系统入口地址："
echo "  http://localhost:9000  （系统入口页面）"
echo "  http://localhost:8080   （网关入口）"
echo ""
echo "请等待30-60秒让所有服务完全启动..."
echo "启动完成后，浏览器将自动打开系统入口页面"
echo ""
echo "============================================================"
sleep 30

# 根据操作系统打开浏览器
if [[ "$OSTYPE" == "darwin"* ]]; then
    open http://localhost:9000
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open http://localhost:9000 2>/dev/null || echo "请手动打开浏览器访问 http://localhost:9000"
else
    echo "请手动打开浏览器访问 http://localhost:9000"
fi

echo ""
echo "系统入口页面已在浏览器中打开"
echo ""
echo "服务进程ID："
echo "  网关服务: $GATEWAY_PID"
echo "  用户服务: $USER_PID"
echo "  订单服务: $ORDER_PID"
echo "  支付服务: $PAY_PID"
echo "  促销服务: $PROMOTION_PID"
echo "  采购服务: $PURCHASE_PID"
echo "  退款服务: $REFUND_PID"
echo "  补货服务: $REPLENISHMENT_PID"
echo "  入口页面: $STARTER_PID"
echo ""
echo "如需停止服务，请使用以下命令："
echo "  kill $GATEWAY_PID $USER_PID $ORDER_PID $PAY_PID $PROMOTION_PID $PURCHASE_PID $REFUND_PID $REPLENISHMENT_PID $STARTER_PID"
echo ""

