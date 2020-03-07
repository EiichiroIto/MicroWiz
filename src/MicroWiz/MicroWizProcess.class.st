Class {
	#name : #MicroWizProcess,
	#superclass : #Object,
	#instVars : [
		'topBlock',
		'proxy'
	],
	#category : #'MicroWiz-Core'
}

{ #category : #testing }
MicroWizProcess >> errorFlag [
	^ false
]

{ #category : #testing }
MicroWizProcess >> isRunning [
	^ proxy isRunning
]

{ #category : #accessing }
MicroWizProcess >> proxy [
	^ proxy
]

{ #category : #accessing }
MicroWizProcess >> proxy: anObject [
	proxy := anObject.
]

{ #category : #accessing }
MicroWizProcess >> stop [
	proxy isRunning
		ifTrue: [ proxy sendBreak ].
	topBlock ifNotNil: [ topBlock scratchProc: nil ]
]

{ #category : #accessing }
MicroWizProcess >> topBlock [
	^ topBlock
]

{ #category : #accessing }
MicroWizProcess >> topBlock: aBlock [ 
	topBlock := aBlock.
]
