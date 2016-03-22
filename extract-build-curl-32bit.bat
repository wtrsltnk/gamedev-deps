@echo off

cd "%~dp0"

@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR

:start

set curlzip="empty"
for %%A IN ("curl-7*.zip") DO set curlzip=%%A

if exist %curlzip% goto extract

echo You have not yet downloaded curl. Press enter to go to the website
pause

start http://curl.haxx.se/latest.cgi?curl=zip

echo Press enter again when the curl zip is in this directory
pause

goto start

:extract

7z x -r -y -o. "%curlzip%" 

set curldir="empty"
for /D %%A IN ("curl-7*") DO set curldir=%%A

cd %curldir%\winbuild

nmake /f Makefile.vc mode=static VC=11 MACHINE=x86 DEBUG=yes 

cd ..\..\

mkdir bin
copy %curldir%\builds\libcurl-vc11-x86-debug-static-ipv6-sspi-winssl\bin\curl.exe bin\curl.exe

mkdir lib
copy %curldir%\builds\libcurl-vc11-x86-debug-static-ipv6-sspi-winssl\lib\libcurl_a_debug.lib lib\libcurl.lib

mkdir include
mkdir include\curl
copy %curldir%\builds\libcurl-vc11-x86-debug-static-ipv6-sspi-winssl\include\curl\*.h include\curl

rmdir /s /q %curldir%
@exit /B 0

:error_no_VSINSTALLDIR
@echo ERROR: You should run this bat file from your Developer Command Prompt for VS2012
pause