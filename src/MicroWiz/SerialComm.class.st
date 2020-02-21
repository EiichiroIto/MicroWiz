Class {
	#name : #SerialComm,
	#superclass : #MWComm,
	#instVars : [
		'port',
		'portName',
		'baudRate'
	],
	#category : #'MicroWiz-Comm'
}

{ #category : #private }
SerialComm class >> enumerateComPort: dst max: size [
	^ self ffiCall: #(int EnumerateComPort(FFIExternalArray dst, int size)) module: 'MicroWiz.dll'
]

{ #category : #accessing }
SerialComm >> baudRate [
	^ baudRate ifNil: [ baudRate := self defaultBaudRate ]
]

{ #category : #accessing }
SerialComm >> baudRate: anInteger [
	baudRate := anInteger
]

{ #category : #api }
SerialComm >> close [
	self isConnected
		ifFalse: [ ^ self ].
	port close.
	port := nil
]

{ #category : #private }
SerialComm >> defaultBaudRate [
	^ 115200
]

{ #category : #api }
SerialComm >> get [
	| ret |
	self isConnected
		ifFalse: [ ^ nil ].
	ret := port readByteArray.
	ret isEmpty
		ifTrue: [ ^ nil ].
	^ ret
]

{ #category : #api }
SerialComm >> isConnected [
	^ port notNil
]

{ #category : #api }
SerialComm >> open [
	self isConnected
		ifTrue: [ ^ true ].
	portName ifNil: [ ^ false ].
	port := SerialPort new.
	port
		baudRate: self baudRate;
		dataBits: 8;
		parityType: 0;
		outputFlowControlType: 0;
		inputFlowControlType: 2.
	[ port openPort: portName ]
		on: Error
		do: [ :err | 
			self inform: err asString.
			port := nil.
			^ false ].
	^ true
]

{ #category : #accessing }
SerialComm >> options [
	^ #(portName baudRate)
]

{ #category : #accessing }
SerialComm >> optionsNamed: aSymbol [
	aSymbol = #baudRate
		ifTrue: [ ^ #(2400 4800 9600 19200 38400 76800 115200) ].
	aSymbol = #portName
		ifTrue: [ ^ self portNames ].
	^ #()
]

{ #category : #private }
SerialComm >> port [
	^ port
]

{ #category : #accessing }
SerialComm >> portName [
	^ portName
]

{ #category : #accessing }
SerialComm >> portName: aString [
	portName := aString
]

{ #category : #private }
SerialComm >> portNames [
	Smalltalk os isUnix
		ifTrue: [ ^ self portNamesDo: [ self unixPortNames ] ].
	Smalltalk os isWin32
		ifTrue: [ ^ self portNamesDo: [ self win32PortNames ] ].
	self error: 'not supported'
]

{ #category : #private }
SerialComm >> portNamesDo: aBlock [
	^ aBlock
		ifError:
			[ {(UIManager default request: 'Enter COM port (like COM3)')} ]
]

{ #category : #printing }
SerialComm >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(.
	self isConnected
		ifTrue: [ aStream nextPut: $* ].
	aStream
		nextPutAll: self portName asString;
		nextPut: $,;
		nextPutAll: self baudRate asString;
		nextPut: $)
]

{ #category : #api }
SerialComm >> put: aByteArray [
	self isConnected
		ifFalse: [ ^ 0 ].
	^ port nextPutAll: aByteArray
]

{ #category : #accessing }
SerialComm >> setOption: aString to: anObject [
	aString = #portName
		ifTrue: [ ^ self portName: anObject asString ].
	aString = #baudRate
		ifTrue: [ ^ self baudRate: anObject asInteger ]
]

{ #category : #private }
SerialComm >> unixPortNames [
	| dir list |
	dir := '/dev/' asFileReference.
	list := dir fileNames.
	list := list
				select: [:each | (each beginsWith: 'ttyUSB')
						or: [each beginsWith: 'ttyACM']].
	^ list collect: [:each | (dir / each) pathString ]
]

{ #category : #private }
SerialComm >> win32PortNames [
	| ext size str |
	ext := FFIExternalArray externalNewType: 'byte' size: 1024.
	size := self class enumerateComPort: ext max: 1024.
	str := ByteArray new: size.
	1 to: size do: [ :each | str at: each put: (ext at: each) ].
	ext release.
	^ str asString lines
]
