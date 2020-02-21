Class {
	#name : #ExtModuleDef,
	#superclass : #Object,
	#instVars : [
		'moduleName',
		'varName',
		'header',
		'blockDefs'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #private }
ExtModuleDef >> assignSelectors [
	blockDefs
		withIndexDo:
			[ :each :index | each assignSelector: self moduleName id: index ]
]

{ #category : #accessing }
ExtModuleDef >> blockDefAt: aSymbol [
	^ self blockDefs at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
ExtModuleDef >> blockDefs [
	^ blockDefs
]

{ #category : #accessing }
ExtModuleDef >> blockDefs: aCollection [
	blockDefs := aCollection
]

{ #category : #api }
ExtModuleDef >> blockTuples [
	blockDefs isDictionary
		ifFalse: [ self error: 'need to setup' ].
	^ blockDefs keys collect: [ :each | (blockDefs at: each) blockTuple ]
]

{ #category : #api }
ExtModuleDef >> blocks [
	blockDefs isDictionary
		ifTrue: [ ^ (blockDefs keys collect: [ :each | (blockDefs at: each) block ])
				joinUsing: String lf ].
	blockDefs isCollection
		ifTrue: [ ^ (blockDefs collect: #block) joinUsing: String lf ].
	self error
]

{ #category : #private }
ExtModuleDef >> convertToDictionary [
	| dict |
	dict := OrderedDictionary new.
	blockDefs do: [ :each | dict at: each selector put: each ].
	blockDefs := dict
]

{ #category : #accessing }
ExtModuleDef >> header [
	^ header ifNil: [ '' ]
]

{ #category : #accessing }
ExtModuleDef >> header: aString [
	header := aString
]

{ #category : #api }
ExtModuleDef >> moduleFilename [
	^ self moduleName , '.py'
]

{ #category : #accessing }
ExtModuleDef >> moduleName [
	^ moduleName
]

{ #category : #accessing }
ExtModuleDef >> moduleName: aString [
	moduleName := aString
]

{ #category : #printing }
ExtModuleDef >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: moduleName asString;
		nextPut: $,;
		nextPutAll: (blockDefs ifNil: [ 0 ] ifNotNil: [ blockDefs size ]) asString;
		nextPut: $)
]

{ #category : #api }
ExtModuleDef >> setup [
	self
		assignSelectors;
		convertToDictionary
]

{ #category : #accessing }
ExtModuleDef >> varName [
	^ varName
]

{ #category : #accessing }
ExtModuleDef >> varName: aString [
	varName := aString
]
