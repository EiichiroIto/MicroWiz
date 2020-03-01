Class {
	#name : #MicroWizScript,
	#superclass : #ScratchScript,
	#instVars : [
		'objName',
		'varNames',
		'listVarNames'
	],
	#category : #'MicroWiz-Project'
}

{ #category : #'ston-core' }
MicroWizScript class >> stonAllInstVarNames [
	^ super stonAllInstVarNames , #(objName varNames listVarNames)
]

{ #category : #'argument menus' }
MicroWizScript >> addArgBuilder [
	super addArgBuilder.
	project addArgBuilderTo: argBuilder
]

{ #category : #variables }
MicroWizScript >> addList: aString [
	listVarNames add: aString
]

{ #category : #variables }
MicroWizScript >> addVariable: aString [
	varNames add: aString
]

{ #category : #'argument menus' }
MicroWizScript >> allSubNames [
	^ project allSubNames
]

{ #category : #'block specs' }
MicroWizScript >> blocks [
	^ project blocks
]

{ #category : #accessing }
MicroWizScript >> breedNo [
	^ objName
]

{ #category : #blocks }
MicroWizScript >> compareHatBlock: a and: b [
	| aIsSubHat bIsSubHat |
	aIsSubHat := a isKindOf: SubHatMorph.
	bIsSubHat := b isKindOf: SubHatMorph.
	(aIsSubHat and: [ bIsSubHat ])
		ifTrue: [ ^ a subName < b subName ].
	aIsSubHat
		ifTrue: [ ^ true ].
	bIsSubHat
		ifTrue: [ ^ false ].
	^ a eventName < b eventName
]

{ #category : #variables }
MicroWizScript >> deleteList: aString [
	listVarNames remove: aString ifAbsent: [  ]
]

{ #category : #variables }
MicroWizScript >> deleteVariable: aString [
	varNames remove: aString ifAbsent: [  ]
]

{ #category : #'block specs' }
MicroWizScript >> extBlockDefOf: aSymbol [
	project class availableModules
		do: [ :each | (each blockDefAt: aSymbol) ifNotNil: [ :def | ^ def ] ].
	^ nil
]

{ #category : #'object i/o' }
MicroWizScript >> fieldsVersion [
	^ 1
]

{ #category : #blocks }
MicroWizScript >> hatBlocks [
	| list |
	list := super hatBlocks.
	list := list sort: [ :a :b | self compareHatBlock: a and: b ].
	^ list
]

{ #category : #'object i/o' }
MicroWizScript >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self
		initFieldsNamed: #(objName varNames listVarNames)
		from: anObjStream
]

{ #category : #initialization }
MicroWizScript >> initialize [
	super initialize.
	varNames := OrderedCollection new.
	listVarNames := OrderedCollection new
]

{ #category : #'block specs' }
MicroWizScript >> intBlockDefOf: aSymbol [
	^ project intBlockDefOf: aSymbol
]

{ #category : #'argument menus' }
MicroWizScript >> listVarNames [
	^ listVarNames
]

{ #category : #accessing }
MicroWizScript >> objName [
	^ objName
]

{ #category : #accessing }
MicroWizScript >> objName: aString [
	objName := aString
]

{ #category : #'block specs' }
MicroWizScript >> setupBlockCategory [
	super setupBlockCategory.
	project setupBlockCategoryTo: blockDef
]

{ #category : #'object i/o' }
MicroWizScript >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(objName varNames listVarNames) on: anObjStream.
]

{ #category : #testing }
MicroWizScript >> useVariableWatcher [
	^ false
]

{ #category : #'argument menus' }
MicroWizScript >> varNames [
	^ varNames
]

{ #category : #variables }
MicroWizScript >> variableNameInUse: aString [
	^ (varNames includes: aString) or: [ listVarNames includes: aString ]
]
