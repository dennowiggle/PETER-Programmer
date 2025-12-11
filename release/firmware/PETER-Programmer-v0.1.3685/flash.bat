@ECHO OFF
SET "comport="
SET "baudrate="
CALL SET "comport=%%1"
CALL SET "baudrate=%%2"
IF defined comport GOTO :baudrate

:nocomport
@ECHO Usage: flash ^[COM_PORT^] ^<BAUDRATE^>
exit /b %ERRORLEVEL%

:baudrate
IF defined baudrate GOTO :flash
CALL SET "baudrate=115200"

:flash
ECHO Flashing to ESP32-S3.
REM Booloader
".\esptool.exe" --chip esp32s3 --port %comport% --baud %baudrate% --before default-reset --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x0 ".\bootloader.bin" 
REM Partions
".\esptool.exe" --chip esp32s3 --port %comport% --baud %baudrate% --before no-reset      --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x8000  ".\partitions.bin" 
REM Boot App
".\esptool.exe" --chip esp32s3 --port %comport% --baud %baudrate% --before no-reset      --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0xe000   ".\boot_app0.bin" 
REM firmware
".\esptool.exe" --chip esp32s3 --port %comport% --baud %baudrate% --before no-reset      --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x10000  ".\firmware.bin" 
REM Filesystem
".\esptool.exe" --chip esp32s3 --port %comport% --baud %baudrate% --before no-reset      --after hard-reset write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x00670000 ".\littlefs.bin"
exit

