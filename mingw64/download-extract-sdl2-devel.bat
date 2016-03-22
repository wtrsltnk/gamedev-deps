@echo off

cd "%~dp0"

..\curl --location --insecure --url http://libsdl.org/release/SDL2-devel-2.0.4-mingw.tar.gz > sdl2.zip

..\7z x -r -y -o. sdl2.zip
..\7z x -r -y -o. sdl2

set sdldir="empty"
for /D %%A IN ("SDL2*") DO set sdldir=%%A

mkdir include
mkdir include\sdl2
mkdir lib
mkdir bin

REM copy the following file types: .h, .lib and .dll
for /D %%B IN ("%sdldir%\include") DO copy %%B\*.h include\sdl2\
for /D %%B IN ("%sdldir%\lib\x64") DO copy %%B\*.lib lib
for /D %%B IN ("%sdldir%\lib\x64") DO copy %%B\*.dll bin

del sdl2.zip
del sdl2
rmdir /s /q %sdldir%
