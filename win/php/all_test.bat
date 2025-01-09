@echo off

set SHELL_PATH=%~dp0
set LIB_PATH=%SHELL_PATH%lib
set DEVEL_PACK_PATH=%SHELL_PATH%lib\devel-pack
set TEST1_DIR_PHP_56=%SHELL_PATH%cubrid-php-5-6\tests\
set TEST1_DIR_PHP_71=%SHELL_PATH%cubrid-php-7-1\tests_7\
set TEST1_DIR_PHP_74=%SHELL_PATH%cubrid-php-7-4\tests_74\
set TEST2_DIR_PHP_56=%SHELL_PATH%cubrid-php-5-6\tests2\
set TEST2_DIR_PHP_71=%SHELL_PATH%cubrid-php-7-1\tests2_7\
set TEST2_DIR_PHP_74=%SHELL_PATH%cubrid-php-7-4\tests2_74\

set TEST1_RESULT_56=%SHELL_PATH%result\result_test1_php56
set TEST1_RESULT_71=%SHELL_PATH%result\result_test1_php71
set TEST1_RESULT_74=%SHELL_PATH%result\result_test1_php74
set TEST2_RESULT_56=%SHELL_PATH%result\result_test2_php56
set TEST2_RESULT_71=%SHELL_PATH%result\result_test2_php71
set TEST2_RESULT_74=%SHELL_PATH%result\result_test2_php74


echo SHELL_PATH %SHELL_PATH%

for /F "tokens=2 delims=0-" %%f in ("%1") do for /F "tokens=1 delims=1." %%g in ("%%f") do set PHP_MAJOR_VERSION=%%g
for /F "tokens=2 delims=0-" %%f in ("%1") do for /F "tokens=2 delims=2." %%g in ("%%f") do set PHP_MINOR_VERSION=%%g

IF NOT EXIST "%SHELL_PATH%result" (
  mkdir %SHELL_PATH%result
)

echo "PHP_MAJOR_VERSION : %PHP_MAJOR_VERSION% ,  PHP_MINOR_VERSION : %PHP_MINOR_VERSION%"
echo "################### TEST1 #####################"

IF "%PHP_MAJOR_VERSION%"=="5" (
  echo "Testing php-5.6-ts-x64"
  call %SHELL_PATH%test.bat %LIB_PATH%\php-5.6.31-Win32-vc11-x64\php.exe %TEST1_DIR_PHP_56% > %TEST1_RESULT_56%
  echo "Testing php-5.6-nts-x64"
  call %SHELL_PATH%test.bat %LIB_PATH%\php-5.6.31-nts-Win32-vc11-x64\php.exe %TEST1_DIR_PHP_56% >> %TEST1_RESULT_56%
  echo "Testing php-5.6-ts-x86"
  call %SHELL_PATH%test.bat %LIB_PATH%\php-5.6.31-Win32-vc11-x86\php.exe %TEST1_DIR_PHP_56% >> %TEST1_RESULT_56%
  echo "Testing php-5.6-nts-x86"
  call %SHELL_PATH%test.bat %LIB_PATH%\php-5.6.31-nts-Win32-vc11-x86\php.exe %TEST1_DIR_PHP_56% >> %TEST1_RESULT_56%
  echo "End Test Result is : %TEST1_RESULT_56%"
) ELSE (
  IF "%PHP_MINOR_VERSION%"=="1" (
    echo "Testing php-7.1-ts-x64"
    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.1.8-Win32-vc14-x64\php.exe %TEST1_DIR_PHP_71% > %TEST1_RESULT_71%
    echo "Testing php-7.1-nts-x64"
    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.1.8-nts-Win32-vc14-x64\php.exe %TEST1_DIR_PHP_71% >> %TEST1_RESULT_71%
    echo "Testing php-7.1-ts-x86"
    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.1.8-Win32-vc14-x86\php.exe %TEST1_DIR_PHP_71% >> %TEST1_RESULT_71%
    echo "Testing php-7.1-nts-x86"
    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.1.8-nts-Win32-vc14-x86\php.exe %TEST1_DIR_PHP_71% >> %TEST1_RESULT_71%
    echo "End Test Result is : %TEST1_RESULT_71%"
  ) ELSE IF "%PHP_MINOR_VERSION%"=="4" (
REM    echo "Testing php-7.4-ts-x64"
REM    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.4.2-Win32-vc15-x64\php.exe %TEST1_DIR_PHP_74% > %TEST1_RESULT_74%
REM    echo "Testing php-7.4-nts-x64"
REM    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.4.2-nts-Win32-vc15-x64\php.exe %TEST1_DIR_PHP_74% >> %TEST1_RESULT_74%
REM    echo "Testing php-7.4-ts-x86"
REM    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.4.2-Win32-vc15-x86\php.exe %TEST1_DIR_PHP_74% >> %TEST1_RESULT_74%
REM    echo "Testing php-7.4-nts-x86"
REM    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.4.2-nts-Win32-vc15-x86\php.exe %TEST1_DIR_PHP_74% >> %TEST1_RESULT_74%
    echo "End Test Result is : %TEST1_RESULT_74%"
  )
)

echo "###############TEST2 #############################"

IF "%PHP_MAJOR_VERSION%"=="5" (
    echo "Testing php-5.6-ts-x64"
    call %SHELL_PATH%test.bat %LIB_PATH%\php-5.6.31-Win32-vc11-x64\php.exe %TEST2_DIR_PHP_56% > %TEST2_RESULT_56%
) ELSE (
  IF "%PHP_MINOR_VERSION%"=="1" (
    echo "Testing php-7.1-ts-x64"
  ) ELSE IF "%PHP_MINOR_VERSION%"=="4" (
    echo "Testing php-7.4-ts-x64"
REM    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.4.2-Win32-vc15-x64\php.exe %TEST2_DIR_PHP_74% test2 > %TEST2_RESULT_74%
    call %SHELL_PATH%test.bat %LIB_PATH%\php-7.4.2-Win32-vc15-x64\php.exe %TEST2_DIR_PHP_74% test2
    echo "End Test Result is : %TEST2_RESULT_74%"
  )
)
