"
A MicroPythonProxyTest is a test class for testing the behavior of MicroPythonProxy
"
Class {
	#name : #MicroPythonProxyTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroPythonProxyTest >> newComm [
	^ DummyComm new
]

{ #category : #private }
MicroPythonProxyTest >> newProxy [
	^ MicroPythonProxy new
]

{ #category : #private }
MicroPythonProxyTest >> newSerialComm [
	^ SerialComm new
]

{ #category : #test }
MicroPythonProxyTest >> testAddResponse [
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
MicroPythonProxyTest >> testClearReceiveQueue [
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
MicroPythonProxyTest >> testClearResponse [
	| p |
	p := self newProxy.
	self assert: p responses isEmpty.
	p addResponse: #[1 2 3].
	self deny: p responses isEmpty.
	p clearResponse.
	self assert: p responses isEmpty
]

{ #category : #test }
MicroPythonProxyTest >> testClearSendingQueue [
	| p |
	p := self newProxy.
	self assert: p sendingQueue isEmpty.
	p sendingQueue add: 'abc'.
	self deny: p sendingQueue isEmpty.
	p clearSendingQueue.
	self assert: p sendingQueue isEmpty
]

{ #category : #test }
MicroPythonProxyTest >> testClose [
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
MicroPythonProxyTest >> testComm [
	| p c |
	p := self newProxy.
	self assert: p comm isNil.
	c := self newComm.
	p comm: c.
	self assert: p comm equals: c
]

{ #category : #test }
MicroPythonProxyTest >> testCommOptionTo [
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
MicroPythonProxyTest >> testCommOptions [
	| p c |
	p := self newProxy.
	c := self newSerialComm.
	p comm: c.
	self assert: p commOptions isCollection.
	self assert: (p commOptions includes: #portName).
	self assert: (p commOptions includes: #baudRate)
]

{ #category : #test }
MicroPythonProxyTest >> testCommOptionsNamed [
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
MicroPythonProxyTest >> testDefaultTimeout [
	| p |
	p := self newProxy.
	self assert: p defaultTimeout isInteger
]

{ #category : #test }
MicroPythonProxyTest >> testDeleteFileNamed [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c isConnected: true.
	p deleteFileNamed: 'abc'.
	self
		assert: p sendingQueue first
		equals: 'os.remove(''abc'')'
]

{ #category : #test }
MicroPythonProxyTest >> testEvaluate [
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
MicroPythonProxyTest >> testEvaluatedString [
	| p ret |
	p := self newProxy.
	self assert: p evaluatedString isEmpty.
	p
		addResponse: ('1 + 2' , String crlf) asByteArray;
		addResponse: ('3' , String crlf) asByteArray;
		addResponse: '>>> ' asByteArray.
	ret := p evaluatedString.
	self assert: ret equals: '3'
]

{ #category : #test }
MicroPythonProxyTest >> testExecute [
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
MicroPythonProxyTest >> testGet [
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
MicroPythonProxyTest >> testInitialize [
	| p |
	p := self newProxy.
	self assert: p status equals: #idle.
	self assert: (p receiveQueue isKindOf: CommQueue)
]

{ #category : #test }
MicroPythonProxyTest >> testIsConnected [
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
MicroPythonProxyTest >> testIsIdle [
	| p |
	p := self newProxy.
	self assert: p isIdle.
	p setReady.
	self deny: p isIdle.
	p setIdle.
	self assert: p isIdle
]

{ #category : #test }
MicroPythonProxyTest >> testIsPastePrompted [
	| p |
	p := self newProxy.
	self deny: p isPastePrompted.
	p setPastePrompted.
	self assert: p isPastePrompted
]

{ #category : #test }
MicroPythonProxyTest >> testIsPing [
	| p |
	p := self newProxy.
	self deny: p isPing.
	p setPing.
	self assert: p isPing
]

{ #category : #test }
MicroPythonProxyTest >> testIsPrompted [
	| p |
	p := self newProxy.
	self deny: p isPrompted.
	p setPrompted.
	self assert: p isPrompted
]

{ #category : #test }
MicroPythonProxyTest >> testIsReady [
	| p |
	p := self newProxy.
	self deny: p isReady.
	p setReady.
	self assert: p isReady
]

{ #category : #test }
MicroPythonProxyTest >> testIsWaiting [
	| p |
	p := self newProxy.
	self deny: p isWaiting.
	p setWaiting.
	self assert: p isWaiting
]

{ #category : #test }
MicroPythonProxyTest >> testLastMSec [
	| p |
	p := self newProxy.
	self assert: p lastMSec isNil.
	p updateLastMSec.
	self assert: p lastMSec <= Time millisecondClockValue.
	1 milliSeconds wait.
	self assert: p lastMSec < Time millisecondClockValue
]

{ #category : #test }
MicroPythonProxyTest >> testNewProcess [
	| p process |
	p := self newProxy.
	process := p newProcess.
	self assert: (process isKindOf: p processClass).
	self assert: process proxy equals: p
]

{ #category : #test }
MicroPythonProxyTest >> testOpen [
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
MicroPythonProxyTest >> testProcessClass [
	| p |
	p := self newProxy.
	self assert: p processClass isClass
]

{ #category : #test }
MicroPythonProxyTest >> testProcessSendingQueue [
	| p c |
	p := self newProxy.
	c := self newComm.
	c isConnected: true.
	p comm: c.
	p setPrompted.
	p execute: 'abc'.
	self assert: c putQueue size equals: 0.
	p processSendingQueue.
	self assert: c putQueue size equals: 1.
	self assertCollection: c putQueue first equals: p class pasteRequest.
	self assert: p sendingQueue notEmpty.
	self assert: p isWaiting.
	p setPastePrompted.
	p processSendingQueue.
	self assert: c putQueue size equals: 2.
	self assertCollection: c putQueue second equals: #[97 98 99 13].
	self assert: p sendingQueue isEmpty.
	self assert: p isWaiting.
	p setPastePrompted.
	p processSendingQueue.
	self assert: c putQueue size equals: 3.
	self assertCollection: c putQueue third equals: p class quitPasteRequest.
	self assert: p sendingQueue isEmpty.
	self assert: p isWaiting
]

{ #category : #test }
MicroPythonProxyTest >> testPut [
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
MicroPythonProxyTest >> testPutFileNamedContents [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c isConnected: true.
	p putFileNamed: 'abc' contents: 'def'.
	self assert: p sendingQueue first equals: '_f=open(''abc'',''w'')'.
	self assert: p sendingQueue second equals: '_=_f.write(''def''+''\n'')'.
	self assert: p sendingQueue third equals: '_f.close()'
]

{ #category : #test }
MicroPythonProxyTest >> testQuotedString [
	| g |
	g := self newProxy.
	self assert: (g quotedString: 'abc') equals: '''abc'''.
	self assert: (g quotedString: 'ab''c') equals: '''ab\''c'''.
	self assert: (g quotedString: 'ab\c') equals: '''ab\\c'''
]

{ #category : #test }
MicroPythonProxyTest >> testReadyToSend [
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
MicroPythonProxyTest >> testReceiveQueue [
	| p |
	p := self newProxy.
	self assert: (p receiveQueue isKindOf: CommQueue)
]

{ #category : #test }
MicroPythonProxyTest >> testResponse [
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
MicroPythonProxyTest >> testResponseString [
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
MicroPythonProxyTest >> testResponses [
	| p |
	p := self newProxy.
	self assert: p responses isCollection.
	self assert: p responses isEmpty
]

{ #category : #test }
MicroPythonProxyTest >> testSendBreak [
	| p |
	p := self newProxy.
	p comm: self newComm.
	p close.
	p sendBreak.
	self assert: p comm putQueue isEmpty.
	self assert: p status equals: #idle.
	p open.
	self assert: p status equals: #ping.
	p sendBreak.
	self assert: p comm putQueue size equals: 1.
	self assertCollection: p comm putQueue first equals: #[3].
	self assert: p status equals: #waiting.
	p comm addGetQueue: #[62 62 62 32].
	p step.
	0.5 asSeconds wait.
	p step.
	self assert: p status equals: #ready.
	p response.
	p step.
	self assert: p status equals: #prompted
]

{ #category : #test }
MicroPythonProxyTest >> testSendCommand [
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
MicroPythonProxyTest >> testSendPing [
	| p |
	p := self newProxy.
	p comm: self newComm.
	p open.
	self assert: p status equals: #ping.
	p sendPing.
	self assert: p comm putQueue size equals: 1.
	self assertCollection: p comm putQueue first equals: #[13].
	self assert: p status equals: #waiting.
	p comm addGetQueue: #[62 62 62 32].
	p step.
	0.3 asSeconds wait.
	p step.
	self assert: p status equals: #ready.
	p response.
	p step.
	self assert: p status equals: #prompted
]

{ #category : #test }
MicroPythonProxyTest >> testSendReboot [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	p comm isConnected: false.
	p sendReboot.
	self assert: p comm putQueue isEmpty.
	c addGetQueue: #[1 2 3].
	p comm isConnected: true.
	p sendReboot.
	self assert: p comm putQueue size equals: 1.
	self assert: p comm getQueue isEmpty.
	self assertCollection: p comm putQueue first equals: #[4]
]

{ #category : #test }
MicroPythonProxyTest >> testSendingQueue [
	| p |
	p := self newProxy.
	self assert: p sendingQueue isCollection
]

{ #category : #test }
MicroPythonProxyTest >> testSetIdle [
	self testIsIdle
]

{ #category : #test }
MicroPythonProxyTest >> testSetPastePrompted [
	self testIsPastePrompted
]

{ #category : #test }
MicroPythonProxyTest >> testSetPing [
	self testIsPing
]

{ #category : #test }
MicroPythonProxyTest >> testSetPrompted [
	self testIsPrompted
]

{ #category : #test }
MicroPythonProxyTest >> testSetReady [
	self testIsReady
]

{ #category : #test }
MicroPythonProxyTest >> testSetWaiting [
	self testIsWaiting
]

{ #category : #test }
MicroPythonProxyTest >> testStatus [
	| p |
	p := self newProxy.
	self assert: p status equals: #idle.
	p status: #waiting.
	self assert: p status equals: #waiting.
	p status: #ready.
	self assert: p status equals: #ready
]

{ #category : #test }
MicroPythonProxyTest >> testStep [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c addGetQueue: #[1 2 3 10].
	c addGetQueue: #[4 5 6 10].
	c addGetQueue: #[62 62 62 32].
	self assert: p status equals: #idle.
	0.1 asSeconds wait.
	p step.
	0.1 asSeconds wait.
	p step.
	0.2 asSeconds wait.
	p step.
	self assert: p isReady
]

{ #category : #test }
MicroPythonProxyTest >> testStringOfFileNamed [
	| p |
	p := self newProxy.
	self
		assert: (p stringOfFileNamed: 'abc')
		equals:
			'_f=open(''abc'',''r'')' , String lf , '_r=_f.read()'
				, String lf , '_f.close()' , String lf
				, '_r' , String lf
]

{ #category : #test }
MicroPythonProxyTest >> testStringOfFileNamedContents [
	| p |
	p := self newProxy.
	self
		assert:
			(p
				stringOfFileNamed: 'abc'
				contents:
					'def
g''hi
j\akl')
		equals:
			'_f=open(''abc'',''w'')' , String lf , '_=_f.write(''def''+''\n'')'
				, String lf , '_=_f.write(''g\''hi''+''\n'')' , String lf
				, '_=_f.write(''j\\akl''+''\n'')' , String lf , '_f.close()' , String lf
]

{ #category : #test }
MicroPythonProxyTest >> testUpdateLastMSec [
	self testLastMSec
]

{ #category : #test }
MicroPythonProxyTest >> testUpdateStatus [
	| p |
	p := self newProxy.
	p setIdle.
	self assert: p isIdle.
	p updateStatus.
	self assert: p isIdle.
	p addResponse: 'abc'.
	p updateStatus.
	self assert: p isIdle.
	p addResponse: p class promptResponse.
	p updateStatus.
	self assert: p isReady.
	p addResponse: p class pasteResponse.
	p updateStatus.
	self assert: p isPastePrompted
]

{ #category : #test }
MicroPythonProxyTest >> testWithoutPasteResponse [
	| p ret |
	p := self newProxy.
	p addResponse: p class pasteResponse.
	p addResponse: 'abc' asByteArray.
	p addResponse: p class pasteResponse.
	p addResponse: 'def' asByteArray.
	p addResponse: p class pasteResponse.
	p addResponse: String lf asByteArray.
	p addResponse: 'ghi' asByteArray.
	p addResponse: String lf asByteArray.
	p addResponse: 'paste mode; aaabbb' asByteArray.
	p addResponse: String lf asByteArray.
	ret := p withoutPasteResponse.
	self assert: ret equals: 'ghi'
]

{ #category : #test }
MicroPythonProxyTest >> testisRunning [
	| p c |
	p := self newProxy.
	c := self newComm.
	p comm: c.
	c isConnected: false.
	self deny: p isRunning.
	c isConnected: true.
	p setWaiting.
	self assert: p isRunning.
	p setPrompted.
	self deny: p isRunning
]
