
cd "%~dp0"

bin\curl --location --url http://sourceforge.net/projects/ogl-math/files/latest/download?source=files > glm.zip

bin\7z x -r -y -o. glm.zip

move glm\glm include

del glm.zip
rmdir /s /q glm
