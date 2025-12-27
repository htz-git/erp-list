@echo off
echo ====================================
echo 启动ERP跨境电商管理系统所有服务
echo ====================================
echo.

echo 正在启动网关服务...
start "ERP-Gateway" cmd /k "cd erp-gateway && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo 正在启动用户服务...
start "ERP-User-Service" cmd /k "cd erp_user && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo 正在启动订单服务...
start "ERP-Order-Service" cmd /k "cd erp_order && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo 正在启动支付服务...
start "ERP-Pay-Service" cmd /k "cd erp_pay && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo 正在启动促销服务...
start "ERP-Promotion-Service" cmd /k "cd erp_promotion && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo 正在启动采购服务...
start "ERP-Purchase-Service" cmd /k "cd erp_purchase && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo 正在启动退款服务...
start "ERP-Refund-Service" cmd /k "cd erp_refund && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo 正在启动补货服务...
start "ERP-Replenishment-Service" cmd /k "cd erp_replenishment && mvn spring-boot:run"
timeout /t 3 /nobreak >nul

echo.
echo ====================================
echo 所有服务启动完成！
echo ====================================
echo 网关入口: http://localhost:8080
echo 请等待所有服务启动完成后再访问
echo ====================================
pause


