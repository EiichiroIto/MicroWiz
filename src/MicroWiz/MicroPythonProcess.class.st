Class {
	#name : #MicroPythonProcess,
	#superclass : #Object,
	#instVars : [
		'topBlock',
		'proxy'
	],
	#category : #'MicroWiz-MPython'
}

{ #category : #testing }
MicroPythonProcess >> errorFlag [
	^ false
]

{ #category : #testing }
MicroPythonProcess >> isRunning [
	^ proxy isRunning
]

{ #category : #accessing }
MicroPythonProcess >> proxy [
	^ proxy
]

{ #category : #accessing }
MicroPythonProcess >> proxy: anObject [
	proxy := anObject.
]

{ #category : #accessing }
MicroPythonProcess >> stop [
	proxy isRunning
		ifTrue: [ proxy sendBreak ].
	topBlock ifNotNil: [ topBlock scratchProc: nil ]
]

{ #category : #accessing }
MicroPythonProcess >> topBlock [
	^ topBlock
]

{ #category : #accessing }
MicroPythonProcess >> topBlock: aBlock [ 
	topBlock := aBlock.
]
