#!/bin/bash

echo "===================================="
echo "启动ERP跨境电商管理系统所有服务"
echo "===================================="
echo ""

echo "正在启动网关服务..."
cd erp-gateway
mvn spring-boot:run &
sleep 5

echo "正在启动用户服务..."
cd ../erp_user
mvn spring-boot:run &
sleep 3

echo "正在启动订单服务..."
cd ../erp_order
mvn spring-boot:run &
sleep 3

echo "正在启动支付服务..."
cd ../erp_pay
mvn spring-boot:run &
sleep 3

echo "正在启动促销服务..."
cd ../erp_promotion
mvn spring-boot:run &
sleep 3

echo "正在启动采购服务..."
cd ../erp_purchase
mvn spring-boot:run &
sleep 3

echo "正在启动退款服务..."
cd ../erp_refund
mvn spring-boot:run &
sleep 3

echo "正在启动补货服务..."
cd ../erp_replenishment
mvn spring-boot:run &
sleep 3

echo ""
echo "===================================="
echo "所有服务启动完成！"
echo "===================================="
echo "网关入口: http://localhost:8080"
echo "请等待所有服务启动完成后再访问"
echo "===================================="


