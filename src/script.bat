:: Display directory contents
echo off

setlocal EnableDelayedExpansion

cls

::Accesses each subdirectory and checks for files needing merge
for /R "%cd%" %%e in (.) do (
    cd "%%e"

    if exist *.666* call :merge
)

goto END



::Main subroutine
:merge

echo.
echo Currently in %cd%
echo.

::Find every unique filename with a .666xx extension
set /a "ID=1"
for %%f in (*.66600) do (
    set filename[!ID!]=%%~nf
    set /a "ID+=1"
)

::Lists which split files we found
echo.
echo FOUND THESE SPLIT FILES
:: Make a count of how many 'filename[n]' variables
for /f %%a in ('set filename^|find /c /v ""') do set count=%%a
:: Then display them using a for from 1 to 'count'
for /l %%a in (1,1, %count%) do echo !filename[%%a]!

::------------Now start merging------------

for /l %%a in (1,1, %count%) do (
    echo.
    echo -----Merging !filename[%%a]! -------
    copy /b !filename[%%a]!.666* "!filename[%%a]!"
)

::Unset the filename variable(s)
for /l %%a in (1,1, %count%) do set filename[%%a]=

exit /b



:END
echo.
echo Program has ended
pause