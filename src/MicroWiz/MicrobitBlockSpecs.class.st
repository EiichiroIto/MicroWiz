Class {
	#name : #MicrobitBlockSpecs,
	#superclass : #MicroPythonBlockSpecs,
	#category : #'MicroWiz-Microbit'
}

{ #category : #'argument menus' }
MicrobitBlockSpecs >> buttonNames [
	^ #(a b)
]

{ #category : #'block specs' }
MicrobitBlockSpecs >> controlBlocks [
	^ super controlBlocks , #(
		'control'
			-
			('wait %n msecs'			-	waitMsecs: 1000)
			('panic %n'					-	panic: 0)
	)
]

{ #category : #'block specs' }
MicrobitBlockSpecs >> displayBlocks [
	^ super displayBlocks , #(
		'display'
			('scroll %s'						s		scrollAndWait: 	'Hello')
			('scroll %s no wait'			-		scroll: 				'World!')
			('show %s'							s		show: 					'A')
			-
			('point x %n y %n'				r		pixelAtX:y: 0 0)
			('set x %n y %n to %n'		-		pixelAtX:y:put: 0 0 0)
			('clear'								-		clearPixels)
			-
			('symbol image of %M'			r		symbolImageOf:	 	heart)
			('clock image of %c'			r		clockImageOf:		clock12)
			('arrow image of %A'			r		arrowImageOf:		arrowN)
			('shape image of %H'			r		shapeImageOf:		triangle)
			('character image of %I'	r		characterImageOf: 	rabbit)
			('clock image at %n'			r		clockImageAt: 		0)
			('arrow image at %n'			r		arrowImageAt: 		0)
			('image of %s'						r		imageOf: 				'')
			('images of %L'					r		getList:				'list')
			('image width %n height %n'	r	imageWidth:height: 5 5)
			('inverted image of %s'			r	invertedImageOf: '')
			-
			('point x %n y %n of %s'		r	pixelAtX:y:of: 0 0 '')
			('set x %n y %n to %n of %s'	-	pixelAtX:y:of:put: 0 0 0 '')
			('fill %s with %n'					-	fill:with: '' 0)
			('crop area x %n y %n w %n h %n of %s'	r	cropX:y:w:h:of:	0 0 5 5 '')
			-
			('led on'			-		#ledOn)
			('led off'		-		#ledOff)
			('led is on'	b		#isLedOn)
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
			('digital read pin %n'					r		readDigital: 0)
			('digital write pin %n to %n'		-		writeDigital:to: 0 0) 
			('analog read pin %n'						r		readAnalog: 0)
			('analog write pin %n to %n'			- 		writeAnalog:to: 0 0)
			('analog set period pin %n to %n msec'
																	- setAnalogPeriod:msec: 0 500)
			('pin %n is touched'						b		pinIsTouched: 0)
			-
			('servo write pin %G to %n degrees'
																	-		writeServo:to: 0 180)
			('servo set pin %G %n msec %n to %n'
																	-		setServo:msec:min:max:	0	5	100	500)
			-
			('set i2c freq %n sda %n scl %n'
																	-		i2cInitFreq:sda:scl: 100000 20 19)
			('i2c read %n bytes from %n into %L'
																	-		i2cRead:from:into:		4 0 'list')
			('i2c write %s to %n'						-		i2cWrite:to: 				'[1,2,3]' 0)
			('i2c write %L to %n'						-		i2cWriteList:to:			'list' 0)
			-
			('set neopixel pin %n num %n'		-		setNeoPixelPin:num:	0 1)
			('pin %n no %n r %n g %n b %n'
																	-		neoPixel:no:r:g:b: 0 0 255 255 255)
			('show neopixel pin %n'					-		neoPixelShow: 0)
			('clear neopixel pin %n'				-		neoPixelClear: 0)
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

{ #category : #'block specs' }
MicrobitBlockSpecs >> miscBlocks [
	^ super miscBlocks , #(
		'misc'
			-
			('radio on'								-	radioOn)
			('radio off'							-	radioOff)
			('config radio group %n'		-	configRadioGroup:	0)
			('send a radio message %s'	-	sendRadio:	'Hello!')
			('received radio message'		r	receiveRadio)
			('radio reset'							-	resetRadio)
			-
			('play music %s'						-	playMusic: 'c1:4 e:2 g c2:4')
			('play music %s loop %b wait %b'	-	playMusic:loop:wait: 'c1:4 e:2 g c2:4')
			('stop music'							-	stopMusic)
			-
			('set tempo to %n ticks'		-	setTempoTicks: 4)
			('set tempo to %n bpm'			-	setTempoBpm: 120)
			('tempo'									r	getTempo)
			('play pitch %n Hz for %n msec'	-	playPitch:msec: 440 1000)
			('reset music settings'			-	resetMusic)
			-
			('count of %s'							r	countOf: '')
			('copy of %s'							r	copyOf: '')
			('clear %s'								-	clear: '')
	)
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
			('running time'				r	runningTime)
			('temperature'					r	temperature)
			('%E sensor value'			r	sensorValueOf: 'accelX')
			-
			('current gesture'			r	currentGesture)
			('is gesture %g ?'			b	isGesture: up)
			('was gesture %g ?'		b	wasGesture: up)
			('gestures'						r	gestures)
			-
			('calibrate compass'		-	calibrateCompass)
			('is calibrated'				b	isCalibrated)
			('heading'						r	headingCompass)
			('clear calibration'		-	clearCalibration)
			('field strength'			r	fieldStrength)
	)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> sensorNames [
	^ #(accelX accelY accelZ - compassX compassY compassZ)
]

{ #category : #'argument menus' }
MicrobitBlockSpecs >> uncoloredArgMorphFor: specString ifAbsent: aBlock [
	| code |
	code := specString at: 2.
	$A = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #ledArrowNames;
				getOptionsTarget: self;
				yourself ].
	$B = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #buttonNames;
				getOptionsTarget: self;
				yourself ].
	$E = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #sensorNames;
				getOptionsTarget: self;
				yourself ].
	$c = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #ledClockNames;
				getOptionsTarget: self;
				yourself ].
	$g = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #gestureNames;
				getOptionsTarget: self;
				yourself ].
	$G = code
		ifTrue: [ ^ ExpressionArgMorphWithMenu new
				numExpression: '0';
				menuSelector: #ioPinNames;
				menuTarget: self ].
	$H = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #ledShapeNames;
				getOptionsTarget: self;
				yourself ].
	$I = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #ledCharacterNames;
				getOptionsTarget: self;
				yourself ].
	$l = code
		ifTrue: [ ^ self error: 'LedArgMorph new' ].
	$M = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #ledSymbolNames;
				getOptionsTarget: self;
				yourself ].
	$P = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #neoPixelPinNames;
				getOptionsTarget: self;
				yourself ].
	^ super uncoloredArgMorphFor: specString ifAbsent: aBlock
]
