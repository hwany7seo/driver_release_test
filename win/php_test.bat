@echo off

set SHELL_PATH=%~dp0
set arg1=%1
set arg2=%2

cd %arg2%
echo %arg2%
echo %SHELL_PATH%

set TEST_PHP_EXECUTABLE=%arg1%

%TEST_PHP_EXECUTABLE% run-tests.php *.phpt

cd %SHELL_PATH%
