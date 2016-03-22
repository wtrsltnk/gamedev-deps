
cd "%~dp0"

mkdir include

..\curl --location --insecure --url http://sourceforge.net/projects/ogl-math/files/latest/download?source=files > glm.zip

..\7z x -r -y -o. glm.zip
pause
move glm\glm include

del glm.zip
rmdir /s /q glm
