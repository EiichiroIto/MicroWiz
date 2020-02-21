Class {
	#name : #MicrobitGenerator,
	#superclass : #MicroPythonGenerator,
	#instVars : [
		'servos'
	],
	#classVars : [
		'LedDict',
		'SensorDict'
	],
	#category : #'MicroWiz-Microbit'
}

{ #category : #'class initialization' }
MicrobitGenerator class >> initialize [
	"self initialize".
	LedDict := Dictionary new.
	SensorDict := Dictionary new.
	self setupLed: LedDict.
	self setupSensor: SensorDict
]

{ #category : #accessing }
MicrobitGenerator class >> sensorCodeAt: aSymbol [
	^ SensorDict at: aSymbol
]

{ #category : #private }
MicrobitGenerator class >> setupLed: aDictionary [
	aDictionary at: #heart put: 'HEART'.
	aDictionary at: #heartSmall put: 'HEART_SMALL'.
	aDictionary at: #happy put: 'HAPPY'.
	aDictionary at: #smile put: 'SMILE'.
	aDictionary at: #sad put: 'SAD'.
	aDictionary at: #confused put: 'CONFUSED'.
	aDictionary at: #angry put: 'ANGRY'.
	aDictionary at: #asleep put: 'ASLEEP'.
	aDictionary at: #surprised put: 'SURPRISED'.
	aDictionary at: #silly put: 'SILLY'.
	aDictionary at: #fabulous put: 'FABULOUS'.
	aDictionary at: #meh put: 'MEH'.
	aDictionary at: #yes put: 'YES'.
	aDictionary at: #no put: 'NO'.
	aDictionary at: #clock12 put: 'CLOCK12'.
	aDictionary at: #clock11 put: 'CLOCK11'.
	aDictionary at: #clock10 put: 'CLOCK10'.
	aDictionary at: #clock9 put: 'CLOCK9'.
	aDictionary at: #clock8 put: 'CLOCK8'.
	aDictionary at: #clock7 put: 'CLOCK7'.
	aDictionary at: #clock6 put: 'CLOCK6'.
	aDictionary at: #clock5 put: 'CLOCK5'.
	aDictionary at: #clock4 put: 'CLOCK4'.
	aDictionary at: #clock3 put: 'CLOCK3'.
	aDictionary at: #clock2 put: 'CLOCK2'.
	aDictionary at: #clock1 put: 'CLOCK1'.
	aDictionary at: #arrowN put: 'ARROW_N'.
	aDictionary at: #arrowNE put: 'ARROW_NE'.
	aDictionary at: #arrowE put: 'ARROW_E'.
	aDictionary at: #arrowSE put: 'ARROW_SE'.
	aDictionary at: #arrowS put: 'ARROW_S'.
	aDictionary at: #arrowSW put: 'ARROW_SW'.
	aDictionary at: #arrowW put: 'ARROW_W'.
	aDictionary at: #arrowNW put: 'ARROW_NW'.
	aDictionary at: #triangle put: 'TRIANGLE'.
	aDictionary at: #triangleLeft put: 'TRIANGLE_LEFT'.
	aDictionary at: #chessboard put: 'CHESSBOARD'.
	aDictionary at: #diamond put: 'DIAMOND'.
	aDictionary at: #diamondSmall put: 'DIAMOND_SMALL'.
	aDictionary at: #square put: 'SQUARE'.
	aDictionary at: #squareSmall put: 'SQUARE_SMALL'.
	aDictionary at: #rabbit put: 'RABBIT'.
	aDictionary at: #cow put: 'COW'.
	aDictionary at: #musicCrotchet put: 'MUSIC_CROTCHET'.
	aDictionary at: #musicQuaver put: 'MUSIC_QUAVER'.
	aDictionary at: #musicQuavers put: 'MUSIC_QUAVERS'.
	aDictionary at: #pitchfork put: 'PITCHFORK'.
	aDictionary at: #xmas put: 'XMAS'.
	aDictionary at: #pacman put: 'PACMAN'.
	aDictionary at: #target put: 'TARGET'.
	aDictionary at: #tshirt put: 'TSHIRT'.
	aDictionary at: #rollerskate put: 'ROLLERSKATE'.
	aDictionary at: #duck put: 'DUCK'.
	aDictionary at: #house put: 'HOUSE'.
	aDictionary at: #tortoise put: 'TORTOISE'.
	aDictionary at: #butterfly put: 'BUTTERFLY'.
	aDictionary at: #stickfigure put: 'STICKFIGURE'.
	aDictionary at: #ghost put: 'GHOST'.
	aDictionary at: #sword put: 'SWORD'.
	aDictionary at: #giraffe put: 'GIRAFFE'.
	aDictionary at: #skull put: 'SKULL'.
	aDictionary at: #umbrella put: 'UMBRELLA'.
	aDictionary at: #snake put: 'SNAKE'
]

{ #category : #private }
MicrobitGenerator class >> setupSensor: aDictionary [
	aDictionary
		at: #accelX put: 'accelerometer.get_x()';
		at: #accelY put: 'accelerometer.get_y()';
		at: #accelZ put: 'accelerometer.get_z()';
		at: #compassX put: 'compass.get_x()';
		at: #compassY put: 'compass.get_y()';
		at: #compassZ put: 'compass.get_z()'
]

{ #category : #accessing }
MicrobitGenerator class >> showSymbolAt: aSymbol [
	^ LedDict at: aSymbol
]

{ #category : #private }
MicrobitGenerator >> addServo: num [
	servos add: (self valueOf: num) asNumberNoError
]

{ #category : #'display ops' }
MicrobitGenerator >> arrowImageAt: num [
	^ self image , 'ALL_ARROWS[' , (self valueOf: num) , ']'
]

{ #category : #'display ops' }
MicrobitGenerator >> arrowImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #private }
MicrobitGenerator >> button: aString [
	self from: 'microbit' import: 'button_' , aString.
	^ self microbit , 'button_' , aString , '.'
]

{ #category : #'io ops' }
MicrobitGenerator >> buttonIsPressed: button [
	^ (self button: button) , (self nullaryFunction: 'is_pressed')
]

{ #category : #'io ops' }
MicrobitGenerator >> buttonWasPressed: button [
	^ (self button: button) , (self nullaryFunction: 'was_pressed')
]

{ #category : #'misc ops' }
MicrobitGenerator >> calibrateCompass [
	self
		appendWithNewline: self microbit , (self nullaryFunction: 'compass.calibrate')
]

{ #category : #'display ops' }
MicrobitGenerator >> characterImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #'misc ops' }
MicrobitGenerator >> clear: anObject [
	self
		appendWithNewline: (self valueOf: anObject) , '.' , (self nullaryFunction: 'clear')
]

{ #category : #'misc ops' }
MicrobitGenerator >> clearCalibration [
	self
		appendWithNewline: self microbit , (self nullaryFunction: 'compass.clear_calibration')
]

{ #category : #'display ops' }
MicrobitGenerator >> clearPixels [
	self
		appendWithNewline: self display , (self nullaryFunction: 'clear')
]

{ #category : #'display ops' }
MicrobitGenerator >> clockImageAt: num [
	^ self image , 'ALL_CLOCKS[' , (self valueOf: num) , ']'
]

{ #category : #'display ops' }
MicrobitGenerator >> clockImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #'comm ops' }
MicrobitGenerator >> configRadioGroup: num [
	self appendWithNewline: self radio , 'config(group=' , (self valueOf: num) , ')'
]

{ #category : #'misc ops' }
MicrobitGenerator >> copyOf: anObject [
	^ (self valueOf: anObject) , '.' ,  (self nullaryFunction: 'copy')
]

{ #category : #'misc ops' }
MicrobitGenerator >> countOf: anObject [
	^ (self valueOf: anObject) , '.' , (self nullaryFunction: 'count')
]

{ #category : #'io ops' }
MicrobitGenerator >> countOfButtonPressed: button [
	^ (self button: button) , (self nullaryFunction: 'get_presses')
]

{ #category : #'display ops' }
MicrobitGenerator >> cropX: x y: y w: w h: h of: img [
	^ (self valueOf: img) , '.crop(' , (self valueOf: x) , ','
		, (self valueOf: y) , ',' , (self valueOf: w) , ','
		, (self valueOf: h) , ')'
]

{ #category : #'sensing ops' }
MicrobitGenerator >> currentGesture [
	^ self microbit
		, (self nullaryFunction: 'accelerometer.current_gesture')
]

{ #category : #private }
MicrobitGenerator >> delServo: num [
	servos remove: (self valueOf: num) asNumberNoError ifAbsent: [  ]
]

{ #category : #private }
MicrobitGenerator >> display [
	self from: 'microbit' import: 'display'.
	^ 'display.'
]

{ #category : #'sensing ops' }
MicrobitGenerator >> fieldStrength [
	^ self microbit
		, (self nullaryFunction: 'compass.get_field_strength')
]

{ #category : #'display ops' }
MicrobitGenerator >> fill: img with: val [
	self
		appendWithNewline: (self valueOf: img) , '.fill(' , (self valueOf: val) , ')'
]

{ #category : #'sensing ops' }
MicrobitGenerator >> gestures [
	^ ''' ''.join(' , self microbit
		, (self nullaryFunction: 'accelerometer.get_gestures') , ')'
]

{ #category : #'misc ops' }
MicrobitGenerator >> getTempo [
	^ self music , (self nullaryFunction: 'get_tempo')
]

{ #category : #'sensing ops' }
MicrobitGenerator >> headingCompass [
	^ self microbit , (self nullaryFunction: 'compass.heading')
]

{ #category : #private }
MicrobitGenerator >> i2c [
	self addInit: #i2c.
	self from: 'microbit' import: 'i2c'.
	^ '_i2c.'
]

{ #category : #'io ops' }
MicrobitGenerator >> i2cInit [
	self
		appendWithNewline: self i2c , (self nullaryFunction: 'init').
	self delInit: #i2c
]

{ #category : #'io ops' }
MicrobitGenerator >> i2cInitFreq: freq sda: sda scl: scl [
	self
		appendWithNewline:
			self i2c , 'init(freq=' , (self valueOf: freq) , ',sda='
				, (self pin: sda) , ',scl=' , (self pin: scl) , ')'.
	self delInit: #i2c
]

{ #category : #'io ops' }
MicrobitGenerator >> i2cRead: bytes from: addr into: list [
	self
		appendWithNewline:
			(self getList: list) , '=' , self i2c
				, (self binaryFunction: 'read' arg1: addr arg2: bytes)
]

{ #category : #'io ops' }
MicrobitGenerator >> i2cWrite: str to: addr [
	self
		appendWithNewline:
			self i2c , 'write(' , (self valueOf: addr) , ',bytes('
				, (self unquoteString: (self valueOf: str)) , '))'
]

{ #category : #'io ops' }
MicrobitGenerator >> i2cWriteList: list to: addr [
	self
		appendWithNewline:
			self i2c , 'write(' , (self valueOf: addr) , ',bytes('
				, (self getList: list) , '))'
]

{ #category : #private }
MicrobitGenerator >> image [
	self from: 'microbit' import: 'Image'.
	^ 'Image.'
]

{ #category : #'display ops' }
MicrobitGenerator >> imageOf: arg [
	self image.
	^ self unaryFunction: 'Image' arg: arg
]

{ #category : #'display ops' }
MicrobitGenerator >> imageWidth: width height: height [ 
	self image.
	^ self binaryFunction: 'Image' arg1: width arg2: height
]

{ #category : #initialization }
MicrobitGenerator >> initialize [
	super initialize.
	servos := Set new
]

{ #category : #'display ops' }
MicrobitGenerator >> invertedImageOf: arg [
	^ (self valueOf: arg) , '.' , (self nullaryFunction: 'invert')
]

{ #category : #'sensing ops' }
MicrobitGenerator >> isCalibrated [
	^ self microbit , (self nullaryFunction: 'compass.is_calibrated')
]

{ #category : #'sensing ops' }
MicrobitGenerator >> isGesture: aSymbol [
	^ self microbit
		, (self unaryFunction: 'accelerometer.is_gesture' arg: aSymbol)
]

{ #category : #'display ops' }
MicrobitGenerator >> isLedOn [
	^ self display , (self nullaryFunction: 'is_on')
]

{ #category : #'display ops' }
MicrobitGenerator >> ledOff [
	self appendWithNewline: self display , (self nullaryFunction: 'off')
]

{ #category : #'display ops' }
MicrobitGenerator >> ledOn [
	self appendWithNewline: self display , (self nullaryFunction: 'on')
]

{ #category : #private }
MicrobitGenerator >> microbit [
	self import: 'microbit'.
	^ 'microbit.'
]

{ #category : #private }
MicrobitGenerator >> music [
	self import: 'music'.
	^ 'music.'
]

{ #category : #'io ops' }
MicrobitGenerator >> neoPixelClear: pin [
	self
		appendWithNewline: (self neoPixel: pin) , '.' , (self nullaryFunction: 'clear')
]

{ #category : #'io ops' }
MicrobitGenerator >> neoPixelShow: pin [
	self
		appendWithNewline: (self neoPixel: pin) , '.' , (self nullaryFunction: 'show')
]

{ #category : #'control ops' }
MicrobitGenerator >> panic: arg [
	self appendWithNewline: self microbit , (self unaryFunction: 'panic' arg: arg)
]

{ #category : #private }
MicrobitGenerator >> pin: anInteger [
	^ self microbit, 'pin', (self valueOf: anInteger)
]

{ #category : #'io ops' }
MicrobitGenerator >> pinIsTouched: pin [
	^ (self pin: pin) , '.' , (self nullaryFunction: 'is_touched')
]

{ #category : #'display ops' }
MicrobitGenerator >> pixelAtX: x y: y [
	^ self display , (self binaryFunction: 'get_pixel' arg1: x arg2: y)
]

{ #category : #'display ops' }
MicrobitGenerator >> pixelAtX: x y: y of: img [
	^ (self valueOf: img) , '.'
		, (self binaryFunction: 'get_pixel' arg1: x arg2: y)
]

{ #category : #'display ops' }
MicrobitGenerator >> pixelAtX: x y: y of: img put: num [
	self
		appendWithNewline:
			(self valueOf: img) , '.'
				,
					(self
						ternaryFunction: 'set_pixel'
						arg1: x
						arg2: y
						arg3: num)
]

{ #category : #'display ops' }
MicrobitGenerator >> pixelAtX: x y: y put: num [
	self
		appendWithNewline:
			self display
				,
					(self
						ternaryFunction: 'set_pixel'
						arg1: x
						arg2: y
						arg3: num)
]

{ #category : #'misc ops' }
MicrobitGenerator >> playMusic: aString [
	self
		appendWithNewline:
			self music , 'play(' , (self valueOf: aString)
				, '.split(''.''))'
]

{ #category : #'misc ops' }
MicrobitGenerator >> playMusic: aString loop: isLoop wait: isWait [
	self
		appendWithNewline:
			self music , 'play(' , (self valueOf: aString)
				, '.split(''.'')'
				,
					(isLoop
						ifTrue: [ ',loop=True' ]
						ifFalse: [ '' ])
				,
					(isWait
						ifTrue: [ ',wait=True' ]
						ifFalse: [ '' ]) , ')'
]

{ #category : #'misc ops' }
MicrobitGenerator >> playPitch: pitch msec: msec [
	self
		appendWithNewline:
			self music , 'pitch(' , (self valueOf: pitch) , ',duration='
				, (self valueOf: msec) , ')'
]

{ #category : #private }
MicrobitGenerator >> radio [
	self import: 'radio'.
	^ 'radio.'
]

{ #category : #'comm ops' }
MicrobitGenerator >> radioOff [
	self appendWithNewline: self radio , (self nullaryFunction: 'off')
]

{ #category : #'comm ops' }
MicrobitGenerator >> radioOn [
	self appendWithNewline: self radio , (self nullaryFunction: 'on')
]

{ #category : #'io ops' }
MicrobitGenerator >> readAnalog: pin [
	^ (self pin: pin) , '.' , (self nullaryFunction: 'read_analog')
]

{ #category : #'io ops' }
MicrobitGenerator >> readDigital: pin [
	^ (self pin: pin) , '.' , (self nullaryFunction: 'read_digital')
]

{ #category : #'comm ops' }
MicrobitGenerator >> receiveRadio [
	^ self radio , (self nullaryFunction: 'receive')
]

{ #category : #'misc ops' }
MicrobitGenerator >> resetMusic [
	self appendWithNewline: self music , (self nullaryFunction: 'reset')
]

{ #category : #'comm ops' }
MicrobitGenerator >> resetRadio [
	self appendWithNewline: self radio , (self nullaryFunction: 'reset')
]

{ #category : #'sensing ops' }
MicrobitGenerator >> runningTime [
	^ self microbit , (self nullaryFunction: 'running_time')
]

{ #category : #'display ops' }
MicrobitGenerator >> scroll: arg [
	self scroll: arg wait: false
]

{ #category : #'display ops' }
MicrobitGenerator >> scroll: aString wait: aBoolean [
	self
		appendWithNewline:
			self display , 'scroll(str(' , (self valueOf: aString) , ')'
				,
					(aBoolean
						ifTrue: [ '' ]
						ifFalse: [ ',wait=False' ]) , ')'
]

{ #category : #'display ops' }
MicrobitGenerator >> scrollAndWait: arg [
	self scroll: arg wait: true
]

{ #category : #'comm ops' }
MicrobitGenerator >> sendRadio: arg [
	self
		appendWithNewline: self radio , (self unaryFunction: 'send' arg: arg)
]

{ #category : #'sensing ops' }
MicrobitGenerator >> sensorValueOf: aSymbol [
	^ self microbit , (self class sensorCodeAt: aSymbol)
]

{ #category : #private }
MicrobitGenerator >> servos [
	^ servos
]

{ #category : #'io ops' }
MicrobitGenerator >> setAnalogPeriod: pin msec: val [
	self
		appendWithNewline:
			(self pin: pin) , '.'
				, (self unaryFunction: 'set_analog_period_microseconds' arg: val)
]

{ #category : #'io ops' }
MicrobitGenerator >> setNeoPixelPin: pin num: num [
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
MicrobitGenerator >> setServo: pin msec: msec min: min max: max [
	| p |
	p := self valueOf: pin.
	self
		appendWithNewline: (self pin: pin) , '.' , (self unaryFunction: 'set_analog_period' arg: msec).
	self
		appendWithNewline:
			'(_smin' , p , ',_smax' , p , ')=(' , (self valueOf: min) , ','
				, (self valueOf: max) , ')'.
	self delServo: p
]

{ #category : #'misc ops' }
MicrobitGenerator >> setTempoBpm: bpm [
	self setTempoBpm: bpm ticks: nil
]

{ #category : #'misc ops' }
MicrobitGenerator >> setTempoBpm: bpm ticks: ticks [
	self
		appendWithNewline:
			self music , 'set_tempo('
				, (bpm ifNotNil: [ 'bpm=' , (self valueOf: bpm) ] ifNil: [ '' ])
				, (ticks ifNotNil: [ 'ticks=' , (self valueOf: ticks) ] ifNil: [ '' ])
				, ')'
]

{ #category : #'misc ops' }
MicrobitGenerator >> setTempoTicks: ticks [
	self setTempoBpm: nil ticks: ticks
]

{ #category : #'display ops' }
MicrobitGenerator >> shapeImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #'display ops' }
MicrobitGenerator >> show: aString [
	self
		appendWithNewline: self display , (self unaryFunction: 'show' arg: aString)
]

{ #category : #'misc ops' }
MicrobitGenerator >> stopMusic [
	self appendWithNewline: self music , (self nullaryFunction: 'stop')
]

{ #category : #'display ops' }
MicrobitGenerator >> symbolImageOf: aSymbol [
	^ self image , (self class showSymbolAt: aSymbol)
]

{ #category : #'sensing ops' }
MicrobitGenerator >> temperature [
	^ self microbit , (self nullaryFunction: 'temperature')
]

{ #category : #private }
MicrobitGenerator >> utime [
	self import: 'utime'.
	^ 'utime.'
]

{ #category : #'control ops' }
MicrobitGenerator >> waitMsecs: msec [
	self appendWithNewline: self utime , (self unaryFunction: 'sleep_ms' arg: msec)
]

{ #category : #'sensing ops' }
MicrobitGenerator >> wasGesture: aSymbol [
	^ self microbit
		, (self unaryFunction: 'accelerometer.was_gesture' arg: aSymbol)
]

{ #category : #'io ops' }
MicrobitGenerator >> writeAnalog: pin to: val [
	self
		appendWithNewline: (self pin: pin) , '.' , (self unaryFunction: 'write_analog' arg: val)
]

{ #category : #'io ops' }
MicrobitGenerator >> writeDigital: pin to: val [
	self
		appendWithNewline: (self pin: pin) , '.' , (self unaryFunction: 'write_digital' arg: val)
]

{ #category : #'io ops' }
MicrobitGenerator >> writeServo: pin to: num [
	| p |
	p := self valueOf: pin.
	self addServo: p.
	self
		appendWithNewline:
			(self pin: pin) , '.write_analog((' , (self valueOf: num) , '*(_smax'
				, p , '-_smin' , p , ')/180)+_smin' , p , ')'
]
