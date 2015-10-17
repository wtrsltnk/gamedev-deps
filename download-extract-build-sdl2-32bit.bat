@echo off

@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR

set SDL2_URL=http://www.libsdl.org/release/SDL2-2.0.3.zip

cd "%~dp0"

bin\curl -L %SDL2_URL% > sdl2.zip
bin\7z  x -r -y -o. sdl2.zip
del sdl2.zip

set sdl2dir="empty"
for /D %%A IN ("SDL2-*") DO set sdl2dir=%%A

mkdir sdl2build
cd sdl2build
cmake -DDIRECTX=OFF -DSDL_STATIC=OFF -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 11" "..\%sdl2dir%"

MSBuild.exe SDL2.sln /t:Rebuild /p:Configuration=Release /p:Platform=Win32

mkdir ..\lib
mkdir ..\bin
mkdir ..\include
mkdir ..\include\SDL2

copy Release\*.lib ..\lib\
copy Release\*.dll ..\bin\
copy ..\%sdl2dir%\include\*.h ..\include\SDL2\
copy include\SDL_config.h ..\include\SDL2\

cd ..

rmdir /s /q %sdl2dir%
rmdir /s /q sdl2build

@exit /B 0

:error_no_VSINSTALLDIR
@echo ERROR: You should run this bat file from your Developer Command Prompt for VS2012
pause