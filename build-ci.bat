@echo off
setlocal enabledelayedexpansion

set MODULE=%~1
if "%MODULE%"=="" set MODULE=GP_maong
set BUILD_TYPE=%~2
if "%BUILD_TYPE%"=="" set BUILD_TYPE=Debug

:: 这里直接调用本地 Gradle
set GRADLE_HOME=D:\andorid_tools\gradle-8.14-rc-2
set PATH=%GRADLE_HOME%\bin;%PATH%

gradle :%MODULE%:clean :%MODULE%:assemble%BUILD_TYPE% -x test
exit /b %ERRORLEVEL%