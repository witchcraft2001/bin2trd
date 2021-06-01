rem echo OFF
set PROG=bin2trd
mkdir build
echo Unmounting old image ...
osfmount.com -D -m X:

echo Preparing floppy disk image ...
copy /Y image\dss_image.img build\%PROG%.img
rem Delay before copy image
timeout 2 > nul
osfmount.com -a -t file -o rw -f build/%PROG%.img -m X:
if errorlevel 1 goto ERR
mkdir X:\SRC
mkdir X:\EXAMPLES
copy /Y %PROG%.C X:\SRC
copy /Y build.bat X:\SRC
copy /Y EXAMPLES\*.* X:\EXAMPLES
if errorlevel 1 goto ERR
rem Delay before unmount image
timeout 2 > nul
echo Unmounting image ...
osfmount.com -d -m X:
rem Delay before copy image
timeout 2 > nul
goto SUCCESS
:ERR
rem pause
echo Some Building ERRORs!!!
rem exit
goto END
:SUCCESS
echo Copying image to ZXMAK2 Emulator
copy /Y build\%PROG%.img /B %SPRINTER_EMULATOR% /B
echo Done!
:END
pause 0