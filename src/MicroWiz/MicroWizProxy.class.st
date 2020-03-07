Class {
	#name : #MicroWizProxy,
	#superclass : #Object,
	#instVars : [
		'comm',
		'lastMSec',
		'receiveQueue',
		'responses',
		'sendingQueue',
		'status'
	],
	#category : #'MicroWiz-Core'
}

{ #category : #constants }
MicroWizProxy class >> crRequest [
	^ #[13]
]

{ #category : #constants }
MicroWizProxy class >> delimiter [
	^ 10
]

{ #category : #private }
MicroWizProxy >> addResponse: aCollection [
	responses add: aCollection
]

{ #category : #private }
MicroWizProxy >> clearReceiveQueue [
	receiveQueue flush
]

{ #category : #private }
MicroWizProxy >> clearResponse [
	responses := OrderedCollection new
]

{ #category : #private }
MicroWizProxy >> clearSendingQueue [
	sendingQueue := OrderedCollection new
]

{ #category : #private }
MicroWizProxy >> close [
	self setIdle.
	comm ifNil: [ ^ self ].
	comm close
]

{ #category : #accessing }
MicroWizProxy >> comm [
	^ comm
]

{ #category : #accessing }
MicroWizProxy >> comm: aComm [
	comm := aComm.
	receiveQueue comm: comm
]

{ #category : #accessing }
MicroWizProxy >> commOption: aString to: anObject [
	comm ifNil: [ ^ self ].
	comm setOption: aString to: anObject
]

{ #category : #accessing }
MicroWizProxy >> commOptions [
	comm ifNil: [ ^ #() ].
	^ comm options
]

{ #category : #accessing }
MicroWizProxy >> commOptionsNamed: aSymbol [
	comm ifNil: [ ^ #() ].
	^ comm optionsNamed: aSymbol
]

{ #category : #private }
MicroWizProxy >> defaultTimeout [
	^ 100
]

{ #category : #api }
MicroWizProxy >> evaluate: aString [
	self sendCommand: aString asByteArray , #[13]
]

{ #category : #api }
MicroWizProxy >> evaluate: aString timeout: anInteger [
	self execute: aString.
	self updateLastMSec.
	[ Time millisecondClockValue < (self lastMSec + anInteger) ]
		whileTrue: [ self step.
			self isConnected
				ifFalse: [ ^ nil ].
			self isReady
				ifTrue: [ ^ self evaluatedString ].
			(Delay forMilliseconds: 100) wait ].
	self error: 'timeout'
]

{ #category : #api }
MicroWizProxy >> execute: aString [
	self isConnected ifFalse: [ ^ self ].
	sendingQueue addAll: aString lines
]

{ #category : #private }
MicroWizProxy >> get [
	^ receiveQueue get
]

{ #category : #testing }
MicroWizProxy >> hasPrompts: aString [
	^ false
]

{ #category : #api }
MicroWizProxy >> icon [
	self subclassResponsibility
]

{ #category : #initialization }
MicroWizProxy >> initialize [
	self setIdle.
	receiveQueue := CommQueue new
		delimiter: self class delimiter;
		timeout: self defaultTimeout;
		yourself.
	self clearSendingQueue.
	self clearResponse
]

{ #category : #testing }
MicroWizProxy >> isConnected [
	comm ifNil: [ ^ false ].
	^ comm isConnected
]

{ #category : #testing }
MicroWizProxy >> isIdle [
	^ self status = #idle
]

{ #category : #testing }
MicroWizProxy >> isPastePrompted [
	^ self status = #pastePrompted
]

{ #category : #testing }
MicroWizProxy >> isPing [
	^ self status = #ping
]

{ #category : #testing }
MicroWizProxy >> isPromptResponse: aByteArray [
	^ false
]

{ #category : #testing }
MicroWizProxy >> isPrompted [
	^ self status = #prompted
]

{ #category : #testing }
MicroWizProxy >> isReady [
	^ self status = #ready
]

{ #category : #testing }
MicroWizProxy >> isRunning [
	^ self isConnected and: [ self isPrompted not ]
]

{ #category : #testing }
MicroWizProxy >> isWaiting [
	^ self status = #waiting
]

{ #category : #accessing }
MicroWizProxy >> lastMSec [
	^ lastMSec
]

{ #category : #api }
MicroWizProxy >> newBlockSpecs [
	self subclassResponsibility
]

{ #category : #api }
MicroWizProxy >> newCode [
	self subclassResponsibility
]

{ #category : #accessing }
MicroWizProxy >> newProcess [
	^ self processClass new
		proxy: self;
		yourself
]

{ #category : #private }
MicroWizProxy >> open [
	| ret |
	ret := comm open.
	ret ifFalse: [ ^ false ].
	self clearResponse.
	self clearSendingQueue.
	self clearReceiveQueue.
	self setPing.
	^ true
]

{ #category : #private }
MicroWizProxy >> processClass [
	^ MicroWizProcess
]

{ #category : #private }
MicroWizProxy >> processSendingQueue [
	"self subclassResponsibility"
]

{ #category : #private }
MicroWizProxy >> put: aByteArray [
	comm put: aByteArray.
	self setWaiting
]

{ #category : #testing }
MicroWizProxy >> readyToSend [
	^ (self isConnected and: [ self isPrompted ])
]

{ #category : #private }
MicroWizProxy >> receiveQueue [
	^ receiveQueue
]

{ #category : #api }
MicroWizProxy >> removePrompts: aString [
	self subclassResponsibility
]

{ #category : #accessing }
MicroWizProxy >> response [
	| stream |
	stream := WriteStream on: ByteArray new.
	responses do: [ :each | stream nextPutAll: each ].
	self clearResponse.
	^ stream contents
]

{ #category : #accessing }
MicroWizProxy >> responseString [
	^ self response asString
]

{ #category : #private }
MicroWizProxy >> responses [
	^ responses
]

{ #category : #api }
MicroWizProxy >> sendBreak [
	"do nothing"
]

{ #category : #private }
MicroWizProxy >> sendCommand: aByteArray [
	self isConnected ifFalse: [ ^ self ].
	self clearReceiveQueue.
	self put: aByteArray
]

{ #category : #api }
MicroWizProxy >> sendPing [
	"do nothing"
]

{ #category : #api }
MicroWizProxy >> sendReboot [
	"do nothing"
]

{ #category : #private }
MicroWizProxy >> sendingQueue [
	^ sendingQueue
]

{ #category : #private }
MicroWizProxy >> setIdle [
	self status: #idle
]

{ #category : #private }
MicroWizProxy >> setPastePrompted [
	self status: #pastePrompted
]

{ #category : #private }
MicroWizProxy >> setPing [
	self status: #ping
]

{ #category : #private }
MicroWizProxy >> setPrompted [
	self status: #prompted
]

{ #category : #private }
MicroWizProxy >> setReady [
	self status: #ready
]

{ #category : #private }
MicroWizProxy >> setWaiting [
	self status: #waiting
]

{ #category : #private }
MicroWizProxy >> status [
	^ status
]

{ #category : #private }
MicroWizProxy >> status: aSymbol [
	status := aSymbol
]

{ #category : #accessing }
MicroWizProxy >> step [
	| ret |
	[ ret := self get.
	ret notNil ]
		whileTrue: [ self addResponse: ret.
			self updateLastMSec ].
	self isPing
		ifTrue: [ self sendPing ].
	self
		updateStatus;
		processSendingQueue
]

{ #category : #private }
MicroWizProxy >> updateLastMSec [
	lastMSec := Time millisecondClockValue
]

{ #category : #private }
MicroWizProxy >> updateStatus [
	| last |
	self isReady
		ifTrue: [ self setPrompted ].
	responses isEmpty
		ifTrue: [ ^ self ].
	last := responses last.
	(self isPromptResponse: last)
		ifTrue: [ ^ self setReady ]
]
