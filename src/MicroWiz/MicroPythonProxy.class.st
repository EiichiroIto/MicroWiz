Class {
	#name : #MicroPythonProxy,
	#superclass : #MicroWizProxy,
	#category : #'MicroWiz-MPython'
}

{ #category : #constants }
MicroPythonProxy class >> breakRequest [
	^ #[3]
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
MicroPythonProxy class >> quitRawRequest [
	^ #[2]
]

{ #category : #constants }
MicroPythonProxy class >> rawModeResponse [
	^ '>' asByteArray
]

{ #category : #constants }
MicroPythonProxy class >> rawModeStartResponse [
	^ ('raw REPL; CTRL-B to exit' , String crlf) asByteArray
]

{ #category : #constants }
MicroPythonProxy class >> rawOK [
	^ #[4]
]

{ #category : #constants }
MicroPythonProxy class >> rawOKResponse [
	^ #[4 4 62]
]

{ #category : #constants }
MicroPythonProxy class >> rawRequest [
	^ #[1]
]

{ #category : #constants }
MicroPythonProxy class >> rebootRequest [
	^ #[4]
]

{ #category : #api }
MicroPythonProxy >> deleteFileNamed: aString [
	self execute: 'os.remove(''' , aString , ''')'
]

{ #category : #accessing }
MicroPythonProxy >> evaluatedString [
	responses isEmpty
		ifFalse: [ responses last = self class promptResponse
				ifTrue: [ responses removeLast ].
			responses size > 1
				ifTrue: [ responses removeFirst ] ].
	^ self withoutPasteResponse
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

{ #category : #testing }
MicroPythonProxy >> isPasteResponse [
	^ responses notEmpty
		and: [ responses last = self class pasteResponse ]
]

{ #category : #testing }
MicroPythonProxy >> isPromptResponse [
	^ responses notEmpty
		and: [ 	responses last = self class promptResponse ]
]

{ #category : #testing }
MicroPythonProxy >> isRawMode [
	^ self status = #rawMode
]

{ #category : #testing }
MicroPythonProxy >> isRawPrompted [
	^ self status = #rawPrompted
]

{ #category : #testing }
MicroPythonProxy >> isRawResponse [
	responses isEmpty
		ifTrue: [ ^ false ].
	self isRawMode
		ifTrue: [ ^ responses last = self class rawModeStartResponse ].
	self isRawPrompted
		ifTrue: [ ^ responses last = self class rawOKResponse ].
	^ false
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

{ #category : #private }
MicroPythonProxy >> processSendingQueue [
	self isPastePrompted
		ifTrue: [ self
				sendQueueContinue: self class crRequest
				ifEnd: [ self sendCommand: self class quitPasteRequest ].
			^ self ].
	self isRawPrompted
		ifTrue: [ self
				sendQueueContinue: self class rawOK
				ifEnd: [ ^ self sendCommand: self class quitRawRequest ].
			^ self setRawPrompted ].
	self isPrompted
		ifFalse: [ ^ self ].
	sendingQueue isEmpty
		ifTrue: [ ^ self ].
	self isRawMode
		ifTrue: [ ^ self ].
	self sendCommand: self class pasteRequest
]

{ #category : #api }
MicroPythonProxy >> putFileNamed: aString1 contents: aString2 [
	| str |
	self isConnected ifFalse: [ ^ self ].
	str := self stringOfFileNamed: aString1 contents: aString2.
	sendingQueue addAll: str lines.
	self sendCommand: self class rawRequest.
	self setRawMode
]

{ #category : #private }
MicroPythonProxy >> quotedString: aString [ 
	| in out c |
	in := ReadStream on: aString.
	out := WriteStream on: String new.
	out nextPut: $'.
	[in atEnd]
		whileFalse: 
			[c := in next.
			('\''' includes: c)
				ifTrue: [out nextPut: $\].
			out nextPut: c].
	out nextPut: $'.
	^ out contents
]

{ #category : #api }
MicroPythonProxy >> removePrompts: aString [
	| line |
	line := aString.
	line := line withoutPrefix: self class promptResponse asString.
	line := line withoutPrefix: self class pasteResponse asString.
	^ line
]

{ #category : #api }
MicroPythonProxy >> sendBreak [
	self sendCommand: self class breakRequest.
	self clearSendingQueue
]

{ #category : #api }
MicroPythonProxy >> sendPing [
	self sendCommand: self class crRequest
]

{ #category : #private }
MicroPythonProxy >> sendQueueContinue: aByteArray ifEnd: aBlock [
	sendingQueue isEmpty
		ifTrue: [ ^ aBlock value ].
	self sendCommand: sendingQueue removeFirst asByteArray , aByteArray
]

{ #category : #api }
MicroPythonProxy >> sendReboot [
	self sendCommand: self class rebootRequest.
	self clearSendingQueue
]

{ #category : #private }
MicroPythonProxy >> setRawMode [
	self status: #rawMode
]

{ #category : #private }
MicroPythonProxy >> setRawPrompted [
	self status: #rawPrompted
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
	| stream |
	stream := WriteStream on: String new.
	stream
		nextPutAll: '_f=open(''';
		nextPutAll: aFilename;
		nextPutAll: ''',''w'')';
		nextPutAll: String lf.
	aString lines
		do: [ :each | 
			stream
				nextPutAll: '_=_f.write(';
				nextPutAll: (self quotedString: each);
				nextPutAll: '+''\n'')';
				nextPutAll: String lf ].
	stream
		nextPutAll: '_f.close()';
		nextPutAll: String lf.
	^ stream contents
]

{ #category : #private }
MicroPythonProxy >> updateStatus [
	self isReady
		ifTrue: [ self setPrompted ].
	self isRawResponse
		ifTrue: [ ^ self setRawPrompted ].
	self isPasteResponse
		ifTrue: [ ^ self setPastePrompted ].
	self isPromptResponse
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
