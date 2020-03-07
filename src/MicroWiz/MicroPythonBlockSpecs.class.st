Class {
	#name : #MicroPythonBlockSpecs,
	#superclass : #MicroWizBlockSpecs,
	#category : #'MicroWiz-MPython'
}

{ #category : #'block specs' }
MicroPythonBlockSpecs >> blocks [
	^ self ioBlocks , self displayBlocks
		, self controlBlocks , self operatorsBlocks , self variablesBlocks
		, self sensingBlocks , self modulesBlocks, self intModuleBlocks
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> displayBlocks [
	^ #()
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> ioBlocks [
	^ #()
]

{ #category : #'block specs' }
MicroPythonBlockSpecs >> operatorsBlocks [
	^ #(
		'operators'
			('%n + %n'							r	+ - -)
			('%n - %n'							r	- - -)
			('%n * %n'							r	* - -)
			('%n / %n'							r	/ - -)
			('- %n'									r	negated: 1)
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
			('%n mod %n'						r	\\ - -)
			('round %n'							r	rounded -)
			('abs %n'								r	abs -)
			('abs %n sign %n'			r	abs:sign:	- -)
			('pick random %n to %n'		r	randomFrom:to: 1 10)
			('%f of %n'							r	computeFunction:of: 'sqrt' 10)
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
	intModuleDef := nil.
	self addIntModuleDefNamed: 'micropython'
]
