"
An ESP8266GeneratorTest is a test class for testing the behavior of ESP8266Generator
"
Class {
	#name : #ESP8266GeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ESP8266GeneratorTest >> newGenerator [
	^ ESP8266Generator new
]

{ #category : #test }
ESP8266GeneratorTest >> testI2c [
	| g |
	g := self newGenerator.
	self assert: g i2c equals: '_i2c'.
	self assert: ((g modules at: 'machine') includes: 'I2C')
]

{ #category : #test }
ESP8266GeneratorTest >> testI2cWriteTo [
	| g |
	g := self newGenerator.
	g i2cWrite: '1,2,3' to: 20.
	self
		assert: g code
		equals: '_i2c.writeto(20,bytes(1,2,3))' , String lf
]
