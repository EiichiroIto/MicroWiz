Class {
	#name : #MicroPythonProxy,
	#superclass : #Object,
	#instVars : [
		'comm',
		'receiveQueue',
		'responses',
		'status',
		'sendingQueue',
		'lastMSec'
	],
	#category : #'MicroWiz-MPython'
}

{ #category : #constants }
MicroPythonProxy class >> breakRequest [
	^ #[3]
]

{ #category : #constants }
MicroPythonProxy class >> crRequest [
	^ #[13]
]

{ #category : #constants }
MicroPythonProxy class >> delimiter [
	^ 10
]

{ #category : #constants }
MicroPythonProxy class >> pasteRequest [
	^ #[5]
]

{ #category : #constants }
MicroPythonProxy class >> pasteResponse [
	^ '=== ' asByteArray
]

{ #category : #constants }
MicroPythonProxy class >> promptResponse [
	^ '>>> ' asByteArray
]

{ #category : #constants }
MicroPythonProxy class >> quitPasteRequest [
	^ #[4]
]

{ #category : #constants }
MicroPythonProxy class >> rebootRequest [
	^ #[4]
]

{ #category : #private }
MicroPythonProxy >> addResponse: aCollection [
	responses add: aCollection
]

{ #category : #private }
MicroPythonProxy >> clearReceiveQueue [
	receiveQueue flush
]

{ #category : #private }
MicroPythonProxy >> clearResponse [
	responses := OrderedCollection new
]

{ #category : #private }
MicroPythonProxy >> clearSendingQueue [
	sendingQueue := OrderedCollection new
]

{ #category : #private }
MicroPythonProxy >> close [
	self setIdle.
	comm ifNil: [ ^ self ].
	comm close
]

{ #category : #accessing }
MicroPythonProxy >> comm [
	^ comm
]

{ #category : #accessing }
MicroPythonProxy >> comm: aComm [
	comm := aComm.
	receiveQueue comm: comm
]

{ #category : #accessing }
MicroPythonProxy >> commOption: aString to: anObject [
	comm ifNil: [ ^ self ].
	comm setOption: aString to: anObject
]

{ #category : #accessing }
MicroPythonProxy >> commOptions [
	comm ifNil: [ ^ #() ].
	^ comm options
]

{ #category : #accessing }
MicroPythonProxy >> commOptionsNamed: aSymbol [
	comm ifNil: [ ^ #() ].
	^ comm optionsNamed: aSymbol
]

{ #category : #private }
MicroPythonProxy >> defaultTimeout [
	^ 100
]

{ #category : #api }
MicroPythonProxy >> deleteFileNamed: aString [
	self execute: 'os.remove(''' , aString , ''')'
]

{ #category : #api }
MicroPythonProxy >> evaluate: aString [
	self sendCommand: aString asByteArray , #[13]
]

{ #category : #api }
MicroPythonProxy >> evaluate: aString timeout: anInteger [
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

{ #category : #accessing }
MicroPythonProxy >> evaluatedString [
	| str lines |
	responses isEmpty
		ifFalse: [ responses last = self class promptResponse
				ifTrue: [ responses removeLast ].
			responses size > 1
				ifTrue: [ responses removeFirst ] ].
	^ self withoutPasteResponse
]

{ #category : #api }
MicroPythonProxy >> execute: aString [
	self isConnected ifFalse: [ ^ self ].
	sendingQueue addAll: aString lines
]

{ #category : #private }
MicroPythonProxy >> get [
	^ receiveQueue get
]

{ #category : #api }
MicroPythonProxy >> getDirectory [
	| ret |
	ret := self
		evaluate: 'import os' , String lf , 'os.listdir()'
		timeout: 3000.
	ret ifNil: [ ^ nil ].
	^ MicroPythonParser new parse: ret
]

{ #category : #api }
MicroPythonProxy >> getFileNamed: aString timeout: anInteger [
	| code ret |
	code := self stringOfFileNamed: aString.
	ret := self evaluate: code timeout: anInteger.
	^ ret
]

{ #category : #api }
MicroPythonProxy >> icon [
	^ ScratchTheme formAt: #micropython
]

{ #category : #initialization }
MicroPythonProxy >> initialize [
	self setIdle.
	receiveQueue := CommQueue new
		delimiter: self class delimiter;
		timeout: self defaultTimeout;
		yourself.
	self clearSendingQueue.
	self clearResponse
]

{ #category : #testing }
MicroPythonProxy >> isConnected [
	comm ifNil: [ ^ false ].
	^ comm isConnected
]

{ #category : #testing }
MicroPythonProxy >> isIdle [
	^ status = #idle
]

{ #category : #testing }
MicroPythonProxy >> isPastePrompted [
	^ status = #pastePrompted
]

{ #category : #testing }
MicroPythonProxy >> isPing [
	^ status = #ping
]

{ #category : #testing }
MicroPythonProxy >> isPrompted [
	^ status = #prompted
]

{ #category : #testing }
MicroPythonProxy >> isReady [
	^ status = #ready
]

{ #category : #testing }
MicroPythonProxy >> isRunning [
	^ self isConnected and: [ self isPrompted not ]
]

{ #category : #testing }
MicroPythonProxy >> isWaiting [
	^ status = #waiting
]

{ #category : #accessing }
MicroPythonProxy >> lastMSec [
	^ lastMSec
]

{ #category : #api }
MicroPythonProxy >> newBlockSpecs [
	^ MicroPythonBlockSpecs new
]

{ #category : #api }
MicroPythonProxy >> newCode [
	^ MicroPythonCode new
		generator: MicroPythonGenerator new;
		yourself
]

{ #category : #accessing }
MicroPythonProxy >> newProcess [
	^ self processClass new
		proxy: self;
		yourself
]

{ #category : #private }
MicroPythonProxy >> open [
	| ret |
	ret := comm open.
	ret ifFalse: [ ^ false ].
	self clearResponse.
	self clearSendingQueue.
	self clearReceiveQueue.
	self setPing.
	^ true
]

{ #category : #accessing }
MicroPythonProxy >> processClass [
	^ MicroPythonProcess
]

{ #category : #private }
MicroPythonProxy >> processSendingQueue [
	self isPastePrompted
		ifTrue: [ self
				sendCommand:
					(sendingQueue isEmpty
						ifTrue: [ self class quitPasteRequest ]
						ifFalse: [ sendingQueue removeFirst asByteArray , self class crRequest ]).
			^ self ].
	self isPrompted
		ifFalse: [ ^ self ].
	sendingQueue isEmpty
		ifTrue: [ ^ self ].
	self sendCommand: self class pasteRequest
]

{ #category : #private }
MicroPythonProxy >> put: aByteArray [
	comm put: aByteArray.
	self setWaiting
]

{ #category : #api }
MicroPythonProxy >> putFileNamed: aString1 contents: aString2 [
	| str |
	str := self stringOfFileNamed: aString1 contents: aString2.
	self execute: str
]

{ #category : #testing }
MicroPythonProxy >> readyToSend [
	^ (self isConnected and: [ self isPrompted ])
]

{ #category : #private }
MicroPythonProxy >> receiveQueue [
	^ receiveQueue
]

{ #category : #accessing }
MicroPythonProxy >> response [
	| stream |
	stream := WriteStream on: ByteArray new.
	responses do: [ :each | stream nextPutAll: each ].
	self clearResponse.
	^ stream contents
]

{ #category : #accessing }
MicroPythonProxy >> responseString [
	^ self response asString
]

{ #category : #private }
MicroPythonProxy >> responses [
	^ responses
]

{ #category : #api }
MicroPythonProxy >> sendBreak [
	self sendCommand: self class breakRequest.
	self clearSendingQueue
]

{ #category : #private }
MicroPythonProxy >> sendCommand: aByteArray [
	self isConnected ifFalse: [ ^ self ].
	self clearReceiveQueue.
	self put: aByteArray
]

{ #category : #api }
MicroPythonProxy >> sendPing [
	self sendCommand: self class crRequest
]

{ #category : #api }
MicroPythonProxy >> sendReboot [
	self sendCommand: self class rebootRequest.
	self clearSendingQueue
]

{ #category : #private }
MicroPythonProxy >> sendingQueue [
	^ sendingQueue
]

{ #category : #private }
MicroPythonProxy >> setIdle [
	self status: #idle
]

{ #category : #private }
MicroPythonProxy >> setPastePrompted [
	self status: #pastePrompted
]

{ #category : #private }
MicroPythonProxy >> setPing [
	self status: #ping
]

{ #category : #private }
MicroPythonProxy >> setPrompted [
	self status: #prompted
]

{ #category : #private }
MicroPythonProxy >> setReady [
	self status: #ready
]

{ #category : #private }
MicroPythonProxy >> setWaiting [
	self status: #waiting
]

{ #category : #private }
MicroPythonProxy >> status [
	^ status
]

{ #category : #private }
MicroPythonProxy >> status: aSymbol [
	status := aSymbol
]

{ #category : #accessing }
MicroPythonProxy >> step [
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
MicroPythonProxy >> stringOfFileNamed: aString [
	| out |
	out := WriteStream on: String new.
	out
		nextPutAll: '_f=open(''';
		nextPutAll: aString;
		nextPutAll: ''',''r'')';
		nextPutAll: String lf.
	out
		nextPutAll: '_r=_f.read()';
		nextPutAll: String lf.
	out
		nextPutAll: '_f.close()';
		nextPutAll: String lf.
	out
		nextPutAll: '_r';
		nextPutAll: String lf.
	^ out contents
]

{ #category : #private }
MicroPythonProxy >> stringOfFileNamed: aFilename contents: aString [
	| stream tmp gen |
	gen := MicroPythonGenerator new.
	stream := WriteStream on: String new.
	stream
		nextPutAll: '_f=open(''';
		nextPutAll: aFilename;
		nextPutAll: ''',''w'')';
		nextPutAll: String lf.
	aString lines
		do: [ :each | 
			tmp := gen quotedString: each.
			stream
				nextPutAll: '_f.write(';
				nextPutAll: (gen quotedString: each);
				nextPutAll: '+''\n'')';
				nextPutAll: String lf ].
	stream
		nextPutAll: '_f.close()';
		nextPutAll: String lf.
	^ stream contents
]

{ #category : #private }
MicroPythonProxy >> updateLastMSec [
	lastMSec := Time millisecondClockValue
]

{ #category : #private }
MicroPythonProxy >> updateStatus [
	| last |
	self isReady
		ifTrue: [ self setPrompted ].
	responses isEmpty
		ifTrue: [ ^ self ].
	last := responses last.
	last = self class pasteResponse
		ifTrue: [ ^ self setPastePrompted ].
	last = self class promptResponse
		ifTrue: [ ^ self setReady ]
]

{ #category : #private }
MicroPythonProxy >> withoutPasteResponse [
	| str lines |
	str := self responseString.
	lines := str lines reject: [ :each | each beginsWith: '===' ].
	lines := lines reject: [ :each | each beginsWith: 'paste mode;' ].
	^ lines joinUsing: String lf
]
