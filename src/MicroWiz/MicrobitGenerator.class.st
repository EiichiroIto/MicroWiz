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

{ #category : #'display ops' }
MicrobitGenerator >> characterImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #'display ops' }
MicrobitGenerator >> clockImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #'io ops' }
MicrobitGenerator >> countOfButtonPressed: button [
	^ (self button: button) , (self nullaryFunction: 'get_presses')
]

{ #category : #private }
MicrobitGenerator >> delServo: num [
	servos remove: (self valueOf: num) asNumberNoError ifAbsent: [  ]
]

{ #category : #private }
MicrobitGenerator >> image [
	self from: 'microbit' import: 'Image'.
	^ 'Image.'
]

{ #category : #initialization }
MicrobitGenerator >> initialize [
	super initialize.
	servos := Set new
]

{ #category : #private }
MicrobitGenerator >> microbit [
	self import: 'microbit'.
	^ 'microbit.'
]

{ #category : #private }
MicrobitGenerator >> pin: anInteger [
	^ self microbit, 'pin', (self valueOf: anInteger)
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

{ #category : #'display ops' }
MicrobitGenerator >> shapeImageOf: aSymbol [
	^ self symbolImageOf: aSymbol
]

{ #category : #'display ops' }
MicrobitGenerator >> symbolImageOf: aSymbol [
	^ self image , (self class showSymbolAt: aSymbol)
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
