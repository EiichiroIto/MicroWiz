Class {
	#name : #ULispBlockSpecs,
	#superclass : #MicroWizBlockSpecs,
	#category : #'MicroWiz-uLisp'
}

{ #category : #'argument menus' }
ULispBlockSpecs >> addArgBuilderTo: anArgBuilder [
	super addArgBuilderTo: anArgBuilder.
	anArgBuilder
		addNumberExpressArg: $P
			selector: #gpioModeNames
			target: self
			initialExpression: '0'
]

{ #category : #'argument menus' }
ULispBlockSpecs >> gpioModeNames [
	^ #((INPUT 0) (OUTPUT 1) (INPUT_PULLUP 2))
]

{ #category : #'argument menus' }
ULispBlockSpecs >> setupBlockCategoryTo: aBlockDef [
	aBlockDef
		addCategory: 'io' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'misc' color: (Color h: 165 s: 1 v: 0.63)
]

{ #category : #private }
ULispBlockSpecs >> setupIntModuleDef [
	intModuleDef := nil.
	self addIntModuleDefNamed: 'ulisp'
]
