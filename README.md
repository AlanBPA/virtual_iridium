# What is this project?

This is a Iridium Modem (9602/9603) emulator to make it possible to test your own software again a "Virtual" Iridium device and it connection.

This application is written in Python language uses pyserial to implement a serial communications interface. The emulator matches the behavior of the Iridium 9602 modem which is available from NAL Research and Rock7Mobile (as Rockblock). The emulator will respond to at commands to write data, execute short-burst data (SBD) sessions, and most of the other functions supported by the 9602 serial interface.

# What's the use?

If you want to develop an application on a PC or an embedded device it will to talk to an Iridium modem, you can use this for initial prototyping and testing. This can potentially save quite some cost on Iridium service charges. Also you can already create an application without already buying the real Iridium Modem (9602/9603) hardware.

# How do I get this software?

In your Unix shell of choice:
```
 $ git clone https://github.com/AlanBPA/virtual_iridium
```


# How to use it with an external device

In the terminal:
```
 $ cd /path/to/virtual_iridium/python
 $ python Iridium9602.py -d /dev/ttyUSB0 -u youraccount@gmail.com -p your_password -i imap.gmail.com -o smtp.gmail.com -r your_iridium_test_account@gmail.com -m EMAIL
```

The specified serial device, in the example above: ttyUSB0 , should connect to the external device that you are developing your Iridium communications app on. 

# How to use it with virtual serial ports in socat

Installing socat:
```
$ sudo apt-get install socat
```

Once socat is installed, open a terminal (terminal_0) and run the following:
```
$ socat -d -d pty,raw,echo=0 pty,raw,echo=0
```
This will create two connected virtual serial ports:
```
date hour socat[5463] N PTY is /dev/pts/2
date hour socat[5463] N PTY is /dev/pts/3
date hour socat[5463] N starting data transfer loop with FDs [5,5] and [7,7]
```
In this example we have the virtual serial ports /dev/pts/2 and /dev/pts/3. We will give one of the ports to the emulator to send and receive serial data in a new terminal (terminal_1):
```
$ cd /path/to/virtual_iridium/python                                                                                                      
$ python Iridium9602.py -d /dev/pts/2 -u youraccount@gmail.com -p your_password -i imap.gmail.com -o smtp.gmail.com -r your_iri    dium_test_account@gmail.com -m EMAIL
```

To receive serial data through the other virtual serial port, open a new terminal (terminal_2):
```
$ cat < /dev/pts/3
```

And to send serial data through the other port we can use:
```
$ echo -en "message123" > /dev/pts/3
```
The -en option is to recognize \ as an escape character and to omit sending a newline character at the end. Because you need to write that same line for every message sent through the port, there is a little script to simplify the process:
```
$ cd /path/to/virtual_iridium/python
$ ./send_at.sh
```
This script will show something like this:
```
Introduce Virtual Serial Port to send data:
/dev/pts/3

Using port /dev/pts/3, to change port write -c name_of_port

Send message or write -x to exit
test_message1

Sent: <test_message1> to port /dev/pts/3

Send message or write -x to exit
...
```
It will first ask for the name of the port to send the serial data through, once the port is provided, we can send a message by writing it and then pressing Enter. We can also change the name of the port used by writing "-c new_port" and exit the script with "-x":
```
Send message or write -x to exit
-c /dev/pts/4

Port changed to /dev/pts/4

Send message or write -x to exit
-x
Exiting...
```

