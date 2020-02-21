Class {
	#name : #IntelHex,
	#superclass : #Object,
	#instVars : [
		'stream',
		'address',
		'checksum'
	],
	#category : #'MicroWiz-Microbit'
}

{ #category : #accessing }
IntelHex >> address [
	^ address
]

{ #category : #accessing }
IntelHex >> address: anInteger [
	address := anInteger bitAnd: 16rFFFF.
]

{ #category : #private }
IntelHex >> clearChecksum [
	checksum := 0
]

{ #category : #private }
IntelHex >> generateByte: anInteger [
	checksum := checksum + anInteger.
	stream nextPutAll: anInteger asHexString
]

{ #category : #private }
IntelHex >> generateChecksum [
	| data |
	data := checksum negated bitAnd: 16rFF.
	stream nextPutAll: data asHexString.
	stream lf.
	self clearChecksum.
]

{ #category : #private }
IntelHex >> generateChunk: aString [ 
	aString do: [:each | self generateByte: each asciiValue]
]

{ #category : #private }
IntelHex >> generateSize: anInteger [
	stream nextPut: $:.
	self generateByte: anInteger.
	self generateByte: address // 256.
	self generateByte: address \\ 256.
	self generateByte: 0.
]

{ #category : #private }
IntelHex >> generateString: aString [ 
	| total size end chunk |
	total := aString size.
	1
		to: total
		by: 16
		do: 
			[:each | 
			self clearChecksum.
			end := each + 15 min: total.
			size := end - each + 1.
			self generateSize: size.
			chunk := aString copyFrom: each to: end.
			self generateChunk: chunk.
			self generateChecksum.
			address := (address + size) bitAnd: 16rFFFF]
]

{ #category : #accessing }
IntelHex >> script: aString [ 
	| size str |
	size := aString size.
	str := 'MP' , (String with: (Character value: size \\ 256)
					with: (Character value: size // 256)) , aString.
	size := str size.
	str := str , (String new: 16 - (size \\ 16) withAll: (Character value: 0)).
	^ self generateString: str
]

{ #category : #accessing }
IntelHex >> stream [
	^ stream
]

{ #category : #accessing }
IntelHex >> stream: aStream [
	stream := aStream
]
