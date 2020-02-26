"
An ESP8266GeneratorTest is a test class for testing the behavior of ESP8266Generator
"
Class {
	#name : #ESP8266GeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ESP8266GeneratorTest >> newGenerator [
	^ ESP8266Generator new
]

{ #category : #test }
ESP8266GeneratorTest >> testAdc [
	| g |
	g := self newGenerator.
	self assert: (g adc: 2) equals: '_adc2'.
	self assert: (g adc: '3') equals: '_adc3'
]

{ #category : #test }
ESP8266GeneratorTest >> testDeinitPwm [
	| g |
	g := self newGenerator.
	g deinitPwm: 1.
	self assert: g code equals: '_pwm1.deinit()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testGpioOff [
	| g |
	g := self newGenerator.
	g gpioOff: 2.
	self assert: g code equals: '_pin2.off()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testGpioOn [
	| g |
	g := self newGenerator.
	g gpioOn: 1.
	self assert: g code equals: '_pin1.on()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testI2c [
	| g |
	g := self newGenerator.
	self assert: g i2c equals: '_i2c'.
	self assert: ((g modules at: 'machine') includes: 'I2C')
]

{ #category : #test }
ESP8266GeneratorTest >> testI2cInitFreqSdaScl [
	| g |
	g := self newGenerator.
	g i2cInitFreq: 100000 sda: 4 scl: 5.
	self
		assert: g code
		equals: '_i2c=I2C(scl=Pin(5),sda=Pin(4),freq=100000)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testI2cReadFromInto [
	| g |
	g := self newGenerator.
	g i2cRead: 4 from: 10 into: 'x'.
	self
		assert: g code
		equals: 'x=_i2c.readfrom(10,4)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testI2cWriteDataTo [
	| g |
	g := self newGenerator.
	g i2cWriteData: 10 to: 20.
	self
		assert: g code
		equals: '_i2c.writeto(20,10)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testI2cWriteListTo [
	| g |
	g := self newGenerator.
	g i2cWriteList: 'x' to: 20.
	self
		assert: g code
		equals: '_i2c.writeto(20,bytes(x))' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testI2cWriteTo [
	| g |
	g := self newGenerator.
	g i2cWrite: '1,2,3' to: 20.
	self
		assert: g code
		equals: '_i2c.writeto(20,bytes(1,2,3))' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testMachine [
	| g |
	g := self newGenerator.
	self assert: g machine equals: 'machine.'.
	self assert: (g imports includes: 'machine')
]

{ #category : #test }
ESP8266GeneratorTest >> testNeoPixelShow [
	| g |
	g := self newGenerator.
	g neoPixelShow: 3.
	self assert: g code equals: '_np3.write()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testPin [
	| g |
	g := self newGenerator.
	self assert: (g pin: 2) equals: '_pin2'.
	self assert: (g pin: '3') equals: '_pin3'
]

{ #category : #test }
ESP8266GeneratorTest >> testPwm [
	| g |
	g := self newGenerator.
	self assert: (g pwm: 2) equals: '_pwm2'.
	self assert: (g pwm: '3') equals: '_pwm3'
]

{ #category : #test }
ESP8266GeneratorTest >> testReadAnalog [
	| g |
	g := self newGenerator.
	self assert: (g readAnalog: 3) equals: '_adc3.read()'.
	self assert: (g readAnalog: [4]) equals: '_adc4.read()'
]

{ #category : #test }
ESP8266GeneratorTest >> testReadDigital [
	| g |
	g := self newGenerator.
	self assert: (g readDigital: 3) equals: '_pin3.value()'.
	self assert: (g readDigital: [4]) equals: '_pin4.value()'
]

{ #category : #test }
ESP8266GeneratorTest >> testSetAdcPin [
	| g |
	g := self newGenerator.
	g setAdcPin: 2.
	self
		assert: g code
		equals: '_adc2=ADC(2)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetGpioPinFor [
	| g |
	g := self newGenerator.
	g setGpioPin: 2 for: 'OUT'.
	self
		assert: g code
		equals: '_pin2=Pin(2,Pin.OUT)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetHardSpiBaud [
	| g |
	g := self newGenerator.
	g setHardSpiBaud: 80000000.
	self
		assert: g code
		equals: '_spi=SPI(1,baudrate=80000000,polarity=0,phase=0)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetNeoPixelPinNum [
	| g |
	g := self newGenerator.
	g setNeoPixelPin: 3 num: 4.
	self
		assert: g code
		equals:
			'_pin3=Pin(3,Pin.OUT)' , String lf , '_np3=neopixel.NeoPixel(_pin3,4)'
				, String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetPwmPinFreqDuty [
	| g |
	g := self newGenerator.
	g setPwmPin: 2 freq: 1000 duty: 200.
	self
		assert: g code
		equals: '_pwm2=PWM(Pin(2),freq=1000,duty=200)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetSpiBaudrate [
	| g |
	g := self newGenerator.
	g setSpiBaudrate: 200000.
	self
		assert: g code
		equals: '_spi.init(baudrate=200000)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetSpiSckMosiMiso [
	| g |
	g := self newGenerator.
	g setSpiSck: 0 mosi: 1 miso: 2.
	self
		assert: g code
		equals:
			'_spi=SPI(-1,baudrate=100000,polarity=1,phase=0,sck=Pin(0),mosi=Pin(1),miso=Pin(2))'
				, String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetWifi [
	| g |
	g := self newGenerator.
	g setWifi: 'STA_IF'.
	self
		assert: g code
		equals: '_wlan=network.WLAN(network.STA_IF)' , String lf.
	g := self newGenerator.
	g setWifi: 'AP_IF'.
	self
		assert: g code
		equals: '_wlan=network.WLAN(network.AP_IF)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetupTcpSocket [
	| g |
	g := self newGenerator.
	g setupTcpSocket: 1.
	self
		assert: g code
		equals: '_sock1=socket.socket(socket.AF_INET,socket.SOCK_STREAM)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSetupUdpSocket [
	| g |
	g := self newGenerator.
	g setupUdpSocket: 1.
	self
		assert: g code
		equals: '_sock1=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSocket [
	| g |
	g := self newGenerator.
	self assert: g socket equals: 'socket.'.
	self assert: (g imports includes: 'socket').
	self assert: (g socket: 1) equals: '_sock1'
]

{ #category : #test }
ESP8266GeneratorTest >> testSocketBind [
	| g |
	g := self newGenerator.
	g socket: 1 bind: 'abc'.
	self assert: g code equals: '_sock1.bind(abc)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSocketConnect [
	| g |
	g := self newGenerator.
	g socket: 1 connect: 'abc'.
	self assert: g code equals: '_sock1.connect(abc)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSocketGetAddrPort [
	| g |
	g := self newGenerator.
	self
		assert: (g socketGetAddr: 'abc' port: 80)
		equals: 'socket.getaddrinfo(abc,80)[0][-1]'
]

{ #category : #test }
ESP8266GeneratorTest >> testSocketListen [
	| g |
	g := self newGenerator.
	g socket: 1 listen: 2.
	self assert: g code equals: '_sock1.listen(2)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSocketReceive [
	| g |
	g := self newGenerator.
	self assert: (g socket: 1 receive: 5) equals: '_sock1.recv(5)'
]

{ #category : #test }
ESP8266GeneratorTest >> testSocketSend [
	| g |
	g := self newGenerator.
	g socket: 1 send: 'abc'.
	self assert: g code equals: '_sock1.send(abc)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSpi [
	| g |
	g := self newGenerator.
	self assert: g spi equals: '_spi'.
	self assert: ((g modules at: 'machine') includes: 'SPI')
]

{ #category : #test }
ESP8266GeneratorTest >> testSpiReadInto [
	| g |
	g := self newGenerator.
	g spiRead: 10 into: 'x'.
	self assert: g code equals: 'x=_spi.read(10)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSpiWriteList [
	| g |
	g := self newGenerator.
	g spiWriteList: 'x'.
	self assert: g code equals: '_spi.write(bytes(x))' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testSpiWriteString [
	| g |
	g := self newGenerator.
	g spiWriteString: '"abc"'.
	self assert: g code equals: '_spi.write(b"abc")' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testTime [
	| g |
	g := self newGenerator.
	self assert: g time equals: 'time.'.
	self assert: (g imports includes: 'time')
]

{ #category : #test }
ESP8266GeneratorTest >> testWaitMsecs [
	| g |
	g := self newGenerator.
	g waitMsecs: 100.
	self assert: g code equals: 'time.sleep_ms(100)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWaitUsecs [
	| g |
	g := self newGenerator.
	g waitUsecs: 100.
	self assert: g code equals: 'time.sleep_us(100)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifi [
	| g |
	g := self newGenerator.
	self assert: g wifi equals: '_wlan'.
	self assert: (g imports includes: 'network')
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiActive [
	| g |
	g := self newGenerator.
	g wifiActive: [g getTrue].
	self
		assert: g code
		equals: '_wlan.active(True)' , String lf.
	g := self newGenerator.
	g wifiActive: [g getFalse].
	self
		assert: g code
		equals: '_wlan.active(False)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiConnectIdPw [
	| g |
	g := self newGenerator.
	g wifiConnectId: '''essid''' pw: '''password'''.
	self
		assert: g code
		equals: '_wlan.connect(''essid'',''password'')' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiDisconnect [
	| g |
	g := self newGenerator.
	g wifiDisconnect.
	self assert: g code equals: '_wlan.disconnect()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiGetConfig [
	| g |
	g := self newGenerator.
	self assert: (g wifiGetConfig: 'mac') equals: '_wlan.config(''mac'')'
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiIfconfigTo [
	| g |
	g := self newGenerator.
	g wifiIfconfigTo: 'x'.
	self assert: g code equals: 'x=_wlan.ifconfig()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiIsConnected [
	| g |
	g := self newGenerator.
	self
		assert: g wifiIsConnected
		equals: '_wlan.isconnected()'
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiScan [
	| g |
	g := self newGenerator.
	g wifiScan.
	self
		assert: g code
		equals: '_wlan.scan()' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiSetConfigTo [
	| g |
	g := self newGenerator.
	g wifiSetConfig: 'essid' to: '''ESP-AP'''.
	self assert: g code equals: '_wlan.config(essid=''ESP-AP'')' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWifiStatus [
	| g |
	g := self newGenerator.
	self
		assert: g wifiStatus
		equals: '_wlan.status()'
]

{ #category : #test }
ESP8266GeneratorTest >> testWriteAnalogTo [
	| g |
	g := self newGenerator.
	g writeAnalog: 3 to: 1.
	self assert: g code equals: '_pwm3.duty(1)' , String lf.
	g := self newGenerator.
	g writeAnalog: [4] to: 0.
	self assert: g code equals: '_pwm4.duty(0)' , String lf
]

{ #category : #test }
ESP8266GeneratorTest >> testWriteDigitalTo [
	| g |
	g := self newGenerator.
	g writeDigital: 3 to: 1.
	self assert: g code equals: '_pin3.value(1)' , String lf.
	g := self newGenerator.
	g writeDigital: [4] to: 0.
	self assert: g code equals: '_pin4.value(0)' , String lf
]
