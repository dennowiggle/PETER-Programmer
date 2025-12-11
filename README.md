# PETER-Programmer
PETER-Programmer is a WiFi interface for the [Retro-PETER](https://github.com/dennowiggle/Retro-PETER/blob/main/Hardware/) CPU and it can program CPU boot code and FPGA images to FPGA Flash, as well as program and debug an eZ80F91 over ZDI. It's also rather useful at providing a CPU reset or a system reset remotely.

## Information:
Refer to the [schematic](https://github.com/dennowiggle/Retro-PETER/blob/main/Hardware/PETER/output/PETER_V0.0_BW.pdf) for connections.

## WiFi Setup
* On first boot the module enters WiFi host AP mode. The purpose of this mode is to join the board WiFi to the local router WiFi.
  - Connect the local computer to the board WiFi network SSID `PETER-programmer` with password `Z80-Nouveau!`
  - If the local computer is set for DHCP it should be assigned an address on the PETER-Programmer network with an IP address of 192.168.4.x. If not, manually configure the local computer IP address to 192.168.4.2
  - PETER-Programmer WiFi setup IP address is 192.168.4.1
  - Open a browser at address http://192.168.4.1 to set the WiFi parameters for WiFi client mode in the local router network environment. 
  - NOTE: Join the board to a 2.4GHz network.
  - NOTE: Often a browser may change to https:// and in that case it needs to be changed back to http://

* Power cycle the board after setting the router network SSID you want to use.

<p align="center">
	<img src=release/docs/WiFi_Setup.jpg width=50% alt="[Peter-Programmer WiFi Setup">
</p>

* If having problems setting up WiFi the PETER-Programmer boot-up log can be seen by connecting a physical TTL level serial cable at 115200 baud to the board as [described below](#physical-serial-connection-to-peter-programmer-console). Once you see the menu:
  - W shows WiFi address.
  - C clears WiFi settings to start the sequence again.

## Web Page Use
* On the local WiFi router find the new IP address that the DHCP server assigned to the board.
* Alternatively connect a serial cable to PETER Programmer as [described below](#physical-serial-connection-to-peter-programmer-console) and type W to see the WiFi address assigned.
* Configure the local computer back to use the local router network. The PETER-Programmer should be on the same network now.
* Open a browser and enter the IP address assigned by DHCP server to the PETER-Programmer! Use http:// and NOT https://

<p align="center">
	<img src=release/docs/PETER-Programmer_WebPage.jpg width=50% alt="Peter-Programmer Web Page Use">
</p>

## Remote Wireless Console to PETER-Programmer!
* There is Telnet console access to PETER-Programmer at the same board IP address on port 2323.

<p align="center">
	<img src=release/docs/Telnet_ProgrammerConsole_Port_2323.jpg width=75% alt="Remote PETER-Programmer Wireless Console">
</p>

## Remote Wireless Console to CPU Console Port
* There is Telnet console access to the CPU at the same board IP address on port 23.
* The ESP32 needs to be connected to the CPU or FPGA as described below.
* The PETER-Programmer console can set the ESP32 baud rate to match the CPU/FPGA baud rate.

<p align="center">
	<img src=release/docs/Telnet_Cpu_Port_23.jpg width=75% alt="Remote CPU Wireless Console">
</p>

## Flashing an ESP32 binary on PETER-Programmer
* To program the ESP32 on the PETER board use a USB cable to connect the computer to the board USB-C connector at JTAG port J1202.

* Using the [Web](https://dennowiggle.github.io/PETER-Programmer/)
  - Select the image version.
  - Install firmware.
  - Upon completion select `logs and console` and then click on reset to reset the board.
  - Requires Microsoft Edge or Google Chrome/Chromium.
  - After a power cycle there is a need to [setup WiFi again](#WiFi-Setup) on the board as NVRAM will be erased.
  - Remember http:// and NOT https:// (browsers change to second without warning if no connect).

* Using Windows
  - Run the flash.bat script that is in the `release/firmware/` image directory.
  - e.g. `flash.bat COM3 115200`

* Using Linux/Python
  - Install the programmer `pip install esptool`.
  - Run the flash.sh script that is in the `release/firmware/` image directory.
  - e.g. `sh flash.sh /dev/ttyACM0 115200`
  - Power cycle the board (JTAG reset not the same in Linux as Windows).

## Physical Serial Connection to PETER-Programmer Console
* Connect a TTL level serial cable to
  - J1105.11 RX (ESP32 Tx)
  - J1105.12 TX (ESP32 Rx)
  - J1105.13 GND

## Connecting FPGA UART's to WiFi
* UART1 Console
  - Connect Jumper J1004 pin 2 to 4, and pin 1 to 3.
* UART2 NHACP
  - Connect Jumper J1001 pin 2 to 4, and pin 1 to 3.

## Connecting FPGA UART's to USB
* UART1
  - Connect Jumper J1004 pin 4 to 6, and pin 3 to 5.
  - Connect USB-C cable to J1002
* UART2
  - Connect Jumper J1001 pin 4 to 6, and pin 3 to 5.
  - Connect USB-C cable to J1005

## Alternate : Connecting up Retro CPU console signals (UART1)
* To use USB serial interface for UART1 console.
  - Connect CPU UART1 Tx to J1004.6
  - Connect CPU UART1 Rx to J1004.5
  - Connect USB-C cable to J1002
* To use WiFi interface for UART1 console.
  - Connect CPU UART1 Tx to J1004.2
  - Connect CPU UART1 Rx to J1004.1

## Alternate : Connecting up Retro CPU NHACP signals (UART2)
* To use USB serial interface for UART2 NHACP.
  - Connect CPU UART2 Tx to J1001.6
  - Connect CPU UART2 Rx to J1001.5
  - Connect USB-C cable to J1005
* To use WiFi interface for UART2 NHACP.
  - Connect CPU UART2 Tx to J1001.2
  - Connect CPU UART2 Rx to J1001.1

