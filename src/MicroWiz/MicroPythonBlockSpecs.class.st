Class {
	#name : #MicroPythonBlockSpecs,
	#superclass : #Object,
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

{ #category : #'block specs' }
MicroPythonBlockSpecs >> blocks [
	^ self miscBlocks , self ioBlocks , self displayBlocks
		, self controlBlocks , self operatorsBlocks , self variablesBlocks
		, self sensingBlocks , self modulesBlocks
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
			('break'						-	break)
			('continue'					-	continue)
			-
			('if %b'						c	doIf)
			('if %b'						c	doIfElse)
			-
			('call %S'					s	callSub: '')
			('return %n'				-	return: 0)
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
	^ #(
		'misc'
			('print %s'								-	print: 'hello')
			('set random seed to %n'		-	setRandomSeed: 1234)
			('file names into %L'				-	listDirInto: 'list')
		)
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
	^ #(
		'sensing'
			('return value'				r	returnValue)
		)
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
