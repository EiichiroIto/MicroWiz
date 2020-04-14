"
A MicroPythonBlockSpecsTest is a test class for testing the behavior of MicroPythonBlockSpecs
"
Class {
	#name : #MicroPythonBlockSpecsTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroPythonBlockSpecsTest >> newSpecs [
	^ MicroPythonBlockSpecs new
]

{ #category : #test }
MicroPythonBlockSpecsTest >> testBlocks [
	| s |
	s := self newSpecs.
	self assert: s blocks isArray
]

{ #category : #test }
MicroPythonBlockSpecsTest >> testControlBlocks [
	| s |
	s := self newSpecs.
	self assert: s controlBlocks isArray
]

{ #category : #test }
MicroPythonBlockSpecsTest >> testDisplayBlocks [
	| s |
	s := self newSpecs.
	self assert: s displayBlocks isArray
]

{ #category : #test }
MicroPythonBlockSpecsTest >> testIoBlocks [
	| s |
	s := self newSpecs.
	self assert: s ioBlocks isArray
]

{ #category : #test }
MicroPythonBlockSpecsTest >> testOperatorsBlocks [
	| s |
	s := self newSpecs.
	self assert: s operatorsBlocks isArray
]

{ #category : #test }
MicroPythonBlockSpecsTest >> testSensingBlocks [
	| s |
	s := self newSpecs.
	self assert: s sensingBlocks isArray
]
