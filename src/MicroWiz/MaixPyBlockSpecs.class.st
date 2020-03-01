Class {
	#name : #MaixPyBlockSpecs,
	#superclass : #MicroPythonBlockSpecs,
	#category : #'MicroWiz-MPython'
}

{ #category : #'argument menus' }
MaixPyBlockSpecs >> addArgBuilderTo: anArgBuilder [
	super addArgBuilderTo: anArgBuilder.
	anArgBuilder
		addChoiceArg: $P
			selector: #gpioModeNames
			target: self
			initialChoice: '';
		addChoiceArg: $p
			selector: #pixFormatNames
			target: self
			initialChoice: '';
		addChoiceArg: $F
			selector: #frameSizeNames
			target: self
			initialChoice: '';
		addChoiceArg: $c
			selector: #colorNames
			target: self
			initialChoice: ''
]

{ #category : #'argument menus' }
MaixPyBlockSpecs >> colorNames [
	^ #(RED BLACK)
]

{ #category : #'argument menus' }
MaixPyBlockSpecs >> frameSizeNames [
	^ #(QQCIF QCIF CIF QQSIF QSIF SIF QQQQVGA QQQVGA QQVGA QVGA VGA HQQQVGA HQQVGA HQVGA B64X32 B64X64 B128X64 B128X128 LCD QQVGA2 WVGA WVGA2 SVGA SXGA UXGA)
]

{ #category : #'argument menus' }
MaixPyBlockSpecs >> pixFormatNames [
	^ #(BAYER RGB565 YUV422 GRAYSCALE JPEG)
]

{ #category : #'block specs' }
MaixPyBlockSpecs >> setupBlockCategoryTo: aBlockDef [
	super setupBlockCategoryTo: aBlockDef.
	aBlockDef
		addCategory: 'display' color: (Color h: 264 s: 0.62 v: 0.89)
]

{ #category : #private }
MaixPyBlockSpecs >> setupIntModuleDef [
	super setupIntModuleDef.
	self addIntModuleDefNamed: 'maixpy'
]
