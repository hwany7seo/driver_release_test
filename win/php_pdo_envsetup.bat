@echo off

set SHELL_PATH=%~dp0
set LIB_PATH=%SHELL_PATH%lib\php
set DEVEL_PACK_PATH=%SHELL_PATH%lib\php\devel-pack
set SOURCE_DIR=%SHELL_PATH%

echo %SOURCE_DIR%

IF "%2"=="pdo" (
	set TARGETDIR=cubrid-pdo
	set TARGETDLL=pdo_cubrid.dll
	set slnPREFIX=pdo_cubrid
) ELSE (
	set TARGETDIR=cubrid-php 
	set TARGETDLL=php_cubrid.dll
	set slnPREFIX=php_cubrid
)


IF "%1"=="" (
	echo "usage: %0 PHP_VERSION <ex: php-5.6.31 | php-7.1.8 | php-7.4.2> Driver <ex: pdo>"
	GOTO exit
) 
REM ===================
REM PHP 64bit env
REM ===================
set PHP5_TS_SRC_X64=%DEVEL_PACK_PATH%\php-devel-pack-5.6.31-Win32-VC11-x64\php-5.6.31-devel-VC11-x64\include
set PHP5_NTS_SRC_X64=%DEVEL_PACK_PATH%\php-devel-pack-5.6.31-nts-Win32-VC11-x64\php-5.6.31-devel-VC11-x64\include

set PHP7_TS_SRC_X64=%DEVEL_PACK_PATH%\php-devel-pack-7.1.8-Win32-VC14-x64\php-7.1.8-devel-VC14-x64\include
set PHP7_NTS_SRC_X64=%DEVEL_PACK_PATH%\php-devel-pack-7.1.8-nts-Win32-VC14-x64\php-7.1.8-devel-VC14-x64\include

set PHP74_TS_SRC_X64=%DEVEL_PACK_PATH%\php-devel-pack-7.4.29-Win32-vc15-x64\php-7.4.29-devel-vc15-x64\include
set PHP74_NTS_SRC_X64=%DEVEL_PACK_PATH%\php-devel-pack-7.4.29-nts-Win32-vc15-x64\php-7.4.29-devel-vc15-x64\include


set PHP5_NTS_X64=%LIB_PATH%\php-5.6.31-nts-Win32-VC11-x64
set PHP5_TS_X64=%LIB_PATH%\php-5.6.31-Win32-VC11-x64

set PHP7_NTS_X64=%LIB_PATH%\php-7.1.8-nts-Win32-VC14-x64
set PHP7_TS_X64=%LIB_PATH%\php-7.1.8-Win32-VC14-x64

set PHP74_NTS_X64=%LIB_PATH%\php-7.4.29-nts-Win32-vc15-x64
set PHP74_TS_X64=%LIB_PATH%\php-7.4.29-Win32-vc15-x64
REM ===================


REM ===================
REM PHP 32bit env
REM ===================
set PHP5_TS_SRC_X86=%DEVEL_PACK_PATH%\php-devel-pack-5.6.31-Win32-VC11-x86\php-5.6.31-devel-VC11-x86\include
set PHP5_NTS_SRC_X86=%DEVEL_PACK_PATH%\php-devel-pack-5.6.31-nts-Win32-VC11-x86\php-5.6.31-devel-VC11-x86\include
set PHP7_TS_SRC_X86=%DEVEL_PACK_PATH%\php-devel-pack-7.1.8-Win32-VC14-x86\php-7.1.8-devel-VC14-x86\include
set PHP7_NTS_SRC_X86=%DEVEL_PACK_PATH%\php-devel-pack-7.1.8-nts-Win32-VC14-x86\php-7.1.8-devel-VC14-x86\include
set PHP74_TS_SRC_X86=%DEVEL_PACK_PATH%\php-devel-pack-7.4.29-Win32-vc15-x86\php-7.4.29-devel-vc15-x86\include
set PHP74_NTS_SRC_X86=%DEVEL_PACK_PATH%\php-devel-pack-7.4.29-nts-Win32-vc15-x86\php-7.4.29-devel-vc15-x86\include


set PHP5_NTS_X86=%LIB_PATH%\php-5.6.31-nts-Win32-VC11-x86
set PHP5_TS_X86=%LIB_PATH%\php-5.6.31-Win32-VC11-x86
set PHP7_NTS_X86=%LIB_PATH%\php-7.1.8-nts-Win32-VC14-x86
set PHP7_TS_X86=%LIB_PATH%\php-7.1.8-Win32-VC14-x86
set PHP74_NTS_X86=%LIB_PATH%\php-7.4.29-nts-Win32-vc15-x86
set PHP74_TS_X86=%LIB_PATH%\php-7.4.29-Win32-vc15-x86
REM ===================

echo %PHP74_TS_SRC_X64%
echo %PHP74_NTS_SRC_X64%
echo %PHP74_TS_SRC_X86%
echo %PHP74_NTS_SRC_X86%

set PHP5_SRC=""
set PHP7_SRC=""
REM set PHPRC=""

set dir=%SOURCE_DIR%
set php=%1

