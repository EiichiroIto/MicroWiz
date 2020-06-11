"
A WebReplCommTest is a test class for testing the behavior of WebReplComm
"
Class {
	#name : #WebReplCommTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
WebReplCommTest >> newComm [
	^ WebReplComm new
]

{ #category : #private }
WebReplCommTest >> sampleFrame1 [
	^ {129.
	#[80 97 115 115 119 111 114 100 58 32]}
]

{ #category : #private }
WebReplCommTest >> sampleResponse1 [
	^ #[72 84 84 80 47 49 46 49 32 49 48 49 32 83 119 105 116 99 104 105 110 103 32 80 114 111 116 111 99 111 108 115 13 10 85 112 103 114 97 100 101 58 32 119 101 98 115 111 99 107 101 116 13 10 67 111 110 110 101 99 116 105 111 110 58 32 85 112 103 114 97 100 101 13 10 83 101 99 45 87 101 98 83 111 99 107 101 116 45 65 99 99 101 112 116 58 32 66 77 48 83 48 43 103 104 102 116 83 104 117 70 86 72 81 65 84 75 47 68 66 105 74 113 56 61 13 10 13 10 129 10 80 97 115 115 119 111 114 100 58 32]
		asString asByteString
]

{ #category : #test }
WebReplCommTest >> testAddress [
	| c |
	c := self newComm.
	self assert: c address isNil.
	c address: '1.2.3.4'.
	self assert: c address equals: '1.2.3.4'.
	c address: '5.6.7.8'.
	self assert: c address equals: '5.6.7.8'
]

{ #category : #test }
WebReplCommTest >> testBuffer [
	| c |
	c := self newComm.
	self assert: c buffer isNil.
	c clear.
	self assert: (c buffer isKindOf: ByteArray).
	self assert: c buffer isEmpty.
	c buffer: #[1 2 3].
	self assert: c buffer equals: #[1 2 3].
	c buffer: #[4 5 6].
	self assert: c buffer equals: #[4 5 6]
]

{ #category : #test }
WebReplCommTest >> testClear [
	| c |
	c := self newComm.
	self assert: c buffer isNil.
	self assert: c response isNil.
	c clear.
	self assert: (c buffer isKindOf: ByteArray).
	self assert: c buffer isEmpty.
	self assert: c response isNil.
]

{ #category : #test }
WebReplCommTest >> testClientRequestHeader [
	| c |
	c := self newComm.
	self assert: (c clientRequestHeader isKindOf: ByteArray)
]

{ #category : #test }
WebReplCommTest >> testDataFromFrame [
	| c ret |
	c := self newComm.
	ret := c dataFromFrame: self sampleFrame1.
	self assert: ret equals: 'Password: '
]

{ #category : #test }
WebReplCommTest >> testMakeHeaderSize [
	| ws |
	ws := self newComm.
	self
		assertCollection: (ws makeHeaderSize: 10)
		equals: (ByteArray with: 16r82 with: 10).
	self
		assertCollection: (ws makeHeaderSize: 200)
		equals:
			(ByteArray
				with: 16r82
				with: 126
				with: 0
				with: 200).
	self
		assertCollection: (ws makeHeaderSize: 300)
		equals:
			(ByteArray
				with: 16r82
				with: 126
				with: 1
				with: 44)
]

{ #category : #test }
WebReplCommTest >> testOptions [
	| c |
	c := self newComm.
	self assert: c options notEmpty
]

{ #category : #test }
WebReplCommTest >> testParseServerResponse [
	| c |
	c := self newComm.
	c parseServerResponse: self sampleResponse1.
	self
		assert: c response
		equals:
			'HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: BM0S0+ghftShuFVHQATK/DBiJq8=
'.
	self
		assertCollection: c buffer
		equals: #[129 10 80 97 115 115 119 111 114 100 58 32]
]

{ #category : #test }
WebReplCommTest >> testResponse [
	| c |
	c := self newComm.
	self assert: c response isNil.
	c response: 'abc'.
	self assert: c response equals: 'abc'.
	c response: 'def'.
	self assert: c response equals: 'def'
]

{ #category : #test }
WebReplCommTest >> testRetrieveDataFrame [
	| c ret |
	c := self newComm.
	c clear.
	self assert: c retrieveDataFrame isNil.
	c buffer: #[129 10 80 97 115 115 119 111 114 100 58 32].
	ret := c retrieveDataFrame.
	self assert: ret first equals: 129.
	self
		assertCollection: ret second
		equals: #[80 97 115 115 119 111 114 100 58 32]
]

{ #category : #test }
WebReplCommTest >> testSetOptionTo [
	| c |
	c := self newComm.
	self assert: c address isNil.
	c setOption: #portName to: 'abc'.
	self assert: c address equals: 'abc'
]
