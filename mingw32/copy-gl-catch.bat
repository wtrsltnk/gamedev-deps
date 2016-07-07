cd "%~dp0"

mkdir include
mkdir include\GL

for /D %%B IN ("..\include\GL") DO copy %%B\*.h include\GL
copy ..\include\catch.hpp include

pause
