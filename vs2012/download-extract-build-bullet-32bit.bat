@echo off

@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR

cd "%~dp0"

bin\curl --location --url https://github.com/bulletphysics/bullet3/archive/master.zip > bullet.zip
bin\7z x -r -y -o. bullet.zip

mkdir bullet3-master-build

cd bullet3-master-build
..\bin\cmake\bin\cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_BULLET3=OFF -G "Visual Studio 11" ../bullet3-master

MSBuild.exe BULLET_PHYSICS.sln /t:Rebuild /p:Configuration=Release /p:Platform=Win32

mkdir ..\lib
mkdir ..\bin
mkdir ..\include
mkdir ..\include\BulletCollision\BroadPhaseCollision
mkdir ..\include\BulletCollision\CollisionDispatch
mkdir ..\include\BulletCollision\CollisionShapes
mkdir ..\include\BulletCollision\Gimpact
mkdir ..\include\BulletCollision\NarrowPhaseCollision
mkdir ..\include\BulletDynamics
mkdir ..\include\BulletDynamics\Character
mkdir ..\include\BulletDynamics\ConstraintSolver
mkdir ..\include\BulletDynamics\Dynamics
mkdir ..\include\BulletDynamics\Featherstone
mkdir ..\include\BulletDynamics\MLCPSolvers   
mkdir ..\include\BulletDynamics\Vehicle
mkdir ..\include\LinearMath

copy lib\Debug\*.dll ..\bin\
copy lib\Debug\*.lib ..\lib\
copy lib\Debug\*.pdb ..\lib\
copy ..\bullet3-master\src\BulletCollision\BroadPhaseCollision\*.h ..\include\BulletCollision\BroadPhaseCollision\
copy ..\bullet3-master\src\BulletCollision\CollisionDispatch\*.h ..\include\BulletCollision\CollisionDispatch\
copy ..\bullet3-master\src\BulletCollision\CollisionShapes\*.h ..\include\BulletCollision\CollisionShapes\
copy ..\bullet3-master\src\BulletCollision\Gimpact\*.h ..\include\BulletCollision\Gimpact\
copy ..\bullet3-master\src\BulletCollision\NarrowPhaseCollision\*.h ..\include\BulletCollision\NarrowPhaseCollision\
copy ..\bullet3-master\src\BulletDynamics\*.h ..\include\BulletDynamics\
copy ..\bullet3-master\src\BulletDynamics\Character\*.h ..\include\BulletDynamics\Character\
copy ..\bullet3-master\src\BulletDynamics\ConstraintSolver\*.h ..\include\BulletDynamics\ConstraintSolver\
copy ..\bullet3-master\src\BulletDynamics\Dynamics\*.h ..\include\BulletDynamics\Dynamics\
copy ..\bullet3-master\src\BulletDynamics\Featherstone\*.h ..\include\BulletDynamics\Featherstone\
copy ..\bullet3-master\src\BulletDynamics\MLCPSolvers\*.h ..\include\BulletDynamics\MLCPSolvers\
copy ..\bullet3-master\src\BulletDynamics\Vehicle\*.h ..\include\BulletDynamics\Vehicle\
copy ..\bullet3-master\src\LinearMath\*.h ..\include\LinearMath\

cd ../

del bullet.zip
rmdir /s /q bullet3-master
rmdir /s /q bullet3-master-build

@exit /B 0

:error_no_VSINSTALLDIR
@echo ERROR: You should run this bat file from your Developer Command Prompt for VS2012
pause