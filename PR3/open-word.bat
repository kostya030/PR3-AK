@echo off
setlocal enabledelayedexpansion

rem Перевірка наявності параметрів командного рядка
if "%~1"=="" (
    echo Usage: %~nx0 ^<path_to_word_file^>
    exit /b 1
)

rem Отримання шляху до файлу Word
set "word_file=%~1"

rem Перевірка існування файлу
if not exist "%word_file%" (
    echo File "%word_file%" does not exist.
    exit /b 1
)

rem Відкриття файлу Word в новому вікні
start "" "%word_file%"

rem Очікування закриття файлу Word
echo Waiting for Word to close...
:wait_loop
rem Перевірка, чи все ще відкритий процес WINWORD.EXE
tasklist /FI "IMAGENAME eq WINWORD.EXE" 2>NUL | find /I /N "WINWORD.EXE">NUL
if "%ERRORLEVEL%"=="0" (
    timeout /T 5 > nul
    goto wait_loop
)

echo Word has been closed.
exit /b 0