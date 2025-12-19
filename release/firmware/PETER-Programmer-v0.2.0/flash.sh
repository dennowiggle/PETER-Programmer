#! /bin/bash
BAUD=115200

if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    echo Usage: flash [SERIAL_PORT] \<BAUDRATE\>
    exit 1
fi

if [ "$#" -eq 1 ]; then
    SERIAL=$1
fi

if [ "$#" -eq 2 ]; then
    SERIAL=$1
    BAUD=$2
fi
echo Flashing to ESP32-S3.
# Booloader
esptool --chip esp32s3 --port "$SERIAL" --baud $BAUD --before default-reset --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x0 "./bootloader.bin" 
# Partions
esptool --chip esp32s3 --port "$SERIAL" --baud $BAUD --before no-reset      --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x8000  "./partitions.bin" 
# Boot App
esptool --chip esp32s3 --port "$SERIAL" --baud $BAUD --before no-reset      --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0xe000   "./boot_app0.bin" 
# firmware
esptool --chip esp32s3 --port "$SERIAL" --baud $BAUD --before no-reset      --after no-reset   write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x10000  "./firmware.bin" 
# Filesystem
esptool --chip esp32s3 --port "$SERIAL" --baud $BAUD --before no-reset      --after watchdog-reset write-flash -z --flash-mode dio --flash-freq 80m --flash-size 8MB 0x00670000 "./littlefs.bin"
