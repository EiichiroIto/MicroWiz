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
