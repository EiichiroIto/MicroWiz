"
A MaixPyGeneratorTest is a test class for testing the behavior of MaixPyGenerator
"
Class {
	#name : #MaixPyGeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MaixPyGeneratorTest >> newGenerator [
	^ MaixPyGenerator new
]

{ #category : #test }
MaixPyGeneratorTest >> testLcd [
	| g |
	g := self newGenerator.
	self assert: g lcd equals: 'lcd'.
	self assert: (g imports includes: 'lcd')
]

{ #category : #test }
MaixPyGeneratorTest >> testLcdClear [
	| g |
	g := self newGenerator.
	g lcdClear.
	self assert: g code equals: 'lcd.clear()' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testLcdDeinit [
	| g |
	g := self newGenerator.
	g lcdDeinit.
	self assert: g code equals: 'lcd.deinit()' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testLcdDisplay [
	| g |
	g := self newGenerator.
	g lcdDisplay: 'abc'.
	self assert: g code equals: 'lcd.display(abc)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testLcdDrawStringXYFgBg [
	| g |
	g := self newGenerator.
	g
		lcdDrawString: '''abc'''
		x: 1
		y: 2
		fg: 'RED'
		bg: 'BLACK'.
	self
		assert: g code
		equals: 'lcd.draw_string(1,2,''abc'',lcd.RED,lcd.BLACK)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testLcdInit [
	| g |
	g := self newGenerator.
	g lcdInit.
	self assert: g code equals: 'lcd.init()' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testLcdRotation [
	| g |
	g := self newGenerator.
	g lcdRotation: 1.
	self assert: g code equals: 'lcd.rotation(1)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testSensor [
	| g |
	g := self newGenerator.
	self assert: g sensor equals: 'sensor'.
	self assert: (g imports includes: 'sensor')
]

{ #category : #test }
MaixPyGeneratorTest >> testSensorReset [
	| g |
	g := self newGenerator.
	g sensorReset.
	self assert: g code equals: 'sensor.reset()' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testSensorRun [
	| g |
	g := self newGenerator.
	g sensorRun: 0.
	self assert: g code equals: 'sensor.run(0)' , String lf.
	g := self newGenerator.
	g sensorRun: 1.
	self assert: g code equals: 'sensor.run(1)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testSensorSetFrameSize [
	| g |
	g := self newGenerator.
	g sensorSetFrameSize: 'QVGA'.
	self
		assert: g code
		equals: 'sensor.set_framesize(sensor.QVGA)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testSensorSetPixFormat [
	| g |
	g := self newGenerator.
	g sensorSetPixFormat: 'RGB565'.
	self
		assert: g code
		equals: 'sensor.set_pixformat(sensor.RGB565)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testSensorSetVFlip [
	| g |
	g := self newGenerator.
	g sensorSetVFlip: [ g getFalse ].
	self
		assert: g code
		equals: 'sensor.set_vflip(False)' , String lf.
	g := self newGenerator.
	g sensorSetVFlip: [ g getTrue ].
	self
		assert: g code
		equals: 'sensor.set_vflip(True)' , String lf
]

{ #category : #test }
MaixPyGeneratorTest >> testSensorSnapshot [
	| g |
	g := self newGenerator.
	self assert: g sensorSnapshot equals: 'sensor.snapshot()'
]
