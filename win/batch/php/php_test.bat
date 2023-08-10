@echo off

set arg1=%1
set arg2=%2

cd %arg2%

set TEST_PHP_EXECUTABLE=%arg1%

%TEST_PHP_EXECUTABLE% run-tests.php *.phpt

cd ..