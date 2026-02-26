@echo off
setlocal enabledelayedexpansion
set MODULE=%~1
if "%MODULE%"=="" set MODULE=GP_maong
set BUILD_TYPE=%~2
if "%BUILD_TYPE%"=="" set BUILD_TYPE=Debug
if not exist gradlew.bat exit /b 1
call gradlew.bat :%MODULE%:clean :%MODULE%:assemble%BUILD_TYPE% -x test
exit /b %ERRORLEVEL%
