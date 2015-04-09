set PREMAKE_URL=http://sourceforge.net/projects/premake/files/Premake/4.4/premake-4.4-beta5-windows.zip/download

cd "%~dp0"

bin\curl --location --url %PREMAKE_URL% > premake4.zip
bin\7z  x -r -y -o. premake4.zip

set premakedir="empty"
for /D %%A IN ("cmake-*") DO set premakedir=%%A

move premake4.exe bin\premake4.exe

del premake4.zip
