Class {
	#name : #WebReplComm,
	#superclass : #MWComm,
	#instVars : [
		'address',
		'response',
		'buffer',
		'socket'
	],
	#category : #'MicroWiz-Comm'
}

{ #category : #accessing }
WebReplComm >> address [
	^ address
]

{ #category : #accessing }
WebReplComm >> address: aString [
	address := aString
]

{ #category : #accessing }
WebReplComm >> buffer [
	^ buffer
]

{ #category : #accessing }
WebReplComm >> buffer: aByteArray [
	buffer := aByteArray
]

{ #category : #accessing }
WebReplComm >> clear [
	buffer := ByteArray new.
	response := nil
]

{ #category : #private }
WebReplComm >> clientRequestHeader [
	^ ('GET / HTTP/1.1
Host: echo.websocket.org
Connection: Upgrade
Upgrade: websocket
Sec-WebSocket-Key: foo

' copyReplaceAll: String cr with: String crlf) asByteArray
]

{ #category : #api }
WebReplComm >> close [
	socket ifNil: [ ^ self ].
	socket closeAndDestroy.
	socket := nil
]

{ #category : #private }
WebReplComm >> dataFromFrame: anArray [
	anArray first = 16r82
		ifTrue: [ ^ anArray second ].
	anArray first = 16r81
		ifTrue: [ ^ anArray second asString ].
	^ nil
]

{ #category : #private }
WebReplComm >> defaultAddress [
	| ret |
	ret := UIManager default
		request: 'Enter ESP8266 ip address'
		initialAnswer: ''.
	(ret isNil or: [ ret isEmpty ])
		ifTrue: [ ^ #() ].
	^ Array with: ret
]

{ #category : #api }
WebReplComm >> get [
	| frame |
	self isConnected
		ifFalse: [ ^ nil ].
	frame := self retrieveDataFrame.
	(frame isNil and: [ socket dataAvailable ])
		ifTrue: [ buffer := socket receiveData asByteArray.
			frame := self retrieveDataFrame ].
	frame ifNil: [ ^ nil ].
	^ (self dataFromFrame: frame) asByteArray
]

{ #category : #api }
WebReplComm >> isConnected [
	^ socket notNil and: [ socket isConnected ]
]

{ #category : #private }
WebReplComm >> makeHeaderSize: anInteger [
	^ anInteger < 126
		ifTrue: [ ByteArray with: 16r81 with: anInteger ]
		ifFalse: [ ByteArray
				with: 16r81
				with: 126
				with: anInteger // 256
				with: anInteger \\ 256 ]
]

{ #category : #api }
WebReplComm >> open [
	| s ret pass |
	self isConnected
		ifTrue: [ ^ false ].
	self close.
	self clear.
	s := Socket newTCP.
	[ s
		connectTo: (NetNameResolver addressFromString: self address)
		port: self webReplPortNo.
	s isConnected
		ifFalse: [ ^ false ].
	s sendData: self clientRequestHeader.
	(Delay forMilliseconds: 100) wait.
	s dataAvailable
		ifFalse: [ self error: 'invalid server' ].
	self parseServerResponse: s receiveData.
	response ifNil: [ self error: 'invalid response' ] ]
		on: Error
		do: [ :err | 
			self inform: err asString.
			s closeAndDestroy.
			^ false ].
	socket := s.
	ret := self get asString.
	ret = 'Password: '
		ifFalse: [ self close.
			self inform: 'invalid response2'.
			^ false ].
	pass := self userPassword.
	pass
		ifNil: [ self close.
			^ false ].
	self put: pass , String cr.	""
	^ true
]

{ #category : #accessing }
WebReplComm >> options [
	^ #(portName)
]

{ #category : #accessing }
WebReplComm >> optionsNamed: aSymbol [
	aSymbol = #portName
		ifTrue: [ ^ self defaultAddress ].
	^ #()
]

{ #category : #private }
WebReplComm >> parseServerResponse: aByteString [
	| i |
	i := aByteString
		indexOfSubCollection: ByteString crlf , ByteString crlf
		startingAt: 1.
	i = 0
		ifTrue: [ ^ self ].
	buffer := (aByteString copyFrom: i + 4 to: aByteString size)
		asByteArray.
	response := (aByteString copyFrom: 1 to: i + 1)
		copyReplaceAll: String crlf
		with: String cr
]

{ #category : #api }
WebReplComm >> put: aByteArray [
	| header |
	self isConnected
		ifFalse: [ ^ self ].
	header := self makeHeaderSize: aByteArray size.
	socket
		sendData: header;
		sendData: aByteArray
]

{ #category : #accessing }
WebReplComm >> response [
	^ response
]

{ #category : #accessing }
WebReplComm >> response: aString [
	response := aString
]

{ #category : #private }
WebReplComm >> retrieveDataFrame [
	| opcode size pos frame |
	(buffer isNil or: [ buffer isEmpty ])
		ifTrue: [ ^ nil ].
	opcode := buffer first.
	size := buffer second.
	pos := 3.
	size > 126
		ifTrue: [ self inform: 'not supported frame'.
			^ buffer := nil ].
	size = 126
		ifTrue: [ size := buffer third * 256 + buffer fourth.
			pos := 5 ].
	frame := buffer copyFrom: pos to: pos + size - 1.
	buffer := buffer copyFrom: pos + size to: buffer size.
	^ {opcode.
	frame}
]

{ #category : #accessing }
WebReplComm >> setOption: aString to: anObject [
	aString = #portName
		ifTrue: [ ^ self address: anObject asString ]
]

{ #category : #private }
WebReplComm >> userPassword [
	| ret |
	ret := UIManager default
		request: 'Enter password'
		initialAnswer: ''.
	(ret isNil or: [ ret isEmpty ])
		ifTrue: [ ^ nil ].
	^ ret
]

{ #category : #private }
WebReplComm >> webReplPortNo [
	^ 8266
]
