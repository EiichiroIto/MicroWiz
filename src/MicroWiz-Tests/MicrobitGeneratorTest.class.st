"
A MicrobitGeneratorTest is a test class for testing the behavior of MicrobitGenerator
"
Class {
	#name : #MicrobitGeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicrobitGeneratorTest >> newGenerator [
	^ MicrobitGenerator new
]

{ #category : #test }
MicrobitGeneratorTest >> testAddServo [
	| g |
	g := self newGenerator.
	self assert: g servos isEmpty.
	g addServo: 1.
	g addServo: 2.
	g addServo: 3.
	self assert: (g servos includes: 1).
	self assert: (g servos includes: 2).
	self assert: (g servos includes: 3).
	self deny: (g servos includes: 4)
]

{ #category : #test }
MicrobitGeneratorTest >> testArrowImageAt [
	| g |
	g := self newGenerator.
	self assert: (g arrowImageAt: 1) equals: 'Image.ALL_ARROWS[1]'.
	self assert: (g arrowImageAt: [2]) equals: 'Image.ALL_ARROWS[2]'
]

{ #category : #test }
MicrobitGeneratorTest >> testArrowImageOf [
	self testSymbolImageOf
]

{ #category : #test }
MicrobitGeneratorTest >> testButton [
	| g |
	g := self newGenerator.
	self assert: (g button: 'a') equals: 'microbit.button_a.'.
	self assert: (g imports includes: 'microbit')
]

{ #category : #test }
MicrobitGeneratorTest >> testButtonIsPressed [
	| g |
	g := self newGenerator.
	self
		assert: (g buttonIsPressed: 'a')
		equals: 'microbit.button_a.is_pressed()'.
	self
		assert: (g buttonIsPressed: 'b')
		equals: 'microbit.button_b.is_pressed()'
]

{ #category : #test }
MicrobitGeneratorTest >> testButtonWasPressed [
	| g |
	g := self newGenerator.
	self
		assert: (g buttonWasPressed: 'a')
		equals: 'microbit.button_a.was_pressed()'.
	self
		assert: (g buttonWasPressed: 'b')
		equals: 'microbit.button_b.was_pressed()'
]

{ #category : #test }
MicrobitGeneratorTest >> testCalibrateCompass [
	| g |
	g := self newGenerator.
	g calibrateCompass.
	self assert: g code equals: 'microbit.compass.calibrate()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testCharacterImageOf [
	self testSymbolImageOf
]

{ #category : #test }
MicrobitGeneratorTest >> testClear [
	| g |
	g := self newGenerator.
	g clear: 'x'.
	self assert: g code equals: 'x.clear()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testClearCalibration [
	| g |
	g := self newGenerator.
	g clearCalibration.
	self assert: g code equals: 'microbit.compass.clear_calibration()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testClearPixels [
	| g |
	g := self newGenerator.
	g clearPixels.
	self assert: g code equals: 'display.clear()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testClockImageAt [
	| g |
	g := self newGenerator.
	self assert: (g clockImageAt: 1) equals: 'Image.ALL_CLOCKS[1]'.
	self assert: (g clockImageAt: [2]) equals: 'Image.ALL_CLOCKS[2]'
]

{ #category : #test }
MicrobitGeneratorTest >> testClockImageOf [
	self testSymbolImageOf
]

{ #category : #test }
MicrobitGeneratorTest >> testConfigRadioGroup [
	| g |
	g := self newGenerator.
	g configRadioGroup: 1.
	self assert: g code equals: 'radio.config(group=1)' , String lf.
	g := self newGenerator.
	g configRadioGroup: [2].
	self assert: g code equals: 'radio.config(group=2)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testCopyOf [
	| g |
	g := self newGenerator.
	self assert: (g copyOf: 'x') equals: 'x.copy()'
]

{ #category : #test }
MicrobitGeneratorTest >> testCountOf [
	| g |
	g := self newGenerator.
	self assert: (g countOf: 'x') equals: 'x.count()'
]

{ #category : #test }
MicrobitGeneratorTest >> testCountOfButtonPressed [
	| g |
	g := self newGenerator.
	self
		assert: (g countOfButtonPressed: 'a')
		equals: 'microbit.button_a.get_presses()'.
	self
		assert: (g countOfButtonPressed: 'b')
		equals: 'microbit.button_b.get_presses()'
]

{ #category : #test }
MicrobitGeneratorTest >> testCropXYWHOf [
	| g |
	g := self newGenerator.
	self assert: (g cropX: 1 y: 2 w: 3 h: 4 of: 'x') equals: 'x.crop(1,2,3,4)'
]

{ #category : #test }
MicrobitGeneratorTest >> testCurrentGesture [
	| g |
	g := self newGenerator.
	self assert: g currentGesture equals: 'microbit.accelerometer.current_gesture()'
]

{ #category : #test }
MicrobitGeneratorTest >> testDelServo [
	| g |
	g := self newGenerator.
	self assert: g servos isEmpty.
	g addServo: 1.
	g addServo: 2.
	g delServo: 3.
	g delServo: 1.
	self deny: (g servos includes: 1).
	self assert: (g servos includes: 2).
	self deny: (g servos includes: 3).
	self deny: (g servos includes: 4)
]

{ #category : #test }
MicrobitGeneratorTest >> testDisplay [
	| g |
	g := self newGenerator.
	self assert: g display equals: 'display.'.
	self assert: ((g modules at: 'microbit') includes: 'display')
]

{ #category : #test }
MicrobitGeneratorTest >> testFieldStrength [
	| g |
	g := self newGenerator.
	self assert: g fieldStrength equals: 'microbit.compass.get_field_strength()'
]

{ #category : #test }
MicrobitGeneratorTest >> testFillWith [
	| g |
	g := self newGenerator.
	g fill: 'x' with: 0.
	self assert: g code equals: 'x.fill(0)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testGestures [
	| g |
	g := self newGenerator.
	self assert: g gestures equals: ''' ''.join(microbit.accelerometer.get_gestures())'
]

{ #category : #test }
MicrobitGeneratorTest >> testGetTempo [
	| g |
	g := self newGenerator.
	self assert: g getTempo equals: 'music.get_tempo()'
]

{ #category : #test }
MicrobitGeneratorTest >> testHeadingCompass [
	| g |
	g := self newGenerator.
	self assert: g headingCompass equals: 'microbit.compass.heading()'
]

{ #category : #test }
MicrobitGeneratorTest >> testI2c [
	| g |
	g := self newGenerator.
	self assert: g i2c equals: '_i2c.'.
	self assert: ((g modules at: 'microbit') includes: 'i2c').
	self assert: (g inits includes: #i2c)
]

{ #category : #test }
MicrobitGeneratorTest >> testI2cInit [
	| g |
	g := self newGenerator.
	g i2cInit.
	self assert: g code equals: '_i2c.init()' , String lf.
	self deny: (g inits includes: #i2c)
]

{ #category : #test }
MicrobitGeneratorTest >> testI2cInitFreqSdaScl [
	| g |
	g := self newGenerator.
	g i2cInitFreq: 100000 sda: 20 scl: 19.
	self
		assert: g code
		equals: '_i2c.init(freq=100000,sda=microbit.pin20,scl=microbit.pin19)' , String lf.
	self deny: (g inits includes: #i2c)
]

{ #category : #test }
MicrobitGeneratorTest >> testI2cReadFromInto [
	| g |
	g := self newGenerator.
	g i2cRead: 4 from: 10 into: 'x'.
	self assert: g code equals: 'x=_i2c.read(10,4)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testI2cWriteListTo [
	| g |
	g := self newGenerator.
	g i2cWriteList: 'x' to: [10].
	self assert: g code equals: '_i2c.write(10,bytes(x))' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testI2cWriteTo [
	| g |
	g := self newGenerator.
	g i2cWrite: '1,2,3' to: [10].
	self assert: g code equals: '_i2c.write(10,bytes(1,2,3))' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testImage [
	| g |
	g := self newGenerator.
	self assert: g image equals: 'Image.'.
	self assert: ((g modules at: 'microbit') includes: 'Image')
]

{ #category : #test }
MicrobitGeneratorTest >> testImageOf [
	| g |
	g := self newGenerator.
	self
		assert: (g imageOf: '"05050:05050:05050:99999:09990"')
		equals: 'Image("05050:05050:05050:99999:09990")'
]

{ #category : #test }
MicrobitGeneratorTest >> testImageWidthHeight [
	| g |
	g := self newGenerator.
	self assert: (g imageWidth: 10 height: 20) equals: 'Image(10,20)'
]

{ #category : #test }
MicrobitGeneratorTest >> testInitialize [
	| g |
	g := self newGenerator.
	self assert: g servos isCollection
]

{ #category : #test }
MicrobitGeneratorTest >> testInvertedImageOf [
	| g |
	g := self newGenerator.
	self assert: (g invertedImageOf: 'x') equals: 'x.invert()'
]

{ #category : #test }
MicrobitGeneratorTest >> testIsCalibrated [
	| g |
	g := self newGenerator.
	self assert: g isCalibrated equals: 'microbit.compass.is_calibrated()'
]

{ #category : #test }
MicrobitGeneratorTest >> testIsGesture [
	| g |
	g := self newGenerator.
	self assert: (g isGesture: '"up"') equals: 'microbit.accelerometer.is_gesture("up")'
]

{ #category : #test }
MicrobitGeneratorTest >> testIsLedOn [
	| g |
	g := self newGenerator.
	self assert: g isLedOn equals: 'display.is_on()'
]

{ #category : #test }
MicrobitGeneratorTest >> testLedOff [
	| g |
	g := self newGenerator.
	g ledOff.
	self assert: g code equals: 'display.off()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testLedOn [
	| g |
	g := self newGenerator.
	g ledOn.
	self assert: g code equals: 'display.on()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testMicrobit [
	| g |
	g := self newGenerator.
	self assert: g microbit equals: 'microbit.'.
	self assert: (g imports includes: 'microbit')
]

{ #category : #test }
MicrobitGeneratorTest >> testMusic [
	| g |
	g := self newGenerator.
	self assert: g music equals: 'music.'.
	self assert: (g imports includes: 'music')
]

{ #category : #test }
MicrobitGeneratorTest >> testNeoPixelClear [
	| g |
	g := self newGenerator.
	g neoPixelClear: 2.
	self assert: g code equals: '_np2.clear()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testNeoPixelShow [
	| g |
	g := self newGenerator.
	g neoPixelShow: 2.
	self assert: g code equals: '_np2.show()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testPanic [
	| g |
	g := self newGenerator.
	g panic: 123.
	self assert: g code equals: 'microbit.panic(123)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testPin [
	| g |
	g := self newGenerator.
	self assert: (g pin: 0) equals: 'microbit.pin0'.
	self assert: (g imports includes: 'microbit').
	self assert: (g pin: [1]) equals: 'microbit.pin1'
]

{ #category : #test }
MicrobitGeneratorTest >> testPinIsTouched [
	| g |
	g := self newGenerator.
	self
		assert: (g pinIsTouched: 0)
		equals: 'microbit.pin0.is_touched()'.
	self
		assert: (g pinIsTouched: [1])
		equals: 'microbit.pin1.is_touched()'
]

{ #category : #test }
MicrobitGeneratorTest >> testPixelAtXY [
	| g |
	g := self newGenerator.
	self
		assert: (g pixelAtX: 1 y: 2)
		equals: 'display.get_pixel(1,2)'.
	self
		assert: (g pixelAtX: [3] y: [4])
		equals: 'display.get_pixel(3,4)'
]

{ #category : #test }
MicrobitGeneratorTest >> testPixelAtXYOf [
	| g |
	g := self newGenerator.
	self assert: (g pixelAtX: 1 y: 2 of: 'x') equals: 'x.get_pixel(1,2)'
]

{ #category : #test }
MicrobitGeneratorTest >> testPixelAtXYOfPut [
	| g |
	g := self newGenerator.
	g pixelAtX: 1 y: 2 of: 'x' put: 3.
	self assert: g code equals: 'x.set_pixel(1,2,3)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testPixelAtXYPut [
	| g |
	g := self newGenerator.
	g pixelAtX: 1 y: 2 put: 3.
	self assert: g code equals: 'display.set_pixel(1,2,3)' , String lf.
	g := self newGenerator.
	g pixelAtX: [4] y: [5] put: [6].
	self assert: g code equals: 'display.set_pixel(4,5,6)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testPlayMusic [
	| g |
	g := self newGenerator.
	g playMusic: '''c1:4 e:2 g c2:4'''.
	self
		assert: g code
		equals: 'music.play(''c1:4 e:2 g c2:4''.split(''.''))' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testPlayMusicLoopWait [
	| g |
	g := self newGenerator.
	g playMusic: '''c1:4 e:2 g c2:4''' loop: false wait: false.
	self
		assert: g code
		equals: 'music.play(''c1:4 e:2 g c2:4''.split(''.''))' , String lf.
	g := self newGenerator.
	g playMusic: '''c1:4 e:2 g c2:4''' loop: true wait: false.
	self
		assert: g code
		equals: 'music.play(''c1:4 e:2 g c2:4''.split(''.''),loop=True)' , String lf.
	g := self newGenerator.
	g playMusic: '''c1:4 e:2 g c2:4''' loop: false wait: true.
	self
		assert: g code
		equals: 'music.play(''c1:4 e:2 g c2:4''.split(''.''),wait=True)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testPlayPitchMsec [
	| g |
	g := self newGenerator.
	g playPitch: 12 msec: 34.
	self assert: g code equals: 'music.pitch(12,duration=34)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testRadio [
	| g |
	g := self newGenerator.
	self assert: g radio equals: 'radio.'.
	self assert: (g imports includes: 'radio')
]

{ #category : #test }
MicrobitGeneratorTest >> testRadioOff [
	| g |
	g := self newGenerator.
	g radioOff.
	self assert: g code equals: 'radio.off()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testRadioOn [
	| g |
	g := self newGenerator.
	g radioOn.
	self assert: g code equals: 'radio.on()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testReadAnalog [
	| g |
	g := self newGenerator.
	self
		assert: (g readAnalog: 0)
		equals: 'microbit.pin0.read_analog()'.
	self
		assert: (g readAnalog: [1])
		equals: 'microbit.pin1.read_analog()'
]

{ #category : #test }
MicrobitGeneratorTest >> testReadDigital [
	| g |
	g := self newGenerator.
	self
		assert: (g readDigital: 0)
		equals: 'microbit.pin0.read_digital()'.
	self
		assert: (g readDigital: [1])
		equals: 'microbit.pin1.read_digital()'
]

{ #category : #test }
MicrobitGeneratorTest >> testReceiveRadio [
	| g |
	g := self newGenerator.
	self assert: g receiveRadio equals: 'radio.receive()'
]

{ #category : #test }
MicrobitGeneratorTest >> testResetMusic [
	| g |
	g := self newGenerator.
	g resetMusic.
	self assert: g code equals: 'music.reset()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testResetRadio [
	| g |
	g := self newGenerator.
	g resetRadio.
	self assert: g code equals: 'radio.reset()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testRunningTime [
	| g |
	g := self newGenerator.
	self assert: g runningTime equals: 'microbit.running_time()'
]

{ #category : #test }
MicrobitGeneratorTest >> testScroll [
	| g |
	g := self newGenerator.
	g scroll: '"abc"' wait: false.
	self
		assert: g code
		equals: 'display.scroll(str("abc"),wait=False)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testScrollAndWait [
	| g |
	g := self newGenerator.
	g scroll: 'def' wait: true.
	self
		assert: g code
		equals: 'display.scroll(str(def))' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testScrollWait [
	| g |
	g := self newGenerator.
	g scroll: '"abc"' wait: false.
	self
		assert: g code
		equals: 'display.scroll(str("abc"),wait=False)' , String lf.
	g := self newGenerator.
	g scroll: 'def' wait: true.
	self
		assert: g code
		equals: 'display.scroll(str(def))' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSendRadio [
	| g |
	g := self newGenerator.
	g sendRadio: 10.
	self assert: g code equals: 'radio.send(10)' , String lf.
	g := self newGenerator.
	g sendRadio: '"abc"'.
	self assert: g code equals: 'radio.send("abc")' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSensorValueOf [
	| g |
	g := self newGenerator.
	self assert: (g sensorValueOf: #accelX) equals: 'microbit.accelerometer.get_x()'.
	self assert: (g sensorValueOf: #compassY) equals: 'microbit.compass.get_y()'
]

{ #category : #test }
MicrobitGeneratorTest >> testServos [
	| g |
	g := self newGenerator.
	self assert: g servos isCollection.
	self assert: g servos isEmpty
]

{ #category : #test }
MicrobitGeneratorTest >> testSetAnalogPeriodMsec [
	| g |
	g := self newGenerator.
	g setAnalogPeriod: 0 msec: 10.
	self
		assert: g code
		equals: 'microbit.pin0.set_analog_period_microseconds(10)' , String lf.
	g := self newGenerator.
	g setAnalogPeriod: [ 1 ] msec: [ 20 ].
	self
		assert: g code
		equals: 'microbit.pin1.set_analog_period_microseconds(20)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSetNeoPixelPinNum [
	| g |
	g := self newGenerator.
	g setNeoPixelPin: 5 num: 6.
	self assert: g code equals: '_np5=neopixel.NeoPixel(microbit.pin5,6)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSetServoMsecMinMax [
	| g ret |
	g := self newGenerator.
	g
		setServo: 1
		msec: 2
		min: 3
		max: 4.
	ret := g code.
	self
		assert: ret
		equals:
			'microbit.pin1.set_analog_period(2)' , String lf , '(_smin1,_smax1)=(3,4)'
				, String lf.
	self deny: (g servos includes: 1)
]

{ #category : #test }
MicrobitGeneratorTest >> testSetTempoBpm [
	| g |
	g := self newGenerator.
	g setTempoBpm: 123.
	self assert: g code equals: 'music.set_tempo(bpm=123)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSetTempoBpmTicks [
	| g |
	g := self newGenerator.
	g setTempoBpm: 123 ticks: nil.
	self assert: g code equals: 'music.set_tempo(bpm=123)' , String lf.
	g := self newGenerator.
	g setTempoBpm: nil ticks: 456.
	self assert: g code equals: 'music.set_tempo(ticks=456)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSetTempoTicks [
	| g |
	g := self newGenerator.
	g setTempoBpm: nil ticks: 456.
	self assert: g code equals: 'music.set_tempo(ticks=456)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testShapeImageOf [
	self testSymbolImageOf
]

{ #category : #test }
MicrobitGeneratorTest >> testShow [
	| g |
	g := self newGenerator.
	g show: '"A"'.
	self assert: g code equals: 'display.show("A")' , String lf.
	g := self newGenerator.
	g show: 1.
	self assert: g code equals: 'display.show(1)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testStopMusic [
	| g |
	g := self newGenerator.
	g stopMusic.
	self assert: g code equals: 'music.stop()' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testSymbolImageOf [
	| g |
	g := self newGenerator.
	self assert: (g symbolImageOf: #heart) equals: 'Image.HEART'.
	self assert: (g symbolImageOf: #sad) equals: 'Image.SAD'
]

{ #category : #test }
MicrobitGeneratorTest >> testTemperature [
	| g |
	g := self newGenerator.
	self assert: g temperature equals: 'microbit.temperature()'
]

{ #category : #test }
MicrobitGeneratorTest >> testUtime [
	| g |
	g := self newGenerator.
	self assert: g utime equals: 'utime.'.
	self assert: (g imports includes: 'utime')
]

{ #category : #test }
MicrobitGeneratorTest >> testWaitMsecs [
	| g |
	g := self newGenerator.
	g waitMsecs: 100.
	self assert: g code equals: 'utime.sleep_ms(100)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testWasGesture [
	| g |
	g := self newGenerator.
	self assert: (g wasGesture: '"up"') equals: 'microbit.accelerometer.was_gesture("up")'
]

{ #category : #test }
MicrobitGeneratorTest >> testWriteAnalogTo [
	| g |
	g := self newGenerator.
	g writeAnalog: 0 to: 10.
	self
		assert: g code
		equals: 'microbit.pin0.write_analog(10)' , String lf.
	g := self newGenerator.
	g writeAnalog: [ 1 ] to: [ 20 ].
	self
		assert: g code
		equals: 'microbit.pin1.write_analog(20)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testWriteDigitalTo [
	| g |
	g := self newGenerator.
	g writeDigital: 0 to: 10.
	self
		assert: g code
		equals: 'microbit.pin0.write_digital(10)' , String lf.
	g := self newGenerator.
	g writeDigital: [ 1 ] to: [ 20 ].
	self
		assert: g code
		equals: 'microbit.pin1.write_digital(20)' , String lf
]

{ #category : #test }
MicrobitGeneratorTest >> testWriteServoTo [
	| g |
	g := self newGenerator.
	g writeServo: 1 to: 2.
	self
		assert: g code
		equals: 'microbit.pin1.write_analog((2*(_smax1-_smin1)/180)+_smin1)' , String lf.
	self assert: (g servos includes: 1)
]
