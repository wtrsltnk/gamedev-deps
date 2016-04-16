@echo off

cd "%~dp0"

if not exist glfw3.zip (..\curl --location --insecure --url https://github.com/glfw/glfw/releases/download/3.1.2/glfw-3.1.2.bin.WIN64.zip > glfw3.zip)

..\7z x -r -y -o. glfw3.zip

set unzipdir="empty"
for /D %%A IN ("glfw-3*") DO set unzipdir=%%A

mkdir include
mkdir include\GLFW
mkdir lib
mkdir bin

REM copy the following file types: .h, .lib and .dll
for /D %%B IN ("%unzipdir%\include\GLFW") DO copy %%B\*.h include\GLFW\
for /D %%B IN ("%unzipdir%\lib-mingw-w64") DO copy %%B\*.a lib
for /D %%B IN ("%unzipdir%\lib-mingw-w64") DO copy %%B\*.dll bin

del glfw3.zip
rmdir /s /q %unzipdir%

goto End

:End
pause
