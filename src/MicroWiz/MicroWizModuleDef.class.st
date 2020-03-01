Class {
	#name : #MicroWizModuleDef,
	#superclass : #Object,
	#instVars : [
		'blockDefs',
		'blockDict'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
MicroWizModuleDef >> blockDefAt: aSymbol [
	^ self blockDict at: aSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
MicroWizModuleDef >> blockDefs [
	^ blockDefs
]

{ #category : #accessing }
MicroWizModuleDef >> blockDefs: aCollection [
	blockDefs := aCollection
]

{ #category : #accessing }
MicroWizModuleDef >> blockDict [
	^ blockDict
]

{ #category : #accessing }
MicroWizModuleDef >> blockDict: anObject [
	blockDict := anObject
]

{ #category : #api }
MicroWizModuleDef >> blockTuples [
	blockDict
		ifNil: [ self error: 'need to setup' ].
	^ blockDefs collect: #blockTuple
]

{ #category : #api }
MicroWizModuleDef >> blocks [
	^ (blockDefs collect: #block) joinUsing: String lf
]

{ #category : #printing }
MicroWizModuleDef >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: (blockDefs ifNil: [ 0 ] ifNotNil: [ blockDefs size ]) asString;
		nextPut: $)
]

{ #category : #api }
MicroWizModuleDef >> setup [
	self
		setupBlockDefs;
		setupBlockDict
]

{ #category : #private }
MicroWizModuleDef >> setupBlockDefs [
	"do nothing"
]

{ #category : #private }
MicroWizModuleDef >> setupBlockDict [
	blockDict := OrderedDictionary new.
	blockDefs
		do: [ :each | 
			each isBlockDef
				ifTrue: [ blockDict at: each selector put: each ] ]
]
