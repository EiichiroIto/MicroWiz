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
