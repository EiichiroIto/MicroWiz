Class {
	#name : #SpMicroWizFrame,
	#superclass : #SpScratchFrame,
	#traits : 'TScratchPlotterMenu',
	#classTraits : 'TScratchPlotterMenu classTrait',
	#instVars : [
		'logo',
		'menu',
		'buttonSave',
		'buttonOpen'
	],
	#category : #'MicroWiz-Spec2'
}

{ #category : #specs }
SpMicroWizFrame class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #logo withConstraints: [ :c | c width: 200 ];
				add: #buttonOpen
					withConstraints: [ :c | c width: self iconWidth ];
				add: #buttonSave
					withConstraints: [ :c | c width: self iconWidth ];
				add: #menu;
				yourself)
			withConstraints: [ :c | c height: self toolbarHeight ];
		add:
			(SpBoxLayout newHorizontal
				add: #viewerPane
					withConstraints: [ :c | c width: self viewerPaneWidth ];
				add:
					(SpPanedLayout newHorizontal
						add: #editorPane;
						add:
							(SpBoxLayout newVertical
								add: #titlePane
									withConstraints: [ :c | c height: self titleButtonHeight ];
								add: #stageFrame;
								add: #libraryPane
									withConstraints: [ :c | c height: self libraryPaneHeight ];
								yourself);
						yourself);
				yourself);
		yourself
]

