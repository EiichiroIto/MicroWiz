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
	^ super stonAllInstVarNames , #(objName varNames)
]

{ #category : #'argument menus' }
MicroWizScript >> addArgBuilder [
	super addArgBuilder.
	project addArgBuilderTo: argBuilder
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
MicroWizScript >> deleteVariable: aString [
	varNames remove: aString ifAbsent: [  ]
]

{ #category : #accessing }
MicroWizScript >> evaluateFor: aTopBlock [
	^ project evaluateFor: aTopBlock
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
		initFieldsNamed: #(objName varNames)
		from: anObjStream
]

{ #category : #initialization }
MicroWizScript >> initialize [
	super initialize.
	varNames := OrderedCollection new
]

{ #category : #'block specs' }
MicroWizScript >> intBlockDefOf: aSymbol [
	^ project intBlockDefOf: aSymbol
]

{ #category : #testing }
MicroWizScript >> isValidSubName: aString [
	aString isEmpty
		ifTrue: [ ^ false ].
	aString first isDigit
		ifTrue: [ ^ false ].
	^ aString allSatisfy: [ :each | each isAlphaNumeric ]
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
	self storeFieldsNamed: #(objName varNames) on: anObjStream.
]

{ #category : #testing }
MicroWizScript >> useList [
	^ false
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
	^ varNames includes: aString
]
