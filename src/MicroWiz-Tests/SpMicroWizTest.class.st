"
A SpMicroWizTest is a test class for testing the behavior of SpMicroWiz
"
Class {
	#name : #SpMicroWizTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
SpMicroWizTest >> newApplication [
	^ SpMicroWiz new
]

{ #category : #test }
SpMicroWizTest >> testPlotData [
	| a |
	a := self newApplication.
	self deny: a plotData.
	a plotData: true.
	self assert: a withHeader.
	a plotData: false.
	self deny: a plotData
]

{ #category : #test }
SpMicroWizTest >> testWithHeader [
	| a |
	a := self newApplication.
	self assert: a withHeader.
	a withHeader: false.
	self deny: a withHeader.
	a withHeader: true.
	self assert: a withHeader
]
