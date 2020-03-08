Class {
	#name : #ULispProxy,
	#superclass : #MicroWizProxy,
	#category : #'MicroWiz-uLisp'
}

{ #category : #constants }
ULispProxy class >> breakRequest [
	^ '~' asByteArray
]

{ #category : #private }
ULispProxy >> addResponse: aCollection [
	aCollection isEmpty
		ifTrue: [ ^ self ].
	super addResponse: aCollection.
	self isWaiting
		ifTrue: [ self setPastePrompted ]
]

{ #category : #testing }
ULispProxy >> hasPrompts: aString [
	| x str |
	x := aString indexOf: $>.
	x < 2
		ifTrue: [ ^ false ].
	x >= aString size
		ifTrue: [ ^ false ].
	(aString at: x + 1) = Character space
		ifFalse: [ ^ false ].
	str := aString copyFrom: 1 to: x - 1.
	^ str isNumberString
]

{ #category : #api }
ULispProxy >> icon [
	^ ScratchTheme formAt: #ulisp
]

{ #category : #testing }
ULispProxy >> isPromptResponse: aByteArray [
	"uLisp 3.0 
314> "

	| x str |
	str := aByteArray asString.
	x := str indexOf: $>.
	x < 2
		ifTrue: [ ^ false ].
	(x + 1 between: str size - 1 and: str size)
		ifFalse: [ ^ false ].
	(str at: x + 1) = Character space
		ifFalse: [ ^ false ].
	^ (str copyFrom: 1 to: x - 1) isNumberString
]

{ #category : #api }
ULispProxy >> newBlockSpecs [
	^ ULispBlockSpecs new
]

{ #category : #api }
ULispProxy >> newCode [
	^ ULispCode new
		generator: ULispGenerator new;
		yourself
]

{ #category : #private }
ULispProxy >> processSendingQueue [
	sendingQueue isEmpty
		ifTrue: [ ^ self ].
	(self isPrompted or: [ self isPastePrompted ])
		ifFalse: [ ^ self ].
	self
		sendCommand: sendingQueue removeFirst asByteArray , self class crRequest
]

{ #category : #api }
ULispProxy >> removePrompts: aString [
	| x |
	(self hasPrompts: aString)
		ifFalse: [ ^ aString ].
	x := aString indexOf: $>.
	^ aString copyFrom: x + 2 to: aString size
]

{ #category : #api }
ULispProxy >> sendBreak [
	self sendCommand: self class breakRequest.
	self clearSendingQueue
]
