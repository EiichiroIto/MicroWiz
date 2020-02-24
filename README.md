# MicroWiz
Block-style programming environment for making MicroPython program, based on MIT Scratch.

MicroWiz is built on Pharo Smalltalk 8.0. Almost all Model and UI are rewritten using Spec2.

![Entire Screen1](https://raw.githubusercontent.com/EiichiroIto/MicroWiz/master/images/MicroWiz1.png)

[![Build Status](https://travis-ci.com/EiichiroIto/MicroWiz.svg?branch=master)](https://travis-ci.com/EiichiroIto/MicroWiz)

## Install repository on Pharo

```
Metacello new
    baseline: 'MicroWiz';
    repository: 'github://EiichiroIto/MicroWiz/src';
    load.
```

To start MicroWiz, select [Tools] - [MicroWiz].

## Prerequisites
You need to install MicroPython program on your device before using MicroWiz.

See,

* micro:bit [https://microbit-micropython.readthedocs.io/en/v1.0.1/]
* Maix Py [https://github.com/sipeed/MaixPy]
* other device [https://micropython.org/download]

## Usage
1. Select appropriate device from [Device] menu.
2. Plug serial cable into PC and device.
3. Select port on top right pane then click Connect button.
4. (make your program)
5. Double click the top block then the program runs after sending the device.

## License
MIT License

## Screenshot
![Maix Py](https://raw.githubusercontent.com/EiichiroIto/MicroWiz/master/images/MicroWiz2.png)

![ESP8266 with VL53L0X](https://raw.githubusercontent.com/EiichiroIto/MicroWiz/master/images/MicroWiz3.png)
