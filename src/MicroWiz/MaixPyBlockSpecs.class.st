Class {
	#name : #MaixPyBlockSpecs,
	#superclass : #MicroPythonBlockSpecs,
	#category : #'MicroWiz-MPython'
}

{ #category : #'argument menus' }
MaixPyBlockSpecs >> colorNames [
	^ #(RED BLACK)
]

{ #category : #'block specs' }
MaixPyBlockSpecs >> displayBlocks [
	^ super displayBlocks , #(
		'display'
			('init lcd'								-		lcdInit)
			('lcd rotation %d'					-		lcdRotation: 2)
			('lcd image %s'						-		lcdDisplay:)
			('lcd text %s at %n , %n fg %c bg %c'
															-		lcdDrawString:x:y:fg:bg:
																	'hello' 100 100 'RED' 'BLACK')
			('lcd clear'							-		lcdClear)
			('deinit lcd'							-		lcdDeinit)
	)
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
MaixPyBlockSpecs >> sensingBlocks [
	^ super sensingBlocks , #(
		'sensing'
			-
			('reset sensor'						-		sensorReset)
			('set pixformat %p'				-		sensorSetPixFormat:	'RGB565')
			('set framesize %F'				-		sensorSetFrameSize:	'QVGA')
			('set vflip %b'						-		sensorSetVFlip: 			)
			('sensor run %n'						-		sensorRun: 					1)
			('sensor snapshot'					r		sensorSnapshot)
		)
]

{ #category : #'argument menus' }
MaixPyBlockSpecs >> uncoloredArgMorphFor: specString ifAbsent: aBlock [
	| code |
	"exclude: befLmnSsv"
	code := specString at: 2.
	$P = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #gpioModeNames;
				getOptionsTarget: self;
				yourself ].
	$p = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #pixFormatNames;
				getOptionsTarget: self;
				yourself ].
	$F = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #frameSizeNames;
				getOptionsTarget: self;
				yourself ].
	$c = code
		ifTrue: [ ^ ChoiceArgMorph new
				getOptionsSelector: #colorNames;
				getOptionsTarget: self;
				yourself ].
	^ super uncoloredArgMorphFor: specString ifAbsent: aBlock
]
