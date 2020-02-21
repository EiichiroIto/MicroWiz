Class {
	#name : #ESP8266BlockSpecs,
	#superclass : #MicroPythonBlockSpecs,
	#category : #'MicroWiz-MPython'
}

{ #category : #'block specs' }
ESP8266BlockSpecs >> controlBlocks [
	^ super controlBlocks , #(
		'control'
			-
			('wait %n millisecs'			-	waitMsecs: 1000)
			('wait %n microsecs'			-	waitUSecs: 1000)
		)
]

{ #category : #'block specs' }
ESP8266BlockSpecs >> displayBlocks [
	^ super displayBlocks , #(
		'display'
			('set neopixel pin %n num %n'		-		setNeoPixelPin:num:	0 1)
			('pin %n no %n r %n g %n b %n'
																	-		neoPixel:no:r:g:b: 0 0 255 255 255)
			('show neopixel pin %n'					-		neoPixelShow: 0)
	)
]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> gpioModeNames [
	^ #(IN OUT PULL_UP)
]

{ #category : #'block specs' }
ESP8266BlockSpecs >> ioBlocks [
	^ super ioBlocks , #(
		'io'
			('set digital pin %n for %P'		- 		setGpioPin:for: 0 'INPUT')
			('digital read pin %n'				r		readDigital: 0)
			('turn on pin %n'						- 		gpioOn: 0)
			('turn off pin %n'						- 		gpioOff: 0)
			('digital write pin %n to %n'	-		writeDigital:to: 0 0)
			-
			('set pwm pin %n freq %n duty %n'
																- 		setPwmPin:freq:duty: 0 1000 200)
			('analog write pin %n to %n'		- 		writeAnalog:to: 0 0)
			('deinit pwm pin %n'					- 		deinitPwm: 0)
			-
			('set adc pin %n'						-		setAdcPin: 0)
			('analog read pin %n'					r		readAnalog: 0)
			-
			('set spi sck %n mosi %n miso %n'
																-		setSpiSck:mosi:miso: 0 2 4)
			('set spi baudrate %n'				-		setSpiBaudrate: 200000)
			('spi read %n bytes into %L'		-		spiRead:into: 10 'list')
			('spi write %s'							-		spiWriteString: '12345')
			('spi write %L'							-		spiWriteList: 'list')
			('set hard spi baud %n'				-		setHardSpiBaud: 80000000)
			-
			('set i2c freq %n sda %n scl %n'
																-		i2cInitFreq:sda:scl: 100000 20 19)
			('i2c read %n bytes from %n into %L'
																-		i2cRead:from:into:		4 10 'list')
			('i2c write %n to %n'					-		i2cWriteData:to: 		100 10)
			('i2c write %s to %n'					-		i2cWrite:to: 				'[1,2,3]' 0)
			('i2c write %L to %n'					-		i2cWriteList:to:			'list' 10)
		)
"			('button %B is pressed'			b		buttonIsPressed:)
			('button %B was pressed'		b		buttonWasPressed:)
			('count of button %B pressed'		r		countOfButtonPressed:)
			-
			('analog set period pin %n to %n msec'	- setAnalogPeriod:msec: 0 500)
			('pin %n is touched'					b		pinIsTouched: 0)
			-
			('servo write pin %G to %n degrees'		-		writeServo:to: 0 180)
			('servo set pin %G %n msec %n to %n'	-		setServo:msec:min:max:	0	5	100	500)
			-
			('i2c read addr %n'					r	i2cRead:	0)
			('i2c write addr %n data %L'	-	i2cWrite:list:		0 'list')
		'neoPixel'
			('set %n to R %n G %n B %n of NeoPixel pin %P'		-		setNo:r:g:b:neoPixel: 0 255 255 255 '')
			('show NeoPixel of pin %P'								-		showNeoPixel:)
			('clear NeoPixel of pin %P'								-		clearNeoPixel:)
		)"
]

{ #category : #'block specs' }
ESP8266BlockSpecs >> miscBlocks [
	^ super miscBlocks , #(
		'misc'
			-
			('setup wifi %W'						-		setWifi: 'STA_IF')
			('wifi active %b'					-		wifiActive:)
			('wifi scan'							-		wifiScan)
			('wifi connect id %s pw %s'	-		wifiConnectId:pw:		'abc'	'def')
			('wifi disconnect'					-		wifiDisconnect)
			('wifi is connected'				b		wifiIsConnected)
			('wifi config of %w'				r		wifiGetConfig: 'mac')
			('set wifi config %w to %s'	r		wifiSetConfig: 'essid' to: 'ESP-AP')
			('wifi ifconfig to %L'			-		wifiIfconfigTo: 'list')
			('wifi status'							r 		wifiStatus)
	)
"
wlan = network.WLAN(network.STA_IF) # create station interface
wlan.active(True)       # activate the interface
wlan.scan()             # scan for access points
wlan.isconnected()      # check if the station is connected to an AP
wlan.connect('essid', 'password') # connect to an AP
wlan.config('mac')      # get the interface's MAC adddress
wlan.ifconfig()         # get the interface's IP/netmask/gw/DNS addresses

ap = network.WLAN(network.AP_IF) # create access-point interface
ap.active(True)         # activate the interface
ap.config(essid='ESP-AP') # set the ESSID of the access point
"

]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> uncoloredArgMorphFor: specString ifAbsent: aBlock [
	| code |
	code := specString at: 2.
	$P = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #gpioModeNames;
				getOptionsTarget: self;
				yourself ].
	$W = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #wifiConnectNames;
				getOptionsTarget: self;
				yourself ].
	$w = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #wifiConfigNames;
				getOptionsTarget: self;
				yourself ].
	^ super uncoloredArgMorphFor: specString ifAbsent: aBlock
]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> wifiConfigNames [
	^ #(mac)
]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> wifiConnectNames [
	^ #(STA_IF AP_IF)
]