for /F "tokens=2 delims=0-" %%f in ("%1") do for /F "tokens=1 delims=1." %%g in ("%%f") do set PHP_MAJOR_VERSIN=%%g
for /F "tokens=2 delims=0-" %%f in ("%1") do for /F "tokens=2 delims=2." %%g in ("%%f") do set PHP_MINOR_VERSIN=%%g


IF "%PHP_MAJOR_VERSIN%"=="5" (
REM	cd "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC"
	call "%VS110COMNTOOLS%vsvars32.bat"
) ELSE IF "%PHP_MAJOR_VERSIN%"=="7" (
REM	cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools"
	call "%VS2017COMNTOOLS%VsDevCmd.bat"
) ELSE (
	echo "1st parameter is undefined"
	GOTO exit
)

set CUBRID_PHP_HOME=%SOURCE_DIR%/%TARGETDIR%
IF NOT EXIST %CUBRID_PHP_HOME% (
	echo "%TARGETDIR% is missing or the other name"
	GOTO exit
)

echo "Start build %TARGETDIR% %PHP_MAJOR_VERSIN% %PHP_MINOR_VERSIN%..."
cd %CUBRID_PHP_HOME%
rm -rvf %slnPREFIX%___x64_Release_NTS %slnPREFIX%___x64_Release_TS
rm -rvf %slnPREFIX%___Win32_Release_NTS %slnPREFIX%___Win32_Release_TS

IF "%PHP_MAJOR_VERSIN%"=="5" (
	set PHP7_SRC=""

	REM ===================
	REM PHP 64bit build
	REM ===================
	set PHP5_SRC=%PHP5_NTS_SRC_X64%
	set PHPRC=%PHP5_NTS_X64%
    MSBuild.exe %slnPREFIX%.sln /t:Rebuild /p:Configuration=Release_NTS /p:Platform=x64
	
	set PHP5_SRC=%PHP5_TS_SRC_X64%
	set PHPRC=%PHP5_TS_X64%
    MSBuild.exe %slnPREFIX%.sln /t:Rebuild /p:Configuration=Release_TS /p:Platform=x64

	REM ===================
	REM PHP 32bit build
	REM ===================	
	set PHP5_SRC=%PHP5_NTS_SRC_X86%
	set PHPRC=%PHP5_NTS_X86%
    MSBuild.exe %slnPREFIX%.sln /t:Rebuild /p:Configuration=Release_NTS /p:Platform=Win32
	
	set PHP5_SRC=%PHP5_TS_SRC_X86%
	set PHPRC=%PHP5_TS_X86%
    MSBuild.exe %slnPREFIX%.sln /t:Rebuild /p:Configuration=Release_TS /p:Platform=Win32
	
) ELSE IF "%PHP_MAJOR_VERSIN%"=="7" (
	set PHP5_SRC=""
	
	IF "%PHP_MINOR_VERSIN%"=="1" (
		REM ===================
		REM PHP 64bit build
		REM ===================
		set PHP7_SRC=%PHP7_NTS_SRC_X64%
		set PHPRC=%PHP7_NTS_X64%
		devenv %slnPREFIX%_7.sln /rebuild "Release_NTS|x64"
		
		set PHP7_SRC=%PHP7_TS_SRC_X64%
		set PHPRC=%PHP7_TS_X64%
		devenv %slnPREFIX%_7.sln /rebuild "Release_TS|x64"

		REM ===================
		REM PHP 32bit build
		REM ===================	
		set PHP7_SRC=%PHP7_NTS_SRC_X86%
		set PHPRC=%PHP7_NTS_X86%
		devenv %slnPREFIX%_7.sln /rebuild "Release_NTS|Win32"
		
		set PHP7_SRC=%PHP7_TS_SRC_X86%
		set PHPRC=%PHP7_TS_X86%
		devenv %slnPREFIX%_7.sln /rebuild "Release_TS|Win32"
		
	) ELSE IF "%PHP_MINOR_VERSIN%"=="4" (
		REM ===================
		REM PHP 32bit build
		REM ===================	
		set PHP7_SRC=%PHP74_NTS_SRC_X86%
		set PHPRC=%PHP74_NTS_X86%
		devenv %slnPREFIX%_7.sln /rebuild "Release_NTS|Win32"

		set PHP7_SRC=%PHP74_TS_SRC_X86%
		set PHPRC=%PHP74_TS_X86%
		devenv %slnPREFIX%_7.sln /rebuild "Release_TS|Win32"
    
    REM ===================
		REM PHP 64bit build
		REM ===================	
		set PHP7_SRC=%PHP74_NTS_SRC_X64%
		set PHPRC=%PHP74_NTS_X64%
		devenv %slnPREFIX%_7.sln /rebuild "Release_NTS|x64"

		set PHP7_SRC=%PHP74_TS_SRC_X64%
		set PHPRC=%PHP74_TS_X64%
		devenv %slnPREFIX%_7.sln /rebuild "Release_TS|x64"
	
	) ELSE (
		echo "check minor version"
		@exit
	)
)


echo "PHP env....."
echo "PHP5_SRC : %PHP5_SRC%"
echo "PHP7_SRC: %PHP7_SRC%"
echo "PHPRC : %PHPRC%"

:exit
echo "PHP env....."

cd %dir%
