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
