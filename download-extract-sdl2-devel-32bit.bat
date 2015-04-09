@echo off

cd "%~dp0"

bin\curl --location --url https://www.libsdl.org/release/SDL2-devel-2.0.3-VC.zip > sdl2.zip

bin\7z x -r -y -o. sdl2.zip

set sdldir="empty"
for /D %%A IN ("SDL2*") DO set sdldir=%%A

mkdir include
mkdir include\sdl2
mkdir lib
mkdir bin

REM copy the following file types: .h, .lib and .dll
for /D %%B IN ("%sdldir%\include") DO copy %%B\*.h include\sdl2\
for /D %%B IN ("%sdldir%\lib\x86") DO copy %%B\*.lib lib
for /D %%B IN ("%sdldir%\lib\x86") DO copy %%B\*.dll bin

del sdl2.zip
rmdir /s /q %sdldir%
