Class {
	#name : #MicroPythonBlockSpecs,
	#superclass : #Object,
	#instVars : [
		'intModuleDef'
	],
	#category : #'MicroWiz-MPython'
}

{ #category : #'argument menus' }
MicroPythonBlockSpecs >> addArgBuilderTo: anArgBuilder [
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
MicroPythonBlockSpecs >> addIntModuleDefNamed: aString [
	| m |
	m := MicroWizProject intModuleAt: aString.
	m ifNil: [ ^ self ].
	intModuleDef := intModuleDef
		ifNil: [ m ]
		ifNotNil: [ intModuleDef + m ]
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> blocks [
	^ self miscBlocks , self ioBlocks , self displayBlocks
		, self controlBlocks , self operatorsBlocks , self variablesBlocks
		, self sensingBlocks , self modulesBlocks, self intModuleBlocks
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> controlBlocks [
	^ #(
		'control'
			('when %m clicked'		T	-)
			-
			('forever'					c	doForever)
			('repeat %n'				c	doRepeat 10)
			('while %b'					c	doWhile)
			('repeat until %b'		c	doUntil)
			-
			('if %b'						c	doIf)
			('if %b'						c	doIfElse)
	)
]

{ #category : #'argument menus' }
MicroPythonBlockSpecs >> digits [
	^ (0 to: 9) collect: [ :each | each asString ]
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> displayBlocks [
	^ #()
]

{ #category : #initialization }
MicroPythonBlockSpecs >> initialize [
	self setupIntModuleDef
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> intBlockDefOf: aSymbol [
	^ intModuleDef
		ifNil: [ nil ]
		ifNotNil: [ :m | m blockDefAt: aSymbol ]
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> intModuleBlocks [
	^ intModuleDef
		ifNil: [ #() ]
		ifNotNil: [ :def | def blockTuples asArray ]
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> ioBlocks [
	^ #()
]

{ #category : #'argument menus' }
MicroPythonBlockSpecs >> listIndexForDeleteNames [
	^ #('0' last all)
		collect: [ :s | 
			{s localized.
			s} ]
]

{ #category : #'argument menus' }
MicroPythonBlockSpecs >> listIndexNames [
	^ #('0' any last) collect: [ :s | {s localized. s} ]
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> miscBlocks [
	^ #()
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> modulesBlocks [
	^ #(
		'modules'
			('execute %a of %m'		-		execute:of: '' '')
			('evaluate %a of %m'		r 		evaluate:of: '' '')
			-
		)
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> operatorsBlocks [
	^ #(
		'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)
			('%n * %n'						r	* - -)
			('%n / %n'						r	/ - -)
			('- %n'								r	negated: 1)
			-
			('pick random %n to %n'		r	randomFrom:to: 1 10)
			-
			('%s < %s'							b	< '' '')
			('%s = %s'							b	= '' '')
			('%s > %s'							b	> '' '')
			('%n between %n and %n'		b 	is:between:and: 20 10 30)
			('%s is None'						b	isNone:)
			-
			('%b and %b'						b	&)
			('%b or %b'							b	|)
			('not %b'								b	not:)
			('true'									b	getTrue)
			('false'								b	getFalse)
			-
			('string of %n'				r	stringOf:	0)
			('number of %s'				r	numberOf: '123')
			('string from %s encoding %s'
													r	stringFrom:encoding: '' 'utf8')
			('bytes from %s encoding %s'
													r	bytesFrom:encoding: 'abc' 'utf8')
			('join %s %s'					r	concatenate:with: 'hello ' 'world')
			('letter %n of %s'			r	letter:of: 0 'world')
			('length of %s'				r	stringLength: 'world')
			('split %s by %s limit %n to %L'		-
														split:by:limit:to:		'a,b,c' , -1 'list')
			('any of %s'					r	anyOf: )
			-
			('%n mod %n'					r	\\ - -)
			('round %n'					r	rounded -)
			('abs %n'						r	abs -)
			('abs %n sign %n'			r	abs:sign:	- -)
			-
			('%f of %n'					r	computeFunction:of: 'sqrt' 10)
	)
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> sensingBlocks [
	^ #()
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> setupBlockCategoryTo: aBlockDef [
	aBlockDef
		"
		addCategory: 'display' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'modules' color: (Color h: 296 s: 0.66 v: 0.85);
		addCategory: 'network' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'io' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'i2c' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'spi' color: (Color h: 225 s: 0.65 v: 0.83);
"
		addCategory: 'misc' color: (Color h: 165 s: 1 v: 0.63)
]

{ #category : #private }
MicroPythonBlockSpecs >> setupIntModuleDef [
	self addIntModuleDefNamed: 'micropython'
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> variablesBlocks [
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
