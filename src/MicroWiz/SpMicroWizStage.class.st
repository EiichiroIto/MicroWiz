Class {
	#name : #SpMicroWizStage,
	#superclass : #SpPresenter,
	#instVars : [
		'input',
		'output',
		'proxy',
		'buttonConnect',
		'buttonPortName',
		'buttonReboot',
		'buttonBreak',
		'buttonStart',
		'buttonClear',
		'morphTimer',
		'buttonBaudRate',
		'labelStatus',
		'inPasteMode'
	],
	#category : #'MicroWiz-Spec2'
}

{ #category : #specs }
SpMicroWizStage class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #buttonPortName;
				add: #buttonBaudRate;
				add: #buttonConnect;
				add: #buttonStart;
				add: #buttonBreak;
				add: #buttonReboot;
				add: #buttonClear;
				yourself)
			withConstraints: [ :c | c height: self buttonHeight ];
		add: #output;
		add:
			(SpBoxLayout newHorizontal
				spacing: 10;
				add: #morphTimer withConstraints: [ :c | c width: 5 ];
				add: #labelStatus withConstraints: [ :c | c expand: false ];
				add: #input;
				yourself)
			withConstraints: [ :c | c height: self toolbarHeight ];
		yourself
]

{ #category : #initialization }
SpMicroWizStage >> addInputShortcutsTo: anObject [
	anObject
		bindKeyCombination: Character escape
		toAction: [ self clearInput ]
]

{ #category : #private }
SpMicroWizStage >> addOutput: aString [
	| str |
	aString isEmpty
		ifTrue: [ ^ self ].
	str := self filterOutput: (aString copyWithout: Character lf).
	str isEmpty
		ifTrue: [ ^ self ].
	output text: output text , str.
	output textArea moveCursorToIndex: output text size
]

{ #category : #initialization }
SpMicroWizStage >> addOutputShortcutsTo: anObject [
	anObject
		bindKeyCombination: Character cr
		toAction: [ self pickupOutput ]
]

{ #category : #private }
SpMicroWizStage >> clearInput [
	input text: ''
]

{ #category : #private }
SpMicroWizStage >> clearOutput [
	output text: ''.
	output textArea moveCursorToIndex: output text size
]

{ #category : #serial }
SpMicroWizStage >> closePort [
	proxy ifNil: [ ^ self ].
	proxy close
]

{ #category : #accessing }
SpMicroWizStage >> comm [
	^ proxy comm
]

{ #category : #accessing }
SpMicroWizStage >> comm: aComm [
	proxy isConnected
		ifTrue: [ proxy close ].
	proxy comm: aComm
]

{ #category : #initialization }
SpMicroWizStage >> connectPresenters [
	input
		whenTextIsAcceptedDo: [ :newText | self sendInput: newText ];
		whenBuiltDo: [ :ann | self addInputShortcutsTo: ann widget ].
	output whenBuiltDo: [ :ann | self addOutputShortcutsTo: ann widget ].
	morphTimer morph: self newTimer.
	buttonPortName action: [ self selectPort ].
	buttonBaudRate action: [ self selectBaud ].
	buttonConnect
		whenActivatedDo: [ self openPort ];
		whenDeactivatedDo: [ self closePort ].
	buttonReboot action: [ self rebootDevice ].
	buttonBreak action: [ self stopProgram ].
	buttonClear action: [ self clearOutput ]
]

{ #category : #private }
SpMicroWizStage >> defaultBaudrate [
	^ 115200
]

{ #category : #private }
SpMicroWizStage >> defaultPortName [
	| list |
	proxy
		ifNotNil: [ list := proxy commOptionsNamed: #portNames.
			list notEmpty
				ifTrue: [ ^ list first ] ].
	^ 'select port'
]

{ #category : #private }
SpMicroWizStage >> defaultStepTime [
	^ 100
]

{ #category : #private }
SpMicroWizStage >> filterOutput: aString [
	| out |
	out := WriteStream on: String new.
	aString
		lineIndicesDo: [ :start :end1 :end2 | 
			| line ignore |
			line := aString copyFrom: start to: end1.
			ignore := false.
			self inPasteMode
				ifTrue: [ ignore := true.
					self inPasteMode: false ].
			(owner application suppressPaste
				and: [ line beginsWith: MicroPythonProxy pasteResponse asString ])
				ifTrue: [ ignore := true.
					end2 = end1
						ifTrue: [ self inPasteMode: true ] ].
			(owner plotter acceptPlots and: [ end2 > end1 ])
				ifTrue: [ (self plotDataFromString: line)
						ifNotEmpty: [ :list | 
							ignore := true.
							owner ifNotNil: [ owner addPlots: list ] ] ].
			ignore
				ifFalse: [ out nextPutAll: (aString copyFrom: start to: end2) ] ].
	^ out contents
]

{ #category : #private }
SpMicroWizStage >> inPasteMode [
	^ inPasteMode ifNil: [ false ]
]

{ #category : #private }
SpMicroWizStage >> inPasteMode: aBoolean [
	inPasteMode := aBoolean
]

{ #category : #initialization }
SpMicroWizStage >> initializePresenters [
	input := self newTextInput.
	output := self newCode
		withoutSyntaxHighlight;
		yourself.
	buttonPortName := self newButton
		label: self defaultPortName;
		yourself.
	buttonBaudRate := self newButton
		label: self defaultBaudrate asString;
		yourself.
	buttonConnect := self newCheckBox
		label: 'Connect';
		state: false;
		labelClickable: true;
		yourself.
	buttonReboot := self newButton
		help: 'Reboot';
		label: 'Reboot';
		icon: (self iconNamed: #refresh).
	buttonBreak := self newButton
		help: 'Stop';
		label: 'Stop';
		icon: (ScratchTheme formAt: #stopButton).
	buttonStart := self newButton
		help: 'Start';
		label: 'Start';
		icon: (ScratchTheme formAt: #goButton).
	buttonClear := self newButton
		help: 'Clear output';
		label: 'Clear';
		icon: (self iconNamed: #remove);
		yourself.
	morphTimer := self newMorph.
	labelStatus := self newLabel
		label: 'none';
		yourself.
	self focusOrder
		add: buttonPortName;
		add: buttonBaudRate;
		add: buttonConnect;
		add: buttonBreak;
		add: buttonReboot;
		add: input;
		add: output
]

{ #category : #accessing }
SpMicroWizStage >> log [
	^ output text asString
]

{ #category : #initialization }
SpMicroWizStage >> newTimer [
	^ TimerMorph new
		target: self;
		stepTime: self defaultStepTime;
		yourself
]

{ #category : #serial }
SpMicroWizStage >> openPort [
	| portName |
	proxy ifNil: [ ^ self ].
	portName := buttonPortName label asString.
	proxy
		commOption: #portName to: portName;
		commOption: #baudRate to: buttonBaudRate label asString asInteger.
	proxy open
		ifFalse: [ ^ self inform: 'cannot open open:' , portName ]
]

{ #category : #private }
SpMicroWizStage >> pickupOutput [
	| pos line |
	pos := output selectionInterval first.
	line := output pendingText asString lineCorrespondingToIndex: pos.
	line := proxy removePrompts: line.
	input
		text: line;
		selectAll;
		takeKeyboardFocus;
		hasUnacceptedEdits: true
]

{ #category : #private }
SpMicroWizStage >> plotDataFromString: aString [
	| tokens |
	tokens := ([ :c | c isSeparator or: [ c = $, ] ] split: aString)
		select: [ :each | each notEmpty ].
	(tokens allSatisfy: [ :each | each isNumberString ])
		ifFalse: [ ^ #() ].
	^ tokens
		withIndexCollect:
			[ :each :index | ScratchPlot channel: index data: each asNumberNoError ]
]

{ #category : #accessing }
SpMicroWizStage >> proxy [
	^ proxy
]

{ #category : #accessing }
SpMicroWizStage >> proxy: aProxy [
	| comm |
	comm := nil.
	proxy
		ifNotNil: [ proxy close.
			comm := proxy comm ].
	proxy := aProxy.
	comm ifNotNil: [ proxy comm: comm ]
]

{ #category : #serial }
SpMicroWizStage >> rebootDevice [
	proxy ifNil: [ ^ self ].
	proxy sendReboot
]

{ #category : #'menu actions' }
SpMicroWizStage >> selectBaud [
	| list ret |
	proxy ifNil: [ ^ self ].
	list := (proxy commOptionsNamed: #baudRate) collect: #asString.
	ret := UIManager default
		chooseFrom: list
		title: 'Select baudrate' translated.
	ret = 0
		ifTrue: [ ^ self ].
	buttonBaudRate label: (list at: ret) asString
]

{ #category : #'menu actions' }
SpMicroWizStage >> selectPort [
	| list ret |
	proxy ifNil: [ ^ self ].
	list := proxy commOptionsNamed: #portName.
	list isEmpty
		ifTrue: [ ^ self ].
	ret := UIManager default
		chooseFrom: list
		title: 'Select port' translated.
	ret = 0
		ifTrue: [ ^ self ].
	buttonPortName label: (list at: ret)
]

{ #category : #private }
SpMicroWizStage >> sendInput: aString [
	proxy ifNil: [ ^ self ].
	proxy isConnected ifFalse: [ ^ self ].
	proxy evaluate: aString.
	self clearInput
]

{ #category : #accessing }
SpMicroWizStage >> startStepping [
	morphTimer morph startStepping
]

{ #category : #stepping }
SpMicroWizStage >> step [
	proxy ifNil: [ ^ self ].
	proxy isConnected
		ifFalse: [ buttonConnect state: false.
			^ labelStatus label: 'unconnected' ].
	proxy step.
	labelStatus label: proxy status.
	self addOutput: proxy responseString
]

{ #category : #serial }
SpMicroWizStage >> stopProgram [
	proxy ifNil: [ ^ self ].
	proxy sendBreak
]

{ #category : #accessing }
SpMicroWizStage >> whenStartProgramDo: aBlock [
	buttonStart action: aBlock
]
