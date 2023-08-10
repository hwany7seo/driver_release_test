@echo off

set SHELL_PATH=%~dp0
set LIB_PATH=%SHELL_PATH%lib\php
set DEVEL_PACK_PATH=%SHELL_PATH%lib\php\devel-pack
set PHP_SOURCE_DIR=%SHELL_PATH%cubrid-php
set PDO_SOURCE_FIR=%SHELL_PATH%cubrid-pdo

echo SHELL_PATH %SHELL_PATH%
echo PDO_SOURCE_FIR %PDO_SOURCE_FIR%

::call php_test.bat %LIB_PATH%\php-7.4.29-Win32-vc15-x64\php.exe %PHP_SOURCE_DIR%\tests_74
::call php_test.bat %LIB_PATH%\php-7.4.29-nts-Win32-vc15-x64\php.exe %PHP_SOURCE_DIR%\tests_74
::call php_test.bat %LIB_PATH%\php-7.4.29-Win32-vc15-x86\php.exe %PHP_SOURCE_DIR%\tests_74
::call php_test.bat %LIB_PATH%\php-7.4.29-nts-Win32-vc15-x86\php.exe %PHP_SOURCE_DIR%\tests_74

::call php_test.bat %LIB_PATH%\php-7.4.29-Win32-vc15-x64\php.exe %PDO_SOURCE_FIR%\tests_74
::call php_test.bat %LIB_PATH%\php-7.4.29-nts-Win32-vc15-x64\php.exe %PDO_SOURCE_FIR%\tests_74
::call php_test.bat %LIB_PATH%\php-7.4.29-Win32-vc15-x86\php.exe %PDO_SOURCE_FIR%\tests_74
call php_test.bat %LIB_PATH%\php-7.4.29-nts-Win32-vc15-x86\php.exe %PDO_SOURCE_FIR%\tests_74


