@echo off

set SHELL_PATH=%~dp0

IF "%1"=="" (
	echo "usage: %0 PHP_VERSION <e.g.: php-5.6| php-7.1| php-7.4>"
	GOTO exit
)

for /F "tokens=2 delims=0-" %%f in ("%1") do for /F "tokens=1 delims=1." %%g in ("%%f") do set PHP_MAJOR_VERSION=%%g
for /F "tokens=2 delims=0-" %%f in ("%1") do for /F "tokens=2 delims=2." %%g in ("%%f") do set PHP_MINOR_VERSION=%%g

IF "%PHP_MAJOR_VERSION%"=="5" (
  call %SHELL_PATH%envsetup.bat php-5.6
  call %SHELL_PATH%all_test.bat php-5.6
) ELSE (
  IF "%PHP_MINOR_VERSION%"=="1" (
    call %SHELL_PATH%envsetup.bat php-7.1
    call %SHELL_PATH%all_test.bat php-7.1
  ) ELSE IF "%PHP_MINOR_VERSION%"=="4" (
    call %SHELL_PATH%envsetup.bat php-7.4
    call %SHELL_PATH%all_test.bat php-7.4
  ) ELSE (
    echo "Please Check the first argument. e.g.) php-5.6, php-7.1, php-7.4"
  )
)