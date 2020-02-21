Class {
	#name : #SerialCommTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
SerialCommTest >> newComm [
	^ SerialComm new
]

{ #category : #test }
SerialCommTest >> testBaudRate [
	| c |
	c := self newComm.
	self assert: c baudRate equals: c defaultBaudRate.
	c baudRate: 9600.
	self assert: c baudRate equals: 9600
]

{ #category : #test }
SerialCommTest >> testClose [
	"same as testOpen"
]

{ #category : #test }
SerialCommTest >> testDefaultBaudRate [
	| c |
	c := self newComm.
	self assert: c defaultBaudRate equals: 115200
]

{ #category : #test }
SerialCommTest >> testGet [
	"same as testPut"
]

{ #category : #test }
SerialCommTest >> testIsConnected [
	| c |
	c := self newComm.
	self deny: c isConnected
]

{ #category : #test }
SerialCommTest >> testOpen [
	| c |
	c := self newComm.
	c portName: '/dev/ttyUSB0'.
	c baudRate: 115200.
	self assert: c open.
	self assert: c isConnected.
	c get.
	c put: #[13].
	0.1 asSeconds wait.
	self assertCollection: c get equals: #[13 10 62 62 62 32].
	c close
]

{ #category : #test }
SerialCommTest >> testOptions [
	| c |
	c := self newComm.
	self assert: c options isCollection.
	self assert: (c options includes: #portName).
	self assert: (c options includes: #baudRate)
]

{ #category : #test }
SerialCommTest >> testOptionsNamed [
	| c |
	c := self newComm.
	self assert: (c optionsNamed: #dummy) isCollection.
	self assert: (c optionsNamed: #portName) isCollection.
	self assert: (c optionsNamed: #portName) notEmpty.
	self assert: (c optionsNamed: #baudRate) isCollection.
	self assert: (c optionsNamed: #baudRate) notEmpty
]

{ #category : #test }
SerialCommTest >> testPort [
	| c |
	c := self newComm.
	self assert: c port isNil.
]

{ #category : #test }
SerialCommTest >> testPortName [
	| c |
	c := self newComm.
	self assert: c portName isNil.
	c portName: 'abc'.
	self assert: c portName equals: 'abc'.
	c portName: 'def'.
	self assert: c portName equals: 'def'
]

{ #category : #test }
SerialCommTest >> testPrintOn [
	| c s |
	c := self newComm.
	c baudRate: 9600.
	c portName: 'abc'.
	s := WriteStream on: String new.
	c printOn: s.
	self assert: s contents equals: 'SerialComm(abc,9600)'
]

{ #category : #test }
SerialCommTest >> testPut [
	| c |
	c := self newComm.
	c portName: '/dev/ttyUSB0'.
	c baudRate: 115200.
	self assert: c open.
	[ c get notNil ] whileTrue.
	c put: #[49 43 50 13].
	0.1 asSeconds wait.
	self assertCollection: c get equals: #[49 43 50 13 10 51 13 10 62 62 62 32].
	c close
]

{ #category : #test }
SerialCommTest >> testSetOptionTo [
	| c |
	c := self newComm.
	self assert: c portName isNil.
	c setOption: #portName to: 'abc'.
	self assert: c portName equals: 'abc'.
	self assert: c baudRate equals: c defaultBaudRate.
	c setOption: #baudRate to: '9600'.
	self assert: c baudRate equals: 9600
]

{ #category : #test }
SerialCommTest >> testUnixPortNames [
	| c |
	c := self newComm.
	self assert: c unixPortNames isCollection
]
