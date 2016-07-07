@echo off

cd "%~dp0"

@rem Add path to MSBuild Binaries
@if exist "%ProgramFiles%\MSBuild\11.0\bin" set PATH=%ProgramFiles%\MSBuild\11.0\bin;%PATH%
@if exist "%ProgramFiles(x86)%\MSBuild\11.0\bin" set PATH=%ProgramFiles(x86)%\MSBuild\11.0\bin;%PATH%

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

.\bin\7z x -r -y -o. "%curlzip%" 

set curldir="empty"
for /D %%A IN ("curl-7*") DO set curldir=%%A

cd %curldir%\winbuild

nmake /f Makefile.vc mode=static VC=11 MACHINE=x86 DEBUG=yes 

cd ..\..\

mkdir bin
copy %curldir%\builds\libcurl-vc11-x86-debug-static-ipv6-sspi-winssl\bin\curl.exe bin\curl.exe

rmdir /s /q %curldir%
@exit /B 0
