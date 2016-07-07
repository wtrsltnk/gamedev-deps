set CMAKE_URL=http://www.cmake.org/files/v3.2/cmake-3.2.1-win32-x86.zip

cd "%~dp0"

if not exist cmake.zip bin\curl -L %CMAKE_URL% > cmake.zip

bin\7z  x -r -y -o. cmake.zip

set cmakedir="empty"
for /D %%A IN ("cmake-3*") DO set cmakedir=%%A

move %cmakedir% bin\cmake

del cmake.zip
