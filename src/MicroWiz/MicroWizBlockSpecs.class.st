Class {
	#name : #MicroWizBlockSpecs,
	#superclass : #Object,
	#instVars : [
		'intModuleDef'
	],
	#category : #'MicroWiz-Core'
}

{ #category : #'argument menus' }
MicroWizBlockSpecs >> addArgBuilderTo: anArgBuilder [
	anArgBuilder
		addChoiceArg: $a selector: #allSubNames;
		addChoiceArg: $d
			selector: #digits
			target: self
			initialChoice: '0';
		addNumberExpressArg: $i
			selector: #listIndexMenu
			target: self
			initialExpression: '0';
		addNumberExpressArg: $y
			selector: #listIndexForDeleteNames
			target: self
			initialExpression: '0'
]

{ #category : #private }
MicroWizBlockSpecs >> addIntModuleDefNamed: aString [
	| m |
	m := MicroWizProject intModuleAt: aString.
	m ifNil: [ ^ self ].
	intModuleDef := intModuleDef
		ifNil: [ m ]
		ifNotNil: [ intModuleDef + m ]
]

{ #category : #'block specs' }
MicroWizBlockSpecs >> blocks [
	^ self controlBlocks , self variablesBlocks
		, self modulesBlocks, self intModuleBlocks
]

{ #category : #'block specs' }
MicroWizBlockSpecs >> controlBlocks [
	^ #(
		'control'
			('when %m clicked'		T	-)
			-
			('forever'					c	doForever)
			('repeat %n each %l'	c	doRepeat 10 'i')
			('while %b'					c	doWhile)
			('repeat until %b'		c	doUntil)
			-
			('if %b'						c	doIf)
			('if %b'						c	doIfElse)
	)
]

{ #category : #'argument menus' }
MicroWizBlockSpecs >> digits [
	^ (0 to: 9) collect: [ :each | each asString ]
]

{ #category : #initialization }
MicroWizBlockSpecs >> initialize [
	self setupIntModuleDef
]

{ #category : #'block specs' }
MicroWizBlockSpecs >> intBlockDefOf: aSymbol [
	^ intModuleDef
		ifNil: [ nil ]
		ifNotNil: [ :m | m blockDefAt: aSymbol ]
]

{ #category : #'block specs' }
MicroWizBlockSpecs >> intModuleBlocks [
	^ intModuleDef
		ifNil: [ #() ]
		ifNotNil: [ :def | def blockTuples asArray ]
]

{ #category : #'argument menus' }
MicroWizBlockSpecs >> listIndexForDeleteNames [
	^ #('0' last all)
		collect: [ :s | 
			{s localized.
			s} ]
]

{ #category : #'argument menus' }
MicroWizBlockSpecs >> listIndexNames [
	^ #('0' any last) collect: [ :s | {s localized. s} ]
]

{ #category : #'block specs' }
MicroWizBlockSpecs >> modulesBlocks [
	^ #(
		'modules'
			('execute %a of %m'		-		execute:of: '' '')
			('evaluate %a of %m'		r 		evaluate:of: '' '')
			-
		)
]

{ #category : #'argument menus' }
MicroWizBlockSpecs >> setupBlockCategoryTo: aScratchBlockDef [ 
	self shouldBeImplemented.
]

{ #category : #private }
MicroWizBlockSpecs >> setupIntModuleDef [
	self subclassResponsibility
]

{ #category : #'block specs' }
MicroWizBlockSpecs >> variablesBlocks [
	^ #(
		'list'
			('add %s to %L'					-	append:toList: 'thing')
			-
			('delete %y of %L'				-	deleteLine:ofList: 0)
			('insert %s at %i of %L'			-	insert:at:ofList: 'thing' 0)
			('replace item %i of %L with %s'		-	setLine:ofList:to: 0 'list' 'thing')
			('replace all items of %L with %s'		- replaceAllList:with: 'list' 'a b c')
			-
			('item %i of %L'					r	getLine:ofList: 0)
			('length of %L'					r	lineCountOfList:)
			('%L contains %s'				b	list:contains: 'list' 'thing')
			-
			('list %L'							r	contentsOfList: 'list')
	)
]
