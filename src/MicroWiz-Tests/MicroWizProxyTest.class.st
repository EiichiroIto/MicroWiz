Class {
	#name : #MicroWizProxyTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroWizProxyTest >> newComm [
	^ DummyComm new
]

{ #category : #private }
MicroWizProxyTest >> newProxy [
	^ MicroWizProxy new
]

{ #category : #private }
MicroWizProxyTest >> newSerialComm [
	^ SerialComm new
]

{ #category : #test }
MicroWizProxyTest >> testAddResponse [
	| p |
	p := self newProxy.
	self assert: p responses isCollection.
	self assert: p responses isEmpty.
	p addResponse: #[1 2 3].
	p addResponse: #[4 5 6].
	self assert: p responses isCollection.
	self assert: p responses size equals: 2.
	self assertCollection: p responses first equals: #[1 2 3].
	self assertCollection: p responses second equals: #[4 5 6]
]

{ #category : #test }
MicroWizProxyTest >> testClearReceiveQueue [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	p open.
	c addGetQueue: #[1 2 3 10].
	c addGetQueue: #[4 5 6 10].
	p clearReceiveQueue.
	self assert: p get isNil.
	p close
]

{ #category : #test }
MicroWizProxyTest >> testClearResponse [
	| p |
	p := self newProxy.
	self assert: p responses isEmpty.
	p addResponse: #[1 2 3].
	self deny: p responses isEmpty.
	p clearResponse.
	self assert: p responses isEmpty
]

{ #category : #test }
MicroWizProxyTest >> testClearSendingQueue [
	| p |
	p := self newProxy.
	self assert: p sendingQueue isEmpty.
	p sendingQueue add: 'abc'.
	self deny: p sendingQueue isEmpty.
	p clearSendingQueue.
	self assert: p sendingQueue isEmpty
]

{ #category : #test }
MicroWizProxyTest >> testClose [
	| p c |
	p := self newProxy.
	c := self newComm.
	self assert: p status equals: #idle.
	p comm: c.
	p open.
	self assert: p status equals: #ping.
	self assert: p isConnected.
	p close.
	self assert: p status equals: #idle.
	self deny: p isConnected
]

{ #category : #test }
MicroWizProxyTest >> testComm [
	| p c |
	p := self newProxy.
	self assert: p comm isNil.
	c := self newComm.
	p comm: c.
	self assert: p comm equals: c
]

{ #category : #test }
MicroWizProxyTest >> testCommOptionTo [
	| p c |
	p := self newProxy.
	c := self newSerialComm.
	p comm: c.
	self assert: c portName isNil.
	p commOption: #portName to: 'abc'.
	self assert: c portName equals: 'abc'.
	self assert: c baudRate equals: c defaultBaudRate.
	p commOption: #baudRate to: '9600'.
	self assert: c baudRate equals: 9600
]

{ #category : #test }
MicroWizProxyTest >> testCommOptions [
	| p c |
	p := self newProxy.
	c := self newSerialComm.
	p comm: c.
	self assert: p commOptions isCollection.
	self assert: (p commOptions includes: #portName).
	self assert: (p commOptions includes: #baudRate)
]

{ #category : #test }
MicroWizProxyTest >> testCommOptionsNamed [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	self assert: (p commOptionsNamed: #dummy) isCollection.
	self assert: (p commOptionsNamed: #portName) isCollection.
	self assert: (p commOptionsNamed: #baudRate) isCollection.
	self assert: (p commOptionsNamed: #baudRate) notEmpty
]

{ #category : #test }
MicroWizProxyTest >> testDefaultTimeout [
	| p |
	p := self newProxy.
	self assert: p defaultTimeout isInteger
]

{ #category : #test }
MicroWizProxyTest >> testEvaluate [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	p open.
	p evaluate: '1+2'.
	self assert: c putQueue size equals: 1.
	self assertCollection: c putQueue first equals: #[49 43 50 13]
]

{ #category : #test }
MicroWizProxyTest >> testExecute [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c isConnected: false.
	self assert: p sendingQueue isEmpty.
	p execute: 'abc', String cr, 'def'.
	self assert: p sendingQueue isEmpty.
	c isConnected: true.
	p execute: 'abc', String cr, 'def'.
	self assert: p sendingQueue size equals: 2.
	self assert: p sendingQueue first equals: 'abc'.
	self assert: p sendingQueue second equals: 'def'
]

{ #category : #test }
MicroWizProxyTest >> testGet [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	p open.
	c addGetQueue: #[1 2 3 10].
	c addGetQueue: #[4 5 6 10].
	self assertCollection: p get equals: #[1 2 3 10].
	self assertCollection: p get equals: #[4 5 6 10].
	self assert: p get isNil.
	p close
]

{ #category : #test }
MicroWizProxyTest >> testInitialize [
	| p |
	p := self newProxy.
	self assert: p status equals: #idle.
	self assert: (p receiveQueue isKindOf: CommQueue)
]

{ #category : #test }
MicroWizProxyTest >> testIsConnected [
	| p c |
	p := self newProxy.
	self deny: p isConnected.
	c := self newComm.
	p comm: c.
	c isConnected: true.
	self assert: p isConnected.
	c isConnected: false.
	self deny: p isConnected
]

{ #category : #test }
MicroWizProxyTest >> testIsIdle [
	| p |
	p := self newProxy.
	self assert: p isIdle.
	p setReady.
	self deny: p isIdle.
	p setIdle.
	self assert: p isIdle
]

{ #category : #test }
MicroWizProxyTest >> testIsPastePrompted [
	| p |
	p := self newProxy.
	self deny: p isPastePrompted.
	p setPastePrompted.
	self assert: p isPastePrompted
]

{ #category : #test }
MicroWizProxyTest >> testIsPing [
	| p |
	p := self newProxy.
	self deny: p isPing.
	p setPing.
	self assert: p isPing
]

{ #category : #test }
MicroWizProxyTest >> testIsPrompted [
	| p |
	p := self newProxy.
	self deny: p isPrompted.
	p setPrompted.
	self assert: p isPrompted
]

{ #category : #test }
MicroWizProxyTest >> testIsReady [
	| p |
	p := self newProxy.
	self deny: p isReady.
	p setReady.
	self assert: p isReady
]

{ #category : #test }
MicroWizProxyTest >> testIsWaiting [
	| p |
	p := self newProxy.
	self deny: p isWaiting.
	p setWaiting.
	self assert: p isWaiting
]

{ #category : #test }
MicroWizProxyTest >> testLastMSec [
	| p |
	p := self newProxy.
	self assert: p lastMSec isNil.
	p updateLastMSec.
	self assert: p lastMSec <= Time millisecondClockValue.
	1 milliSeconds wait.
	self assert: p lastMSec < Time millisecondClockValue
]

{ #category : #test }
MicroWizProxyTest >> testNewProcess [
	| p process |
	p := self newProxy.
	process := p newProcess.
	self assert: (process isKindOf: p processClass).
	self assert: process proxy equals: p
]

{ #category : #test }
MicroWizProxyTest >> testOpen [
	| p c |
	p := self newProxy.
	c := self newComm.
	self assert: p status equals: #idle.
	p comm: c.
	p open.
	self assert: p status equals: #ping.
	self assert: p isConnected.
	p close
]

{ #category : #test }
MicroWizProxyTest >> testProcessClass [
	| p |
	p := self newProxy.
	self assert: p processClass isClass
]

{ #category : #test }
MicroWizProxyTest >> testPut [
	| p c |
	p := self newProxy.
	c := self newComm.
	self assert: p status equals: #idle.
	p comm: c.
	p open.
	p status: #test.
	p put: #[1 2 3].
	p put: #[4 5 6].
	self assert: p status equals: #waiting.
	self assert: p comm putQueue size equals: 2.
	self assertCollection: p comm putQueue first equals: #[1 2 3].
	self assertCollection: p comm putQueue second equals: #[4 5 6].
	p close
]

{ #category : #test }
MicroWizProxyTest >> testReadyToSend [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c isConnected: false.
	self deny: p readyToSend.
	c isConnected: true.
	p setWaiting.
	self deny: p readyToSend.
	p setPrompted.
	self assert: p readyToSend
]

{ #category : #test }
MicroWizProxyTest >> testReceiveQueue [
	| p |
	p := self newProxy.
	self assert: (p receiveQueue isKindOf: CommQueue)
]

{ #category : #test }
MicroWizProxyTest >> testResponse [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c addGetQueue: #[1 2 3 10].
	c addGetQueue: #[4 5 6 10].
	p step.
	self assert: p isIdle.
	self assertCollection: p response equals: #[1 2 3 10 4 5 6 10].
	self assert: p isIdle
]

{ #category : #test }
MicroWizProxyTest >> testResponseString [
	| p c |
	p := self newProxy.
	self assert: p responseString isEmpty.
	c := self newComm.
	p comm: c.
	c addGetQueue: #[48 49 50 10].
	c addGetQueue: #[65 66 67 10].
	p step.
	self
		assertCollection: p responseString
		equals: '012' , String lf , 'ABC' , String lf
]

{ #category : #test }
MicroWizProxyTest >> testResponses [
	| p |
	p := self newProxy.
	self assert: p responses isCollection.
	self assert: p responses isEmpty
]

{ #category : #test }
MicroWizProxyTest >> testSendCommand [
	| p |
	p := self newProxy.
	p comm: self newComm.
	p close.
	p sendCommand: #[1 2 3].
	self assert: p comm putQueue isEmpty.
	p open.
	p comm addGetQueue: #[10 11].
	self deny: p comm getQueue isEmpty.
	p sendCommand: #[4 5 6].
	self assert: p comm putQueue size equals: 1.
	self assertCollection: p comm putQueue first equals: #[4 5 6].
	self assert: p comm getQueue isEmpty
]

{ #category : #test }
MicroWizProxyTest >> testSendingQueue [
	| p |
	p := self newProxy.
	self assert: p sendingQueue isCollection
]

{ #category : #test }
MicroWizProxyTest >> testSetIdle [
	self testIsIdle
]

{ #category : #test }
MicroWizProxyTest >> testSetPastePrompted [
	self testIsPastePrompted
]

{ #category : #test }
MicroWizProxyTest >> testSetPing [
	self testIsPing
]

{ #category : #test }
MicroWizProxyTest >> testSetPrompted [
	self testIsPrompted
]

{ #category : #test }
MicroWizProxyTest >> testSetReady [
	self testIsReady
]

{ #category : #test }
MicroWizProxyTest >> testSetWaiting [
	self testIsWaiting
]

{ #category : #test }
MicroWizProxyTest >> testStatus [
	| p |
	p := self newProxy.
	self assert: p status equals: #idle.
	p status: #waiting.
	self assert: p status equals: #waiting.
	p status: #ready.
	self assert: p status equals: #ready
]

{ #category : #test }
MicroWizProxyTest >> testUpdateLastMSec [
	self testLastMSec
]
