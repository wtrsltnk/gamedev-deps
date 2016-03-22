@echo off

@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR

set GLFW_URL=http://github.com/glfw/glfw/releases/download/3.1.1/glfw-3.1.1.zip

cd "%~dp0"

bin\curl -L %GLFW_URL% > glfw.zip
bin\7z  x -r -y -o. glfw.zip
del glfw.zip

set glfwdir="empty"
for /D %%A IN ("glfw-*") DO set glfwdir=%%A

mkdir glfwbuild
cd glfwbuild
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 11" "..\%glfwdir%"

MSBuild.exe GLFW.sln /t:Rebuild /p:Configuration=Release /p:Platform=x64

mkdir ..\lib
mkdir ..\bin
mkdir ..\include
mkdir ..\include\GLFW

copy src\Release\*.lib ..\lib\
copy ..\%glfwdir%\include\GLFW\*.h ..\include\GLFW\

cd ..

rmdir /s /q %glfwdir%
rmdir /s /q glfwbuild

@exit /B 0

:error_no_VSINSTALLDIR
@echo ERROR: You should run this bat file from your Developer Command Prompt for VS2012
pause