{ #category : #private }
SpMicroWizFrame class >> libraryPaneHeight [
	^ self buttonHeight + 10
]

{ #category : #accessing }
SpMicroWizFrame >> addPlots: aCollection [
	editorPane addPlots: aCollection
]

{ #category : #accessing }
SpMicroWizFrame >> blockMenuFor: aBlockMorph inScriptEditor: aBoolean [
	| m |
	m := self newMenu.
	m
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'start';
						action: [ aBlockMorph topBlock toggleProcess ] ] ].
	aBoolean
		ifTrue: [ self addBlockMenu: m for: aBlockMorph ].
	^ m
]

{ #category : #accessing }
SpMicroWizFrame >> comm: aComm [
	stageFrame comm: aComm
]

{ #category : #initialization }
SpMicroWizFrame >> connectPresenters [
	buttonOpen action: [ application openProject ].
	buttonSave action: [ application saveProject ].
	stageFrame whenStartProgramDo: [ application startProgram ].
	libraryPane
		whenMainButtonPressed: [ application selectScript: 'main' ];
		whenOtherButtonPressed: [ :name | application selectScript: name ];
		whenAddButtonPressed: [ application addScript ];
		whenDeleteButtonPressed: [ application deleteScript ];
		whenSelectButtonPressed: [ application selectScript ].
	editorPane
		whenPlotterClicked: [ :plotter :event | self showMenuForPlotter: plotter event: event ]
]

{ #category : #private }
SpMicroWizFrame >> defaultExtent [
	^ 1024 @ 768
]

{ #category : #private }
SpMicroWizFrame >> deviceMenu [
	| checked unchecked |
	checked := Smalltalk ui iconNamed: #smallOk.
	unchecked := Smalltalk ui iconNamed: #blank.
	^ self newMenu
		addGroup: [ :grp | 
			application proxyClasses
				do: [ :each | 
					grp
						addItem: [ :item | 
							item
								name: 'Use ' , each;
								icon: [ application proxyClass = each
										ifTrue: [ checked ]
										ifFalse: [ unchecked ] ];
								autoRefresh: true;
								action: [ application proxyClass: each ] ] ] ];
		addGroup: [ :grp | 
			application commClasses
				do: [ :each | 
					grp
						addItem: [ :item | 
							item
								name: 'Use ' , each;
								icon: [ application commClass = each
										ifTrue: [ checked ]
										ifFalse: [ unchecked ] ];
								autoRefresh: true;
								action: [ application commClass: each ] ] ] ];
		addItem: [ :item | 
			item
				name: 'Modules';
				subMenu: self moduleMenu ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Generate header';
						action: [ application withHeader: application withHeader not ];
						icon: [ application withHeader
								ifTrue: [ checked ]
								ifFalse: [ unchecked ] ];
						autoRefresh: true ];
				addItem: [ :item | 
					item
						name: 'Suppress Paste';
						action: [ application suppressPaste: application suppressPaste not ];
						icon: [ application suppressPaste
								ifTrue: [ checked ]
								ifFalse: [ unchecked ] ];
						autoRefresh: true ];
				addItem: [ :item | 
					item
						name: 'Upload program';
						action: [ application uploadProgram ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Upload file';
						icon: (self iconNamed: #up);
						action: [ application uploadFile ] ];
				addItem: [ :item | 
					item
						name: 'Download file';
						icon: (self iconNamed: #down);
						action: [ application downloadFile ] ];
				addItem: [ :item | 
					item
						name: 'Delete file';
						icon: (self iconNamed: #delete);
						action: [ application deleteFile ] ] ];
		yourself
]

{ #category : #private }
SpMicroWizFrame >> exportMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Export S-expression';
				action: [ application exportSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Export MicroPython';
				action: [ application exportMicroPython ] ];
		addItem: [ :item | 
			item
				name: 'Export REPL log';
				action: [ application exportReplLog ] ];
		yourself
]

{ #category : #private }
SpMicroWizFrame >> fileMenu [
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New';
						action: [ application newProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Open';
						action: [ application openProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Project Notes';
						action: [ application editNotes ] ];
				addItem: [ :item | 
					item
						name: 'Save';
						action: [ application saveProjectNoDialog ] ];
				addItem: [ :item | 
					item
						name: 'Save As';
						action: [ application saveProject ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Import';
						subMenu: self importMenu ];
				addItem: [ :item | 
					item
						name: 'Export';
						subMenu: self exportMenu ] ];
		addItem: [ :item | 
			item
				name: 'Close';
				action: [ application close ];
				enabled: [ application class dontClose not ] ];
		addItem: [ :item | 
			item
				name: 'Quit';
				action: [ application quit ] ];
		yourself
]

{ #category : #private }
SpMicroWizFrame >> helpMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'About ' , application appName;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart';
				action: [ stageFrame startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect';
				action: [ application inspect ] ];
		addItem: [ :item | 
			item
				name: 'Settings';
				subMenu: self settingsMenu ];
		yourself
]

{ #category : #private }
SpMicroWizFrame >> importMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import S-expression';
				action: [ application importSexpCode ] ];
		yourself
]

{ #category : #initialization }
SpMicroWizFrame >> initializePresenters [
	logo := self newImage
		image: (ScratchTheme formAt: #logo);
		yourself.
	buttonOpen := self newButton
		icon: (ScratchTheme formAt: #openButton);
		help: 'Open project';
		yourself.
	buttonSave := self newButton
		icon: (ScratchTheme formAt: #saveButton);
		help: 'Save this project';
		yourself.
	menu := self newMenuBar.
	self setupMenu.
	viewerPane := self instantiate: SpScratchListViewer.
	editorPane := self instantiate: SpMicroWizEditor.
	titlePane := self instantiate: SpScratchTitle.
	libraryPane := self instantiate: SpScratchLibrary.
	stageFrame := self instantiate: SpMicroWizStage.
	self focusOrder add: editorPane
]

{ #category : #private }
SpMicroWizFrame >> moduleMenu [
	| checked unchecked |
	checked := Smalltalk ui iconNamed: #smallOk.
	unchecked := Smalltalk ui iconNamed: #blank.
	^ self newMenu
		addGroup: [ :grp | 
			grp autoRefresh: true.
			application availableModuleNames
				do: [ :each | 
					grp
						addItem: [ :item | 
							item
								name: each;
								icon: [ (application moduleInUse: each)
										ifTrue: [ checked ]
										ifFalse: [ unchecked ] ];
								autoRefresh: true;
								action: [ application toggleModule: each ] ] ] ];
		addGroup: [ :grp | 
			application availableModuleNames
				do: [ :each | 
					grp
						addItem: [ :item | 
							item
								name: 'Upload ' , each;
								action: [ application uploadModule: each ] ] ] ];
		yourself
]

{ #category : #accessing }
SpMicroWizFrame >> otherLabel: aString [
	libraryPane otherLabel: aString
]

{ #category : #accessing }
SpMicroWizFrame >> plotter [
	^ editorPane plotter
]

{ #category : #accessing }
SpMicroWizFrame >> proxy [
	^ stageFrame proxy
]

{ #category : #accessing }
SpMicroWizFrame >> proxy: aProxy [
	stageFrame proxy: aProxy.
	editorPane proxy: aProxy.
	self updateViewer
]

{ #category : #accessing }
SpMicroWizFrame >> replLog [
	^ stageFrame log
]

{ #category : #initialization }
SpMicroWizFrame >> setupMenu [
	menu
		addItem: [ :item | 
			item
				name: 'File';
				subMenu: self fileMenu ];
		addItem: [ :item | 
			item
				name: 'Device';
				subMenu: self deviceMenu ];
		addItem: [ :item | 
			item
				name: 'Help';
				subMenu: self helpMenu ].
	menu applyTo: self
]

{ #category : #private }
SpMicroWizFrame >> stageShotExtent: size [
	^ self proxy icon scaledToSize: size
]

{ #category : #accessing }
SpMicroWizFrame >> status: aString [
	editorPane status: aString
]

{ #category : #accessing }
SpMicroWizFrame >> updateDisplay [
	"do nothing"
]

{ #category : #accessing }
SpMicroWizFrame >> updateViewer [
	viewerPane target: viewerPane target
]
