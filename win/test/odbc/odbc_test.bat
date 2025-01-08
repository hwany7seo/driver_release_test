set SHELL_PATH=%~dp0
set DRVIER_NAME=cubrid-odbc

git clone git@github.com:CUBRID/%DRIVER_NAME%.git

cd .\%DRIVER_NAME%

call test.bat