Class {
	#name : #DummyComm,
	#superclass : #MWComm,
	#instVars : [
		'operations',
		'isConnected',
		'getQueue',
		'putQueue'
	],
	#category : #'MicroWiz-Comm'
}

{ #category : #accessing }
DummyComm >> addGetQueue: aCollection [
	getQueue add: aCollection
]

{ #category : #accessing }
DummyComm >> addPutQueue: aCollection [
	putQueue add: aCollection
]

{ #category : #api }
DummyComm >> close [
	operations add: 'close'.
	self isConnected: false
]

{ #category : #api }
DummyComm >> get [
	getQueue isEmpty ifTrue: [ ^ nil ].
	^ getQueue removeFirst
]

{ #category : #accessing }
DummyComm >> getQueue [
	^ getQueue
]

{ #category : #initialization }
DummyComm >> initialize [ 
	getQueue := OrderedCollection new.
	putQueue := OrderedCollection new.
	operations := OrderedCollection new.
	self isConnected: false
]

{ #category : #api }
DummyComm >> isConnected [
	^ isConnected
]

{ #category : #accessing }
DummyComm >> isConnected: aBoolean [
	isConnected := aBoolean
]

{ #category : #api }
DummyComm >> open [
	operations add: 'open'.
	self isConnected: true.
	^ true
]

{ #category : #accessing }
DummyComm >> operations [
	^ operations
]

{ #category : #accessing }
DummyComm >> options [
	^ #(portName baudRate)
]

{ #category : #accessing }
DummyComm >> optionsNamed: aSymbol [
	aSymbol = #baudRate
		ifTrue: [ ^ #(2400 4800 9600 19200 38400 76800 115200) ].
	aSymbol = #portName
		ifTrue: [ ^ self unixPortNames ].
	^ #()
]

{ #category : #api }
DummyComm >> put: aByteArray [
	putQueue add: aByteArray copy.
	^ aByteArray size
]

{ #category : #accessing }
DummyComm >> putQueue [
	^ putQueue
]

{ #category : #accessing }
DummyComm >> setOption: aString to: anObject [
	operations add: 'setOption: ' , aString , ' to: ' , anObject asString
]

{ #category : #accessing }
DummyComm >> step [
	putQueue isEmpty ifTrue: [ ^ self ].
	getQueue add: putQueue removeFirst, #[10]
]

{ #category : #private }
DummyComm >> unixPortNames [
	| dir list |
	dir := '/dev/' asFileReference.
	list := dir fileNames.
	list := list
				select: [:each | (each beginsWith: 'ttyUSB')
						or: [each beginsWith: 'ttyACM']].
	^ list collect: [:each | (dir / each) pathString ]
]
