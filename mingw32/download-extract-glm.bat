@echo=off

cd "%~dp0"

mkdir include

..\bin\curl -L --insecure --url http://sourceforge.net/projects/ogl-math/files/latest/download?source=files > glm.zip

..\bin\7z x -r -y -o. glm.zip

move glm\glm include

del glm.zip
rmdir /s /q glm
