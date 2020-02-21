"
A MicroPythonProcessTest is a test class for testing the behavior of MicroPythonProcess
"
Class {
	#name : #MicroPythonProcessTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroPythonProcessTest >> newBlock [
	^ BlockMorph new
]

{ #category : #private }
MicroPythonProcessTest >> newComm [
	^ DummyComm new
]

{ #category : #private }
MicroPythonProcessTest >> newProcess [
	^ MicroPythonProcess new
]

{ #category : #private }
MicroPythonProcessTest >> newProxy [
	^ MicroPythonProxy new
]

{ #category : #test }
MicroPythonProcessTest >> testErrorFlag [
	| p |
	p := self newProcess.
	self deny: p errorFlag
]

{ #category : #test }
MicroPythonProcessTest >> testIsRunning [
	| process proxy comm |
	process := self newProcess.
	proxy := self newProxy.
	comm := self newComm.
	proxy comm: comm.
	process proxy: proxy.
	comm isConnected: false.
	self deny: process isRunning.
	comm isConnected: true.
	proxy setReady.
	self assert: process isRunning.
	proxy setPrompted.
	self deny: process isRunning
]

{ #category : #test }
MicroPythonProcessTest >> testProxy [
	| proxy process |
	process := self newProcess.
	self assert: process proxy isNil.
	proxy := self newProxy.
	process proxy: proxy.
	self assert: process proxy equals: proxy
]

{ #category : #test }
MicroPythonProcessTest >> testStop [
	| process proxy comm block |
	process := self newProcess.
	proxy := self newProxy.
	comm := self newComm.
	block := self newBlock.
	proxy comm: comm.
	comm isConnected: true.
	proxy setReady.
	block scratchProc: process.
	process
		proxy: proxy;
		topBlock: block.
	self assert: process isRunning.
	self assert: block scratchProc notNil.
	process stop.
	self
		assertCollection: comm putQueue first
		equals: proxy class breakRequest.
	self assert: block scratchProc isNil
]

{ #category : #test }
MicroPythonProcessTest >> testTopBlock [
	| p b |
	p := self newProcess.
	self assert: p topBlock isNil.
	b := self newBlock.
	p topBlock: b.
	self assert: p topBlock equals: b
]
