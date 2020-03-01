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
MicrobitGeneratorTest >> testCharacterImageOf [
	self testSymbolImageOf
]

{ #category : #test }
MicrobitGeneratorTest >> testClockImageOf [
	self testSymbolImageOf
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
MicrobitGeneratorTest >> testInitialize [
	| g |
	g := self newGenerator.
	self assert: g servos isCollection
]

{ #category : #test }
MicrobitGeneratorTest >> testMicrobit [
	| g |
	g := self newGenerator.
	self assert: g microbit equals: 'microbit.'.
	self assert: (g imports includes: 'microbit')
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
MicrobitGeneratorTest >> testShapeImageOf [
	self testSymbolImageOf
]

{ #category : #test }
MicrobitGeneratorTest >> testSymbolImageOf [
	| g |
	g := self newGenerator.
	self assert: (g symbolImageOf: #heart) equals: 'Image.HEART'.
	self assert: (g symbolImageOf: #sad) equals: 'Image.SAD'
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
