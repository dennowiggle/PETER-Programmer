# PETER-Programmer
System controller SW for the Retro-PETER platform

## Information:
The ESP32-S3 SW is in a platformio project format. If using VS Code there is a platformio plugin. Upon opening the project folder the project should self configure.

## ESP32 Module Programming
* To program the ESP32 on the PETER board use the USB JTAG port J1202.

* Using the [Web](https://dennowiggle.github.io/PETER-Programmer/)
  - Select the file.
  - Connect and then upload.
  - Requires Microsoft Edge or Google Chrome/Chromium.

* Using Windows
  - Run the flash.bat script that is in the release directory.
  - e.g. `flash.bat COM3 115200`

* Using Linux/python
  - Install the programmer `pip install esptool`.
  - Run the flash.sh script that is in the release directory.
  - e.g. `sh flash.sh /dev/ttyACM0 115200`

* ~~Using platformio
  - First upload the filesystem.
  - Then upload the code.~~

## WiFi Setup
* On first boot the module enters WiFi host AP mode.
  - Connect local computer to WiFi network SSID "PETER-programmer" with password "Z80-Nouveau!"
  - If the local computer is set for DHCP it should be assigned an address on the PETER-Programmer network 192.168.4.x If not manually configure local computer IP address to 192.168.4.2
  - Z80-Retro! WiFi setup IP address is 192.168.4.1
  - Open a webpage at address http://192.168.4.1 to set the WiFi parameters for WiFi client mode in the local network environment. 
  - NOTE: very often a browswer will change to https:// and in that case it needs changed back to http://
* Power cycle after setting the SSID network you want to use.
* If having problems setting up WiFi the PETER-Programmer boot-up log can be seen by connecting a physical TTL level serial cable at 115200 on pins
  - Once you see the menu
    - W shows WiFi address
	- C clears WiFi settings to start the sequence again.
  
![ESP32 Z80 Retro Programmer! WiFi Setup](release/docs/WiFi_Setup.jpg "WiFi Setup")

## Web Page Use
* On the local WiFi router find the new IP address that the DHCP server assigned.
* Alternatively connect a serial cable to PETER Programmer as described below and type W to see the WiFi address assigned.
* Connect local computer to local WiFi network
* Open webage and enter the IP address assigned by DHCP server to the PETER-Programmer! 

![ESP32 Z80 Retro Programmer! WiFi Setup](release/docs/PETER-Programmer_WebPage.jpg "Web Page Use")

## Physical Serial Connection to PETER-Programmer Console
* Connect a TTL level serial cable to
  - J1105.11 RX (ESP32 Tx)
  - J1105.12 TX (ESP32 Rx)
  - J1105.13 GND

## Connecting FPGA UARTs to WiFi
* UART1 Console
  - Connect Jumper J1004 pin 2 to 4, and pin 1 to 3.
* UART2 NHACP
  - Connect Jumper J1001 pin 2 to 4, and pin 1 to 3.

## Connecting FPGA UARTs to USB
* UART1
  - Connect Jumper J1004 pin 4 to 6, and pin 3 to 5.
  - Connect USB-C cable to J1002
* UART2
  - Connect Jumper J1001 pin 4 to 6, and pin 3 to 5.
  - Connect USB-C cable to J1005

## Alternate : Connecting up Retro CPU console signals (UART1)
* To use USB interface for UART1
  - Connect CPU UART1 Tx to J1004.6
  - Connect CPU UART1 Rx to J1004.5
  - Connect USB-C cable to J1002
* To use WiFi interface for UART1 Console
  - Connect CPU UART1 Tx to J1004.2
  - Connect CPU UART1 Rx to J1004.1
  - Connect USB-C cable to J1002

## Connecting up Retro CPU NHACP signals (UART2)
* To use USB serial interface for UART2
  - Connect CPU UART2 Tx to J1001.6
  - Connect CPU UART2 Rx to J1001.5
* To use WiFi interface for UART2 NHACP
  - Connect CPU UART2 Tx to J1001.2
  - Connect CPU UART2 Rx to J1001.1

## Remote Wireless Console - to PETER-Programmer!
* There is Telnet console access to PETER-Programmer at the same IP address on port 2323
  - The jumper pins aBOVE need to be connected for WiFi mode

![Remote Wireless Console - to ESP32 Z80 Programmer!](release/docs/Telnet_ProgrammerConsole_Port_2323.jpg "Remote PETER-Programmer Console")

## Remote Wireless Console - to CPU Console Port
* There is Telnet console access to the CPU at the same IP address on port 23
* Connect the CPU console signals to  to the first ESP32 9 pin DIN. It uses the same cable as used originally in the Z80 Retro project.
* Using console access to the ESP32 Z80 Programmer configure the baud rate to match that of the Z80 Programmer.

![Remote Wireless Console - to Z80 Retro! Console Port](release/docs/Telnet_Cpu_Port_23.jpg "Remote Retro CPU Console")
