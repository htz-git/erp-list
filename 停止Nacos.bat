@echo off
chcp 65001 >nul
title 停止 Nacos 服务

echo.
echo ============================================================
echo                   停止 Nacos 服务
echo ============================================================
echo.

REM 检查 Nacos 目录
set NACOS_HOME=%~dp0nacos
if not exist "%NACOS_HOME%" (
    if exist "E:\nacos" (
        set NACOS_HOME=E:\nacos
    ) else if exist "D:\nacos" (
        set NACOS_HOME=D:\nacos
    ) else (
        echo [错误] 未找到 Nacos 目录！
        echo.
        pause
        exit /b 1
    )
)

echo Nacos 目录：%NACOS_HOME%
echo.

REM 检查 Nacos 是否在运行
netstat -ano | findstr ":8848" >nul 2>&1
if %errorlevel% neq 0 (
    echo [提示] Nacos 服务未运行
    echo.
    pause
    exit /b 0
)

echo 正在停止 Nacos 服务...
echo.

cd /d "%NACOS_HOME%\bin"
if exist "shutdown.cmd" (
    call shutdown.cmd
    echo.
    echo [✓] Nacos 服务已停止
) else (
    echo [错误] 未找到停止脚本！
)

echo.
pause


