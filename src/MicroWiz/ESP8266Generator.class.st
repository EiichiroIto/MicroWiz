Class {
	#name : #ESP8266Generator,
	#superclass : #MicroPythonGenerator,
	#category : #'MicroWiz-MPython'
}

{ #category : #private }
ESP8266Generator >> adc: aNumber [
	| num |
	num := self valueOf: aNumber.
	^ '_adc' , num asString
]

{ #category : #'io ops' }
ESP8266Generator >> deinitPwm: pin [
	self
		appendWithNewline: (self pwm: pin) , '.' , (self nullaryFunction: 'deinit')
]

{ #category : #'io ops' }
ESP8266Generator >> gpioOff: pin [
	self
		appendWithNewline: (self pin: pin) , '.' , (self nullaryFunction: 'off')
]

{ #category : #'io ops' }
ESP8266Generator >> gpioOn: pin [
	self
		appendWithNewline: (self pin: pin) , '.' , (self nullaryFunction: 'on')
]

{ #category : #private }
ESP8266Generator >> i2c [
	self from: 'machine' import: 'I2C'.
	^ '_i2c'
]

{ #category : #'io ops' }
ESP8266Generator >> i2cInitFreq: freq sda: sda scl: scl [
	self from: 'machine' import: 'Pin'.
	self
		appendWithNewline:
			self i2c , '=I2C(scl=Pin(' , (self valueOf: scl) , '),sda=Pin('
				, (self valueOf: sda) , '),freq=' , (self valueOf: freq) , ')'
]

{ #category : #'io ops' }
ESP8266Generator >> i2cRead: bytes from: addr into: list [
	self
		appendWithNewline:
			(self getList: list) , '=' , self i2c , '.'
				, (self binaryFunction: 'readfrom' arg1: addr arg2: bytes)
]

{ #category : #'io ops' }
ESP8266Generator >> i2cWrite: str to: addr [
	self
		appendWithNewline:
			self i2c , '.writeto(' , (self valueOf: addr) , ',bytes('
				, (self unquoteString: (self valueOf: str)) , '))'
]

{ #category : #'io ops' }
ESP8266Generator >> i2cWriteData: data to: addr [
	self
		appendWithNewline:
			self i2c , '.'
				, (self binaryFunction: 'writeto' arg1: addr arg2: data)
]

{ #category : #'io ops' }
ESP8266Generator >> i2cWriteList: list to: addr [
	self
		appendWithNewline:
			self i2c , '.writeto(' , (self valueOf: addr) , ',bytes('
				, (self getList: list) , '))'
]

{ #category : #private }
ESP8266Generator >> machine [
	self import: 'machine'.
	^ 'machine.'
]

{ #category : #'display ops' }
ESP8266Generator >> neoPixelShow: pin [
	self
		appendWithNewline: (self neoPixel: pin) , '.' , (self nullaryFunction: 'write')
]

{ #category : #private }
ESP8266Generator >> pin: aNumber [
	| num |
	num := self valueOf: aNumber.
	^ '_pin' , num asString
]

{ #category : #private }
ESP8266Generator >> pwm: aNumber [
	| num |
	num := self valueOf: aNumber.
	^ '_pwm' , num asString
]

{ #category : #'io ops' }
ESP8266Generator >> readAnalog: pin [
	^ (self adc: pin) , '.' , (self nullaryFunction: 'read')
]

{ #category : #'io ops' }
ESP8266Generator >> readDigital: pin [
	^ (self pin: pin) , '.' , (self nullaryFunction: 'value')
]

{ #category : #'io ops' }
ESP8266Generator >> setAdcPin: pin [
	self from: 'machine' import: 'ADC'.
	self
		appendWithNewline: (self adc: pin) , '=' , (self unaryFunction: 'ADC' arg: pin)
]

{ #category : #'io ops' }
ESP8266Generator >> setGpioPin: pin for: mode [
	self from: 'machine' import: 'Pin'.
	self
		appendWithNewline:
			(self pin: pin) , '=' , 'Pin(' , (self valueOf: pin)
				, ',' , 'Pin.' , mode , ')'
]

{ #category : #'io ops' }
ESP8266Generator >> setHardSpiBaud: baud [
	self
		appendWithNewline:
			self spi , '=SPI(1,baudrate=' , (self valueOf: baud)
				, ',polarity=0,phase=0)'
]

{ #category : #'display ops' }
ESP8266Generator >> setNeoPixelPin: pin num: num [
	self setGpioPin: pin for: 'OUT'.
	self
		appendWithNewline:
			(self neoPixel: pin) , '='
				,
					(self
						binaryFunction: 'neopixel.NeoPixel'
						arg1: (self pin: pin)
						arg2: num)
]

{ #category : #'io ops' }
ESP8266Generator >> setPwmPin: pin freq: freq duty: duty [
	self from: 'machine' import: 'Pin'.
	self from: 'machine' import: 'PWM'.
	self
		appendWithNewline:
			(self pwm: pin) , '=' , 'PWM(Pin(' , (self valueOf: pin) , '),freq='
				, (self valueOf: freq) , ',duty=' , (self valueOf: duty) , ')'
]

{ #category : #'io ops' }
ESP8266Generator >> setSpiBaudrate: baud [
	self
		appendWithNewline: self spi , '.' , 'init(baudrate=' , (self valueOf: baud) , ')'
]

{ #category : #'io ops' }
ESP8266Generator >> setSpiSck: sck mosi: mosi miso: miso [
	self from: 'machine' import: 'Pin'.
	self
		appendWithNewline:
			self spi , '=SPI(-1,baudrate=100000,polarity=1,phase=0,sck=Pin('
				, (self valueOf: sck) , '),mosi=Pin(' , (self valueOf: mosi)
				, '),miso=Pin(' , (self valueOf: miso) , '))'
]

{ #category : #'misc ops' }
ESP8266Generator >> setWifi: mode [
	self
		appendWithNewline: self wifi , '=network.WLAN(network.' , mode , ')'
]

{ #category : #'misc ops' }
ESP8266Generator >> setupTcpSocket: num [
	self
		appendWithNewline:
			(self socket: num) , '=' , self socket
				,
					(self
						binaryFunction: 'socket'
						arg1: self socket , 'AF_INET'
						arg2: self socket , 'SOCK_STREAM')
]

{ #category : #'misc ops' }
ESP8266Generator >> setupUdpSocket: num [
	self
		appendWithNewline:
			(self socket: num) , '=' , self socket
				,
					(self
						binaryFunction: 'socket'
						arg1: self socket , 'AF_INET'
						arg2: self socket , 'SOCK_DGRAM')
]

{ #category : #private }
ESP8266Generator >> socket [
	self import: 'socket'.
	^ 'socket.'
]

{ #category : #private }
ESP8266Generator >> socket: aNumber [
	^ '_sock' , (self valueOf: aNumber)
]

{ #category : #'misc ops' }
ESP8266Generator >> socket: num bind: addr [
	self
		appendWithNewline:
			(self socket: num) , '.' , (self unaryFunction: 'bind' arg: addr)
]

{ #category : #'misc ops' }
ESP8266Generator >> socket: num connect: addr [
	self
		appendWithNewline:
			(self socket: num) , '.' , (self unaryFunction: 'connect' arg: addr)
]

{ #category : #'misc ops' }
ESP8266Generator >> socket: num listen: backlog [
	self
		appendWithNewline:
			(self socket: num) , '.' , (self unaryFunction: 'listen' arg: backlog)
]

{ #category : #'misc ops' }
ESP8266Generator >> socket: num receive: size [
	^ (self socket: num) , '.' , (self unaryFunction: 'recv' arg: size)
]

{ #category : #'misc ops' }
ESP8266Generator >> socket: num send: data [
	self
		appendWithNewline:
			(self socket: num) , '.' , (self unaryFunction: 'send' arg: data)
]

{ #category : #'misc ops' }
ESP8266Generator >> socketClose: num [
	self
		appendWithNewline: (self socket: num) , '.' , (self nullaryFunction: 'close')
]

{ #category : #'misc ops' }
ESP8266Generator >> socketGetAddr: str port: portno [
	^ self socket
		, (self binaryFunction: 'getaddrinfo' arg1: str arg2: portno)
		, '[0][-1]'
]

{ #category : #private }
ESP8266Generator >> spi [
	self from: 'machine' import: 'SPI'.
	^ '_spi'
]

{ #category : #'io ops' }
ESP8266Generator >> spiRead: num into: list [
	self
		appendWithNewline:
			(self getList: list) , '=' , self spi , '.'
				, (self unaryFunction: 'read' arg: num)
]

{ #category : #'io ops' }
ESP8266Generator >> spiWriteList: list [
	self
		appendWithNewline: self spi , '.' , 'write(bytes(' , (self getList: list) , '))'
]

{ #category : #'io ops' }
ESP8266Generator >> spiWriteString: aString [
	self
		appendWithNewline: self spi , '.' , 'write(b' , (self valueOf: aString) , ')'
]

{ #category : #private }
ESP8266Generator >> time [
	self import: 'time'.
	^ 'time.'
]

{ #category : #'control ops' }
ESP8266Generator >> waitMsecs: msec [
	self appendWithNewline: self time , (self unaryFunction: 'sleep_ms' arg: msec)
]

{ #category : #'control ops' }
ESP8266Generator >> waitUsecs: msec [
	self appendWithNewline: self time , (self unaryFunction: 'sleep_us' arg: msec)
]

{ #category : #private }
ESP8266Generator >> wifi [
	self import: 'network'.
	^ '_wlan'
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiActive: aBoolean [
	self
		appendWithNewline: self wifi , '.' , (self unaryFunction: 'active' arg: aBoolean)
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiConnectId: id pw: pw [
	self
		appendWithNewline: self wifi , '.' , (self binaryFunction: 'connect' arg1: id arg2: pw)
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiDisconnect [
	self
		appendWithNewline: self wifi , '.' , (self nullaryFunction: 'disconnect')
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiGetConfig: mode [
	^ self wifi , '.config(''' , mode , ''')'
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiIfconfigTo: list [
	self
		appendWithNewline:
			(self getList: list) , '=' , self wifi , '.'
				, (self nullaryFunction: 'ifconfig')
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiIsConnected [
	^ self wifi , '.' , (self nullaryFunction: 'isconnected')
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiScan [
	self
		appendWithNewline: self wifi , '.' , (self nullaryFunction: 'scan')
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiSetConfig: mode to: str [
	self
		appendWithNewline: self wifi , '.config(' , mode , '=' ,
		 (self valueOf: str) , ')'
]

{ #category : #'misc ops' }
ESP8266Generator >> wifiStatus [
	^ self wifi , '.' , (self nullaryFunction: 'status')
]

{ #category : #'io ops' }
ESP8266Generator >> writeAnalog: pin to: val [
	self
		appendWithNewline: (self pwm: pin) , '.' , (self unaryFunction: 'duty' arg: val)
]

{ #category : #'io ops' }
ESP8266Generator >> writeDigital: pin to: val [
	self
		appendWithNewline: (self pin: pin) , '.' , (self unaryFunction: 'value' arg: val)
]
