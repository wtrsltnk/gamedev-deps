REM @echo off

@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR

set PA_URL=http://www.portaudio.com/archives/pa_stable_v19_20140130.tgz

cd "%~dp0"

bin\curl -L %PA_URL% > pa.tgz
bin\7z  x -r -y -o. pa.tgz
bin\7z  x -r -y -o. pa.tar

set PA_DIR=portaudio

mkdir pabuild
cd pabuild
cmake -G "Visual Studio 11" "..\%PA_DIR%"

MSBuild.exe portaudio.sln /t:Rebuild /p:Configuration=Release /p:Platform=x64

mkdir ..\lib
mkdir ..\bin
mkdir ..\include

copy Release\*.lib ..\lib\
copy Release\*.dll ..\bin\
copy ..\%PA_DIR%\include\*.h ..\include\

cd ..

:clean_and_exit

rmdir /s /q %PA_DIR%
rmdir /s /q pabuild
del pa.tgz
del pa.tar

@exit /B 0

:error_no_VSINSTALLDIR
@echo ERROR: You should run this bat file from your Developer Command Prompt for VS2012
pause
goto clean_and_exit

:error_no_PA_DIR
@echo ERROR: No Portaudio found
pause
goto clean_and_exit
