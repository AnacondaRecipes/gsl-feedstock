mkdir build
pushd build

copy /y "%RECIPE_DIR%\windows_shared.gsl_types.h" "%LIBRARY_INC%\gsl\gsl_types.h"

cmake %SRC_DIR% -G "%CMAKE_GENERATOR%" ^
                    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
                    -DBUILD_SHARED_LIBS=ON ^
                    ..
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1
