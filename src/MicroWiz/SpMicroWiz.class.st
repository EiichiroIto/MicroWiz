Class {
	#name : #SpMicroWiz,
	#superclass : #SpScratchApp,
	#instVars : [
		'withHeader'
	],
	#category : #'MicroWiz-Spec2'
}

{ #category : #accessing }
SpMicroWiz class >> appFolderName [
	^ 'microwiz'
]

{ #category : #accessing }
SpMicroWiz class >> appName [
	^ 'MicroWiz'
]

{ #category : #accessing }
SpMicroWiz class >> extension [
	^ 'mw'
]

{ #category : #'class initialization' }
SpMicroWiz class >> initialize [
	"SpMicroWiz initialize"
	ScratchDirectory current appName: self appFolderName.
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName
]

{ #category : #accessing }
SpMicroWiz class >> inputFlowControlType [
	^ self settings at: #inputFlowControlType ifAbsentPut: [ 0 ]
]

{ #category : #accessing }
SpMicroWiz class >> inputFlowControlType: aNumber [
	self settings at: #inputFlowControlType put: aNumber
]

{ #category : #'world menu' }
SpMicroWiz class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self appName asSymbol)
		order: 0.5;
		target: self;
		action: [self new open]; 
		parent: #Tools;
		icon: self icon
]

{ #category : #accessing }
SpMicroWiz class >> optionsFor: aSymbol [
	aSymbol = #inputFlowControlType
		ifTrue: [ ^ #(0 1 2) ].
	aSymbol = #outputFlowControlType
		ifTrue: [ ^ #(0 1 2) ].
	^ super optionsFor: aSymbol
]

{ #category : #accessing }
SpMicroWiz class >> outputFlowControlType [
	^ self settings at: #outputFlowControlType ifAbsentPut: [ 0 ]
]

{ #category : #accessing }
SpMicroWiz class >> outputFlowControlType: aNumber [
	self settings at: #outputFlowControlType put: aNumber
]

{ #category : #private }
SpMicroWiz class >> themesURL [
	^ 'https://raw.githubusercontent.com/EiichiroIto/MicroWiz/master/Themes.zip'
]

{ #category : #private }
SpMicroWiz >> aboutAppString [
	^ self appName
		,
			'
Copyright © 2020 Eiichiro Ito (ghc02331@nifty.com)
All rights reserved.

Based on Scratch from the MIT Media Lab, v' , self basedVersion
		,
			'
Copyright © 2009 Massachusetts Institute of Technology.
All rights reserved.
'
]

{ #category : #'menu actions' }
SpMicroWiz >> addScript [
	| name script |
	name := UIManager default
		request: 'Enter script name' localized
		initialAnswer: ''.
	(name isNil or: [ name isEmpty ])
		ifTrue: [ ^ self ].
	(project findObjName: name)
		ifNotNil: [ ^ self inform: 'Already exists' localized ].
	script := project addScriptNamed: name.
	presenter
		otherLabel: name;
		target: script
]

{ #category : #accessing }
SpMicroWiz >> availableModuleNames [
	^ MicroWizProject availableModuleNames
]

{ #category : #private }
SpMicroWiz >> backupProject [
	"do nothing"
]

{ #category : #accessing }
SpMicroWiz >> comm [
	^ self proxy ifNotNil: [ :p | p comm ]
]

{ #category : #accessing }
SpMicroWiz >> commClass [
	^ self comm class name
]

{ #category : #accessing }
SpMicroWiz >> commClass: aSymbol [
	project commClass: aSymbol.
	presenter comm: (Smalltalk at: aSymbol) new.
	self updateStatus
]

{ #category : #accessing }
SpMicroWiz >> commClasses [
	^ #(SerialComm DummyComm)
]

{ #category : #private }
SpMicroWiz >> confirmCode: aString title: aTitleString [
	^ UIManager default
		multiLineRequest: aTitleString
		initialAnswer: aString
		answerHeight: 450
]

{ #category : #private }
SpMicroWiz >> createProject [
	^ MicroWizProject new
		proxyClass: self defaultProxyClass;
		commClass: self defaultCommClass;
		yourself
]

{ #category : #private }
SpMicroWiz >> defaultCommClass [
	^ self commClasses first
]

{ #category : #private }
SpMicroWiz >> defaultProxyClass [
	^ self proxyClasses first
]

{ #category : #'menu actions' }
SpMicroWiz >> deleteFile [
	| file |
	file := nil.
	UIManager default
		showWaitCursorWhile: [ file := self selectRemoteFile ].
	file ifNil: [ ^ self ].
	UIManager default
		showWaitCursorWhile: [ self proxy deleteFileNamed: file ]
]

{ #category : #'menu actions' }
SpMicroWiz >> deleteScript [
	| list index name script |
	list := self otherScriptNames.
	list isEmpty
		ifTrue: [ ^ self ].
	list size = 1
		ifTrue: [ index := 1 ]
		ifFalse: [ index := UIManager default
				chooseFrom: list
				title: 'Select script name to delete' localized.
			index = 0
				ifTrue: [ ^ self ] ].
	name := list at: index.
	(self confirm: 'Delete script? - ' localized , name)
		ifFalse: [ ^ self ].
	script := project findObjName: name.
	project deleteScript: script.
	presenter
		otherLabel: '(none)';
		target: project scripts first
]

{ #category : #'menu actions' }
SpMicroWiz >> downloadFile [
	| file code |
	file := nil.
	UIManager default
		showWaitCursorWhile: [ file := self selectRemoteFile ].
	file ifNil: [ ^ self ].
	code := nil.
	UIManager default
		showWaitCursorWhile: [ code := self proxy getFileNamed: file timeout: 10000 ].
	(code isNil or: [ code isEmpty ])
		ifTrue: [ ^ self ].
	code := MicroPythonParser new parse: code.
	code := self confirmCode: code title: 'OK to save, or cancel'.
	code ifNil: [ ^ self ].
	self exportString: code extension: self pyExtension
]

{ #category : #processes }
SpMicroWiz >> evaluateFor: aTopBlock [
	| code |
	self stopAllProcesses.
	code := self newCode parse: aTopBlock withHeader: self withHeader.
	code isEmpty
		ifTrue: [ ^ nil ].
	self proxy readyToSend
		ifFalse: [ self showCode: code title: 'generated expression' localized.
			^ nil ].
	^ self proxy evaluate: code timeout: 3000
]

{ #category : #private }
SpMicroWiz >> execute: aString [
	self proxy
		in: [ :pr | 
			pr ifNil: [ ^ self ].
			pr readyToSend
				ifFalse: [ ^ self inform: 'not connected' localized ].
			pr execute: aString ]
]

{ #category : #'menu actions' }
SpMicroWiz >> exportMicroPython [
	self export: MicroPythonExporter new extension: self mpyExtension
]

{ #category : #'menu actions' }
SpMicroWiz >> exportReplLog [
	| log |
	log := presenter replLog.
	log isEmpty ifTrue: [ ^ self ].
	self exportString: log extension: self txtExtension
]

{ #category : #'menu actions' }
SpMicroWiz >> exportSexpCode [
	self export: (MicroWizSexpExporter appName: self appName) extension: self sexpExtension
]

{ #category : #'menu actions' }
SpMicroWiz >> importSexpCode [
	self import: (MicroWizSexpImporter appName: self appName) extension: self sexpExtension
]

{ #category : #private }
SpMicroWiz >> installNewProject: aProject [
	self stopAllProcesses.
	project := aProject.
	project application: self.
	presenter
		proxy: (Smalltalk at: project proxyClass) new;
		comm: (Smalltalk at: project commClass) new;
		otherLabel: '(none)'.
	"project fixVars.
	project updateLabels."
	self setupView.
	Smalltalk garbageCollect.
	project modified: false
]

{ #category : #testing }
SpMicroWiz >> moduleInUse: aString [
	^ project ifNil: [ false ] ifNotNil: [ project moduleInUse: aString ]
]

{ #category : #private }
SpMicroWiz >> mpyExtension [
	^ 'py'
]

{ #category : #private }
SpMicroWiz >> newCode [
	^ self proxy newCode
]

{ #category : #private }
SpMicroWiz >> newPresenter [
	MicroWizProject setupAvailableModules.
	^ SpMicroWizFrame basicNew
		application: self;
		initialize;
		yourself
]

{ #category : #private }
SpMicroWiz >> otherScriptNames [
	^ 	(project scripts collect: #objName) copyWithout: 'main'
]

{ #category : #accessing }
SpMicroWiz >> proxy [
	^ presenter proxy
]

{ #category : #accessing }
SpMicroWiz >> proxyClass [
	^ self proxy class name
]

{ #category : #accessing }
SpMicroWiz >> proxyClass: aSymbol [
	| comm newProxy |
	comm := self comm.
	project proxyClass: aSymbol.
	newProxy := (Smalltalk at: aSymbol) new.
	comm ifNotNil: [ newProxy comm: comm ].
	project updateBlockDefs.
	presenter proxy: newProxy.
	self updateStatus
]

{ #category : #accessing }
SpMicroWiz >> proxyClasses [
	^ #(MicroPythonProxy MicrobitProxy ESP8266Proxy MaixPyProxy)
]

{ #category : #private }
SpMicroWiz >> pyExtension [
	^ 'py'
]

{ #category : #'menu actions' }
SpMicroWiz >> quit [
	(self confirm: 'Quit Application?' translated)
		ifFalse: [ ^ self ].
	Smalltalk snapshot: false andQuit: true
]

{ #category : #private }
SpMicroWiz >> restoreProject [
	"do nothing"
]

{ #category : #'menu actions' }
SpMicroWiz >> selectMain [
	presenter target: (project findObjName: 'main')
]

{ #category : #'menu actions' }
SpMicroWiz >> selectOther: aString [
	| script |
	script := project findObjName: aString.
	script ifNil: [ ^ self ].
	presenter target: script
]

{ #category : #private }
SpMicroWiz >> selectRemoteFile [
	| choices ret |
	choices := self proxy getDirectory.
	(choices isNil or: [ choices isEmpty ])
		ifTrue: [ ^ nil ].
	ret := UIManager default
		chooseFrom: choices
		title: 'Select file to remove' localized.
	ret = 0
		ifTrue: [ ^ nil ].
	^ choices at: ret
]

{ #category : #'menu actions' }
SpMicroWiz >> selectScript [
	| list index name script |
	list := self otherScriptNames.
	list isEmpty
		ifTrue: [ ^ self ].
	list size = 1
		ifTrue: [ index := 1 ]
		ifFalse: [ index := UIManager default
				chooseFrom: list
				title: 'Select script to view' localized.
			index = 0
				ifTrue: [ ^ self ] ].
	name := list at: index.
	script := project findObjName: name.
	presenter
		otherLabel: script objName;
		target: script
]

{ #category : #private }
SpMicroWiz >> setupView [
	super setupView.
	self updateStatus
]

{ #category : #private }
SpMicroWiz >> sexpExtension [
	^ 'mws'
]

{ #category : #private }
SpMicroWiz >> showCode: aString title: aTitleString [
	UIManager default longMessage: aString title: aTitleString
]

{ #category : #processes }
SpMicroWiz >> startProcessFor: topBlock [
	| coder code |
	self stopAllProcesses.
	coder := self newCode.
	code := coder parse: topBlock withHeader: self withHeader.
	code isEmpty
		ifTrue: [ ^ nil ].
	self proxy readyToSend
		ifFalse: [ ^ self showCode: code title: 'generated program' localized ].
	process := self proxy newProcess
		topBlock: topBlock;
		yourself.
	self proxy execute: code.
	^ process
]

{ #category : #'menu actions' }
SpMicroWiz >> startProgram [
	| code |
	code := self newCode parseHats: self target hatBlocks.
	code := self confirmCode: code title: 'OK to send, or cancel' localized.
	code ifNil: [ ^ self ].
	self execute: code
]

{ #category : #'menu actions' }
SpMicroWiz >> toggleModule: aString [
	project toggleModule: aString.
	presenter updateViewer
]

{ #category : #private }
SpMicroWiz >> txtExtension [
	^ 'txt'
]

{ #category : #processes }
SpMicroWiz >> updateInfo [
	"do nothing"
]

{ #category : #private }
SpMicroWiz >> updateStatus [
	| str |
	str := ' (', self proxyClass asString, ')'.
	str := str , ' (', self commClass asString , ')'.
	presenter status: str
]

{ #category : #'menu actions' }
SpMicroWiz >> uploadFile [
	| pair filename |
	self proxy readyToSend
		ifFalse: [ ^ self inform: 'not connected' localized ].
	pair := self importFileWithExtension: self pyExtension.
	pair ifNil: [ ^ self ].
	filename := UIManager default
		request: 'Upload file name?' localized
		initialAnswer: pair second basename.
	(filename isNil or: [ filename isEmpty ])
		ifTrue: [ ^ self ].
	self proxy putFileNamed: filename contents: pair first
]

{ #category : #'menu actions' }
SpMicroWiz >> uploadModule: aString [
	| file |
	file := project moduleFileFor: aString.
	file ifNil: [ ^ self inform: 'no module files' localized ].
	(self confirm: 'upload module file?' localized)
		ifFalse: [ ^ self ].
	self proxy readyToSend
		ifFalse: [ ^ self inform: 'not connected' localized ].
	self proxy putFileNamed: file basename contents: file contents
]

{ #category : #'menu actions' }
SpMicroWiz >> uploadProgram [
	(self confirm: 'send all program?' localized)
		ifFalse: [ ^ self ].
	self proxy readyToSend
		ifFalse: [ ^ self inform: 'not connected' localized ].
	project scripts
		do: [ :each | 
			| code |
			code := self newCode parseHats: each hatBlocks.
			code isEmpty
				ifFalse: [ self proxy
						putFileNamed: each objName , '.' , self pyExtension
						contents: code ] ]
]

{ #category : #accessing }
SpMicroWiz >> withHeader [
	^ withHeader ifNil: [ true ]
]

{ #category : #accessing }
SpMicroWiz >> withHeader: aBoolean [
	withHeader := aBoolean
]
