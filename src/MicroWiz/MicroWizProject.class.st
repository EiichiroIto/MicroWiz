Class {
	#name : #MicroWizProject,
	#superclass : #ScratchProject,
	#instVars : [
		'proxyClass',
		'commClass',
		'blockSpecs',
		'modules'
	],
	#classVars : [
		'AvailableModules'
	],
	#category : #'MicroWiz-Project'
}

{ #category : #accessing }
MicroWizProject class >> appVersion [
	^ 1
]

{ #category : #accessing }
MicroWizProject class >> appVersionTag [
	^ 'MicroWizV'
]

{ #category : #accessing }
MicroWizProject class >> availableModuleNames [
	^ self availableModules keys
]

{ #category : #accessing }
MicroWizProject class >> availableModules [
	^ AvailableModules ifNil: [ #() ]
]

{ #category : #accessing }
MicroWizProject class >> availableModules: aDictionary [
	AvailableModules := aDictionary
]

{ #category : #testing }
MicroWizProject class >> isAvailableModule: aString [
	^ self availableModuleNames includes: aString
]

{ #category : #accessing }
MicroWizProject class >> modExtension [
	^ 'mwm'
]

{ #category : #private }
MicroWizProject class >> moduleDirectory [
	| dir |
	dir := FileSystem workingDirectory / 'Modules'.
	dir isDirectory
		ifFalse: [ dir createDirectory ].
	^ dir
]

{ #category : #private }
MicroWizProject class >> setupAvailableModules [
	| dict |
	dict := Dictionary new.
	(self moduleDirectory filesMatching: '*.' , self modExtension)
		do: [ :each | 
			each
				readStreamDo: [ :stream | 
					dict
						at: each base
						put: (ExtModuleImporter new import: stream contents) setup ] ].
	self availableModules: dict
]

{ #category : #'block specs' }
MicroWizProject >> addArgBuilderTo: anArgBuilder [
	self blockSpecs addArgBuilderTo: anArgBuilder
]

{ #category : #accessing }
MicroWizProject >> addModule: aSymbol [
	modules := modules copyWith: aSymbol.
	self updateBlockDefs
]

{ #category : #private }
MicroWizProject >> addScriptNamed: aString [
	| script |
	script := MicroWizScript new
		project: self;
		objName: aString;
		yourself.
	self addScript: script.
	^ script
]

{ #category : #accessing }
MicroWizProject >> application: anApplication [
	super application: anApplication.
	scripts isEmpty ifTrue: [ self addScriptNamed: 'main' ]
]

{ #category : #accessing }
MicroWizProject >> assureExistsBreed: each [
	((self scripts collect: #objName) includes: each)
		ifTrue: [ ^ self ].
	self addScriptNamed: each
]

{ #category : #accessing }
MicroWizProject >> assureImportModule: aString [
	(self class isAvailableModule: aString)
		ifFalse: [ self error: 'not available module: ' localized, aString ].
	(self moduleInUse: aString)
		ifTrue: [ ^ self ].
	self addModule: aString
]

{ #category : #'block specs' }
MicroWizProject >> blockSpecs [
	^ blockSpecs
		ifNil: [ blockSpecs := (Smalltalk at: self proxyClass) new newBlockSpecs ]
]

{ #category : #'block specs' }
MicroWizProject >> blocks [
	^ self blockSpecs blocks, self extBlockTuples
]

{ #category : #accessing }
MicroWizProject >> commClass [
	^ commClass
]

{ #category : #accessing }
MicroWizProject >> commClass: aSymbol [
	commClass := aSymbol
]

{ #category : #accessing }
MicroWizProject >> deleteModule: aSymbol [
	modules := modules copyWithout: aSymbol.
	self updateBlockDefs
]

{ #category : #'block specs' }
MicroWizProject >> extBlockTuples [
	| st |
	st := WriteStream on: Array new.
	st nextPut: 'modules'.
	self modules
		do:
			[ :each | st nextPutAll: (self class availableModules at: each) blockTuples ]
		separatedBy: [ st nextPut: '-' ].
	^ st contents
]

{ #category : #'object i/o' }
MicroWizProject >> fieldsVersion [
	^ 1
]

{ #category : #'object i/o' }
MicroWizProject >> initFieldsFrom: anObjStream version: classVersion [
	self
		initFieldsNamed: #(proxyClass commClass modules)
		from: anObjStream.
	super initFieldsFrom: anObjStream version: classVersion
]

{ #category : #initialization }
MicroWizProject >> initialize [
	super initialize.
	modules := Array new
]

{ #category : #accessing }
MicroWizProject >> moduleFileFor: aString [
	| file |
	file := self class moduleDirectory / (aString , '.' , application pyExtension).
	file isFile
		ifFalse: [ ^ nil ].
	^ file
]

{ #category : #testing }
MicroWizProject >> moduleInUse: aString [
	^ modules includes: aString
]

{ #category : #accessing }
MicroWizProject >> modules [
	^ modules
]

{ #category : #private }
MicroWizProject >> newObjStream [
	^ MicroWizObjStream new
]

{ #category : #accessing }
MicroWizProject >> proxyClass [
	^ proxyClass
]

{ #category : #accessing }
MicroWizProject >> proxyClass: aSymbol [
	proxyClass := aSymbol.
	blockSpecs := nil
]

{ #category : #'object i/o' }
MicroWizProject >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(proxyClass commClass modules) on: anObjStream.
	super storeFieldsOn: anObjStream
]

{ #category : #accessing }
MicroWizProject >> toggleModule: aString [
	(self moduleInUse: aString)
		ifTrue: [ self deleteModule: aString ]
		ifFalse: [ self addModule: aString ]
]

{ #category : #accessing }
MicroWizProject >> updateBlockDefs [
	scripts do: #setupBlockDef
]
