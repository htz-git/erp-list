@echo off
chcp 65001 >nul
title ERP跨境电商管理系统 - 启动程序

echo.
echo ============================================================
echo           ERP跨境电商管理系统 - 一键启动程序
echo ============================================================
echo.
echo 本程序将自动启动所有微服务
echo.
echo 请确保：
echo   1. Nacos服务已启动（默认端口8848）
echo      - 如果未启动，请先运行 "启动Nacos.bat"
echo      - 或使用 "下载Nacos.bat" 下载并解压 Nacos
echo   2. MySQL数据库已启动并创建了相应数据库
echo   3. 已修改各服务的数据库连接配置
echo.
echo 是否已启动 Nacos？(Y/N)
set /p nacos_ready=
if /i not "%nacos_ready%"=="Y" (
    echo.
    echo 请先启动 Nacos 服务！
    echo 运行 "启动Nacos.bat" 启动 Nacos
    echo.
    pause
    exit /b 1
)
echo.

echo.
echo [1/9] 正在启动网关服务...
start "ERP-Gateway" /min cmd /k "cd erp-gateway && mvn spring-boot:run"
timeout /t 8 /nobreak >nul

echo [2/9] 正在启动用户服务...
start "ERP-User-Service" /min cmd /k "cd erp_user && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [3/9] 正在启动订单服务...
start "ERP-Order-Service" /min cmd /k "cd erp_order && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [4/9] 正在启动支付服务...
start "ERP-Pay-Service" /min cmd /k "cd erp_pay && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [5/9] 正在启动促销服务...
start "ERP-Promotion-Service" /min cmd /k "cd erp_promotion && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [6/9] 正在启动采购服务...
start "ERP-Purchase-Service" /min cmd /k "cd erp_purchase && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [7/9] 正在启动退款服务...
start "ERP-Refund-Service" /min cmd /k "cd erp_refund && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [8/9] 正在启动补货服务...
start "ERP-Replenishment-Service" /min cmd /k "cd erp_replenishment && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo [9/9] 正在启动系统入口页面...
start "ERP-Starter" /min cmd /k "cd erp-starter && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

echo.
echo ============================================================
echo                   所有服务启动完成！
echo ============================================================
echo.
echo 系统入口地址：
echo   http://localhost:9000  （系统入口页面）
echo   http://localhost:8080   （网关入口）
echo.
echo 请等待30-60秒让所有服务完全启动...
echo 启动完成后，浏览器将自动打开系统入口页面
echo.
echo ============================================================
timeout /t 30 /nobreak >nul

start http://localhost:9000

echo.
echo 系统入口页面已在浏览器中打开
echo 如需停止服务，请关闭对应的命令行窗口
echo.
pause

