@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: %~nx0 ^<directory^> [pattern] [options]
    echo Options:
    echo   --help        Show this help message
    echo   --hidden      Include hidden files
    echo   --readonly    Include read-only files
    echo   --archive     Include archive files
    exit /b 2
)

set include_hidden=false
set include_readonly=false
set include_archive=false

for %%i in (%*) do (
    if "%%i"=="--help" (
        echo Usage: %~nx0 ^<directory^> [pattern] [options]
        echo Options:
        echo   --help        Show this help message
        echo   --hidden      Include hidden files
        echo   --readonly    Include read-only files
        echo   --archive     Include archive files
        exit /b 0
    ) else if "%%i"=="--hidden" (
        set include_hidden=true
    ) else if "%%i"=="--readonly" (
        set include_readonly=true
    ) else if "%%i"=="--archive" (
        set include_archive=true
    )
)

set "directory=%~1"
set "pattern=*"
if "%~2" neq "" (
    set "pattern=%~2"
)


set count=0


set dir_cmd=dir /b /s /a:-h-r


if "%include_hidden%"=="true" (
    for /f "delims=" %%f in ('dir /b /s /a:h "%directory%\%pattern%"') do (
        set /a count+=1
    )
)


if "%include_readonly%"=="true" (
    for /f "delims=" %%f in ('dir /b /s /a:r "%directory%\%pattern%"') do (
        set /a count+=1
    )
)


if "%include_archive%"=="true" (
    for /f "delims=" %%f in ('dir /b /s /a:a "%directory%\%pattern%"') do (
        set /a count+=1
    )
)

for /f "delims=" %%f in ('dir /b /s /a:-h-r "%directory%\%pattern%"') do (
    set /a count+=1
)

echo Number of files matching pattern '%pattern%' in directory '%directory%' and its subdirectories: %count%
echo Exit code: 0
exit /b 0