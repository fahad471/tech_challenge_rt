@echo off
chcp 65001 > nul
@echo off


setlocal
echo @echo off > "%~dp0/deactivate_conanrunenv-release-x86_64.bat"
echo echo Restoring environment for conanrunenv-release-x86_64.bat >> "%~dp0/deactivate_conanrunenv-release-x86_64.bat"
for %%v in (PATH) do (
    set foundenvvar=
    for /f "delims== tokens=1,2" %%a in ('set') do (
        if /I "%%a" == "%%v" (
            echo set "%%a=%%b">> "%~dp0/deactivate_conanrunenv-release-x86_64.bat"
            set foundenvvar=1
        )
    )
    if not defined foundenvvar (
        echo set %%v=>> "%~dp0/deactivate_conanrunenv-release-x86_64.bat"
    )
)
endlocal




if defined PATH (
    set "PATH=C:\Users\izhma\.conan2\p\b\chall5297362d06c57\p\bin;C:\Users\izhma\.conan2\p\b\boostc11234b5486ab\p\bin;%PATH%"
) else (
    set "PATH=C:\Users\izhma\.conan2\p\b\chall5297362d06c57\p\bin;C:\Users\izhma\.conan2\p\b\boostc11234b5486ab\p\bin"
)