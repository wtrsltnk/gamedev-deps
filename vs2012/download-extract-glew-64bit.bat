REM use windows binaries from http://glew.sourceforge.net

cd "%~dp0"

bin\curl --location --url http://sourceforge.net/projects/glew/files/latest/download?source=typ_redirect > glew.zip

bin\7z x -r -y -o. glew.zip

set glewdir="empty"
for /D %%A IN ("glew-1.*") DO set glewdir=%%A

mkdir include
mkdir include\GL
mkdir lib
mkdir bin

copy %glewdir%\include\GL\*.h include\GL\
copy %glewdir%\lib\Release\x64\*.lib lib
copy %glewdir%\bin\Release\x64\*.dll bin

del glew.zip
rmdir /s /q %glewdir%
