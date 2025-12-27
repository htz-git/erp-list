@echo off
chcp 65001 >nul
title Nacos 服务启动

echo.
echo ============================================================
echo                    Nacos 服务启动程序
echo ============================================================
echo.

REM 检查 Nacos 目录是否存在
set NACOS_HOME=%~dp0nacos
if not exist "%NACOS_HOME%" (
    echo [错误] 未找到 Nacos 目录！
    echo.
    echo 请确保 Nacos 已解压到以下位置之一：
    echo   1. %~dp0nacos
    echo   2. E:\nacos
    echo   3. D:\nacos
    echo.
    echo 如果 Nacos 在其他位置，请修改本脚本中的 NACOS_HOME 变量
    echo.
    pause
    exit /b 1
)

REM 检查 Nacos 是否已启动
netstat -ano | findstr ":8848" >nul 2>&1
if %errorlevel% == 0 (
    echo [提示] Nacos 服务已在运行中（端口 8848）
    echo.
    echo 访问地址：http://localhost:8848/nacos
    echo 默认用户名：nacos
    echo 默认密码：nacos
    echo.
    pause
    exit /b 0
)

echo [1/3] 检查 Java 环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Java 环境！
    echo 请先安装 JDK 1.8 或更高版本，并配置 JAVA_HOME 环境变量
    echo.
    pause
    exit /b 1
)
echo [✓] Java 环境检查通过

echo.
echo [2/3] 正在启动 Nacos 服务...
echo Nacos 目录：%NACOS_HOME%
echo.

cd /d "%NACOS_HOME%\bin"
if not exist "startup.cmd" (
    echo [错误] 未找到 Nacos 启动脚本！
    echo 请检查 Nacos 是否正确解压
    echo.
    pause
    exit /b 1
)

echo 启动命令：startup.cmd -m standalone
echo.
startup.cmd -m standalone

echo.
echo [3/3] 等待 Nacos 启动完成...
echo.

REM 等待 Nacos 启动（最多等待 60 秒）
set /a count=0
:wait_loop
timeout /t 2 /nobreak >nul
netstat -ano | findstr ":8848" >nul 2>&1
if %errorlevel% == 0 (
    echo [✓] Nacos 启动成功！
    echo.
    echo ============================================================
    echo                    Nacos 启动完成
    echo ============================================================
    echo.
    echo 访问地址：http://localhost:8848/nacos
    echo 默认用户名：nacos
    echo 默认密码：nacos
    echo.
    echo 提示：Nacos 控制台将在浏览器中自动打开
    echo.
    timeout /t 3 /nobreak >nul
    start http://localhost:8848/nacos
    echo.
    pause
    exit /b 0
)
set /a count+=1
if %count% geq 30 (
    echo [警告] Nacos 启动超时，请检查日志文件
    echo 日志位置：%NACOS_HOME%\logs\start.out
    echo.
    pause
    exit /b 1
)
goto wait_loop


