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
		'AvailableModules',
		'IntModules'
	],
	#category : #'MicroWiz-Project'
}

{ #category : #accessing }
MicroWizProject class >> appVersion [
	^ 2
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

{ #category : #accessing }
MicroWizProject class >> extModExtension [
	^ 'mwm'
]

{ #category : #private }
MicroWizProject class >> intModExtension [
	^ 'mwi'
]

{ #category : #accessing }
MicroWizProject class >> intModuleAt: aString [
	^ self intModules at: aString ifAbsent: [ nil ]
]

{ #category : #accessing }
MicroWizProject class >> intModules [
	^ IntModules ifNil: [ #() ]
]

{ #category : #accessing }
MicroWizProject class >> intModules: aDictionary [
	IntModules := aDictionary
]

{ #category : #testing }
MicroWizProject class >> isAvailableModule: aString [
	^ self availableModuleNames includes: aString
]

{ #category : #private }
MicroWizProject class >> loadAvailableModules [
	| dict |
	dict := Dictionary new.
	self loadModuleExtension: self extModExtension into: dict.
	self availableModules: dict
]

{ #category : #private }
MicroWizProject class >> loadIntModules [
	"self loadIntModules"
	| dict |
	dict := Dictionary new.
	self loadModuleExtension: self intModExtension into: dict.
	self intModules: dict
]

{ #category : #private }
MicroWizProject class >> loadModuleExtension: ext into: aDictionary [
	(self moduleDirectory filesMatching: '*.' , ext)
		do: [ :each | 
			each
				readStreamDo: [ :stream | 
					aDictionary
						at: each base
						put: (ModuleImporter new import: stream contents) setup ] ]
]

{ #category : #private }
MicroWizProject class >> moduleDirectory [
	| dir |
	dir := FileSystem workingDirectory / 'Modules'.
	dir isDirectory
		ifFalse: [ dir createDirectory ].
	^ dir
]

{ #category : #'ston-core' }
MicroWizProject class >> stonAllInstVarNames [
	^ super stonAllInstVarNames , #(proxyClass commClass modules)
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

{ #category : #accessing }
MicroWizProject >> evaluateFor: aTopBlock [
	^ application evaluateFor: aTopBlock
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

{ #category : #'file read/write' }
MicroWizProject >> getScratchInfoFrom: aFileReference [
	| dict icon |
	dict := super getScratchInfoFrom: aFileReference.
	dict ifNil: [ ^ nil ].
	icon := (Smalltalk at: (dict at: 'proxy')) new icon.
	dict at: 'thumbnail' put: icon.
	^ dict
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

{ #category : #'block specs' }
MicroWizProject >> intBlockDefOf: aSymbol [
	^ blockSpecs intBlockDefOf: aSymbol
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

{ #category : #'block specs' }
MicroWizProject >> setupBlockCategoryTo: aBlockDef [
	self blockSpecs setupBlockCategoryTo: aBlockDef
]

{ #category : #'object i/o' }
MicroWizProject >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(proxyClass commClass modules) on: anObjStream.
	super storeFieldsOn: anObjStream
]

{ #category : #'file read/write' }
MicroWizProject >> storeProjectInfoOn: aBinaryStream [
	info removeKey: 'thumbnail'.
	info at: 'proxy' put: proxyClass.
	super storeProjectInfoOn: aBinaryStream
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
