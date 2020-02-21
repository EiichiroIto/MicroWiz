Class {
	#name : #MicroPythonParser,
	#superclass : #Object,
	#category : #'MicroWiz-Converter'
}

{ #category : #parsing }
MicroPythonParser >> parse: aString [
	| stream |
	stream := ReadStream on: aString.
	^ self parseItem: stream
]

{ #category : #private }
MicroPythonParser >> parseIdentifier: aStream [
	| out c |
	out := WriteStream on: String new.
	[ aStream atEnd ]
		whileFalse: [ c := aStream next.
			c isLetter
				ifTrue: [ out nextPut: c ]
				ifFalse: [ aStream back.
					^ out contents ifEmpty: [ nil ] ifNotEmpty: [ :o | o asSymbol ] ] ].
	^ out contents ifEmpty: [ nil ] ifNotEmpty: [ :o | o asSymbol ]
]

{ #category : #private }
MicroPythonParser >> parseItem: aStream [
	| token |
	aStream atEnd
		ifTrue: [ ^ nil ].
	[ token := aStream next. token = Character space ] whileTrue.
	token = $[
		ifTrue: [ ^ self parseItems: aStream delimiter: $] ].
	(token = $" or: [ token = $' ])
		ifTrue: [ ^ self parseString: aStream delimiter: token ].
	token isDigit
		ifTrue: [ aStream back.
			^ self parseNumber: aStream ].
	token isLetter
		ifTrue: [ aStream back.
			^ self parseIdentifier: aStream ].
	self error
]

{ #category : #private }
MicroPythonParser >> parseItems: aStream delimiter: aCharacter [
	| list item c |
	list := OrderedCollection new.
	aStream next = aCharacter
		ifTrue: [ ^ list asArray ].
	aStream back.
	[ item := self parseItem: aStream.
	list add: item.
	c := aStream next.
	c = aCharacter
		ifTrue: [ ^ list asArray ].
	c = $, ] whileTrue.
	self error
]

{ #category : #private }
MicroPythonParser >> parseNumber: aStream [
	| out c |
	out := WriteStream on: String new.
	[ aStream atEnd ]
		whileFalse: [ c := aStream next.
			(c isDigit or: [ c = $. ])
				ifTrue: [ out nextPut: c ]
				ifFalse: [ aStream back.
					^ out contents asNumberNoError ] ].
	^ out contents asNumberNoError
]

{ #category : #private }
MicroPythonParser >> parseString: aStream delimiter: aCharacter [
	| out c |
	out := WriteStream on: String new.
	[ aStream atEnd ]
		whileFalse: [ c := aStream next.
			c = aCharacter
				ifTrue: [ ^ out contents ].
			c = $\
				ifTrue: [ c := aStream next.
					c = $n
						ifTrue: [ c := Character lf ].
					c = $r
						ifTrue: [ c := Character cr ] ].
			out nextPut: c ].
	self error
]
