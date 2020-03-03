Class {
	#name : #MicrobitBlockSpecs,
	#superclass : #MicroPythonBlockSpecs,
	#category : #'MicroWiz-Microbit'
}

{ #category : #'argument menus' }
MicrobitBlockSpecs >> addArgBuilderTo: anArgBuilder [
	super addArgBuilderTo: anArgBuilder.
	anArgBuilder
		addChoiceArg: $A
			selector: #ledArrowNames
			target: self
			initialChoice: '';
		addChoiceArg: $B
			selector: #buttonNames
			target: self
			initialChoice: 'a';
		addChoiceArg: $E
			selector: #sensorNames
			target: self
			initialChoice: '';
		addChoiceArg: $c
			selector: #ledClockNames
			target: self
			initialChoice: '';
		addChoiceArg: $g
			selector: #gestureNames
			target: self
			initialChoice: '';
		addNumberExpressArg: $G
			selector: #ioPinNames
			target: self
			initialExpression: '0';
		addChoiceArg: $H
			selector: #ledShapeNames
			target: self
			initialChoice: '';
		addChoiceArg: $I
			selector: #ledCharacterNames
			target: self
			initialChoice: '';
		addChoiceArg: $M
			selector: #ledSymbolNames
			target: self
			initialChoice: '';
		addChoiceArg: $P
			selector: #neoPixelPinNames
			target: self
			initialChoice: ''
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> buttonNames [
	^ #(a b)
]

{ #category : #'block specs' }
MicrobitBlockSpecs >> displayBlocks [
	^ super displayBlocks , #(
		'display'
			('symbol image of %M'			r		symbolImageOf:	 	heart)
			('clock image of %c'			r		clockImageOf:		clock12)
			('arrow image of %A'			r		arrowImageOf:		arrowN)
			('shape image of %H'			r		shapeImageOf:		triangle)
			('character image of %I'	r		characterImageOf: 	rabbit)
	)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> gestureNames [
	^ #(up down left right 'face up' 'face down' freefall '3g' '6g' '8g' shake)
]

{ #category : #'block specs' }
MicrobitBlockSpecs >> ioBlocks [
	^ super ioBlocks , #(
		'io'
			('button %B is pressed'					b		buttonIsPressed:)
			('button %B was pressed'				b		buttonWasPressed:)
			('count of button %B pressed'		r		countOfButtonPressed:)
			-
			('servo write pin %G to %n degrees'
																	-		writeServo:to: 0 180)
			('servo set pin %G %n msec %n to %n'
																	-		setServo:msec:min:max:	0	5	100	500)
		)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> ioPinNames [
	^ (0 to: 16) , #(19 20) collect: [ :s | {s asString. s} ]
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> ledArrowNames [
	^ #(arrowN arrowNE arrowE arrowSE arrowS arrowSW arrowW arrowNW)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> ledCharacterNames [
	^ #(rabbit cow musicCrotchet musicQuaver musicQuavers pitchfork xmas pacman target tshirt rollerskate duck house tortoise butterfly stickfigure ghost sword giraffe skull umbrella snake)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> ledClockNames [
	^ #(clock12 clock1 clock2 clock3 clock4 clock5 clock6 clock7 clock8 clock9 clock10 clock11)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> ledShapeNames [
	^ #(triangle triangleLeft chessboard diamond diamondSmall square squareSmall)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> ledSymbolNames [
	^ #(heart heartSmall happy smile sad confused angry asleep surprised silly fabulous meh yes no)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> musicNames [
	^ #(dadadadum entertainer prelude ode nyan ringtone funk blues birthday wedding funeral punchline python baddy chase baDing wawawawaa jumpUp jumpDown powerUp powerDown)
]

{ #category : #'block specs' }
MicrobitBlockSpecs >> sensingBlocks [
	^ super sensingBlocks, #(
		'sensing'
			-
			('%E sensor value'			r	sensorValueOf: 'accelX')
	)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> sensorNames [
	^ #(accelX accelY accelZ - compassX compassY compassZ)
]

{ #category : #'block specs' }
MicrobitBlockSpecs >> setupBlockCategoryTo: aBlockDef [
	super setupBlockCategoryTo: aBlockDef.
	aBlockDef
		addCategory: 'io' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'i2c' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'compass' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'radio' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'neopixel' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'music' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'display' color: (Color h: 264 s: 0.62 v: 0.89)
]

{ #category : #private }
MicrobitBlockSpecs >> setupIntModuleDef [
	super setupIntModuleDef.
	self addIntModuleDefNamed: 'microbit'
]
