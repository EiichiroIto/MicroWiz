Class {
	#name : #CommQueue,
	#superclass : #Object,
	#instVars : [
		'queue',
		'lastMSec',
		'comm',
		'delimiter',
		'pending',
		'timeout'
	],
	#category : #'MicroWiz-Comm'
}

{ #category : #accessing }
CommQueue >> comm [
	^ comm
]

{ #category : #accessing }
CommQueue >> comm: aComm [
	comm := aComm
]

{ #category : #private }
CommQueue >> defaultDelimiter [
	^ Character cr asciiValue
]

{ #category : #private }
CommQueue >> defaultTimeout [
	^ 1000
]

{ #category : #accessing }
CommQueue >> delimiter [
	^ delimiter
]

{ #category : #accessing }
CommQueue >> delimiter: anInteger [
	delimiter := anInteger
]

{ #category : #private }
CommQueue >> enqueueWithDelimiter [
	pending add: delimiter.
	queue add: pending asByteArray.
	pending := OrderedCollection new
]

{ #category : #api }
CommQueue >> flush [
	queue := OrderedCollection new.
	pending := OrderedCollection new.
	comm ifNotNil: [ [ comm get notNil ] whileTrue ]
]

{ #category : #api }
CommQueue >> get [
	queue isEmpty
		ifFalse: [ ^ queue removeFirst ].
	self processReceived: comm get.
	queue isEmpty
		ifFalse: [ ^ queue removeFirst ].
	self isTimeout
		ifFalse: [ ^ nil ].
	pending isEmpty
		ifTrue: [ ^ nil ].
	^ pending
		in: [ :list | 
			pending := OrderedCollection new.
			list asByteArray ]
]

{ #category : #initialization }
CommQueue >> initialize [
	self flush.
	self timeout: self defaultTimeout.
	self delimiter: Character cr asciiValue.
	self updateLastMSec
]

{ #category : #testing }
CommQueue >> isTimeout [
	^ Time millisecondClockValue - lastMSec >= timeout
]

{ #category : #accessing }
CommQueue >> lastMSec [
	^ lastMSec
]

{ #category : #accessing }
CommQueue >> pending [
	^ pending
]

{ #category : #printing }
CommQueue >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: queue size asString;
		nextPut: $,;
		nextPutAll: pending asString;
		nextPut: $)
]

{ #category : #private }
CommQueue >> processReceived: aByteArray [
	aByteArray ifNil: [ ^ self ].
	self updateLastMSec.
	aByteArray
		do: [ :each | 
			each = delimiter
				ifTrue: [ self enqueueWithDelimiter ]
				ifFalse: [ pending add: each ] ]
]

{ #category : #accessing }
CommQueue >> queue [
	^ queue
]

{ #category : #accessing }
CommQueue >> timeout [
	^ timeout
]

{ #category : #accessing }
CommQueue >> timeout: anInteger [
	timeout := anInteger
]

{ #category : #private }
CommQueue >> updateLastMSec [
	lastMSec := Time millisecondClockValue
]
