Class {
	#name : #ScratchTheme,
	#superclass : #Object,
	#instVars : [
		'colors',
		'forms',
		'fonts'
	],
	#classVars : [
		'CurrentTheme',
		'ThemesURL'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #fonts }
ScratchTheme class >> argFont [
	^ self fontAt: #Arg
]

{ #category : #colors }
ScratchTheme class >> blockArgColor [
	^ self colorAt: #blockArgColor
]

{ #category : #fonts }
ScratchTheme class >> buttonFont [
	^ self fontAt: #Button
]

{ #category : #accessing }
ScratchTheme class >> buttonLabel: aString selector: aSymbolOrNil [
	"Answer a big button with the given label."

	| button |
	button := ResizableToggleButton2 new
		offForm: (self formAt: #btn) onForm: (self formAt: #btnPressed);
		label: aString font: self buttonFont;
		actionSelector: aSymbolOrNil;
		labelColorOn: self labelOnColor
			labelColorOff: self labelOffColor
			labelColorOver: self labelOnColor.
	^ button
]

{ #category : #accessing }
ScratchTheme class >> colorAt: aSymbol [
	^ self current colorAt: aSymbol
]

{ #category : #accessing }
ScratchTheme class >> current [
	^ CurrentTheme ifNil: [ self error: 'Did not setup any theme yet.' ]
]

{ #category : #accessing }
ScratchTheme class >> current: aTheme [
	CurrentTheme := aTheme
]

{ #category : #colors }
ScratchTheme class >> dialogBoxTextColor [
	^ self colorAt: #dialogBoxTextColor
]

{ #category : #accessing }
ScratchTheme class >> fontAt: aSymbol [
	^ self current fontAt: aSymbol
]

{ #category : #accessing }
ScratchTheme class >> formAt: aSymbolOrString [
	^ self formAt: aSymbolOrString ifAbsent: [ self error ]
]

{ #category : #accessing }
ScratchTheme class >> formAt: aString ifAbsent: aBlock [
	^ self current formAt: aString ifAbsent: aBlock
]

{ #category : #private }
ScratchTheme class >> getThemes [
	| response ref url |
	url := self themesURL.
	url ifNil: [ self error: 'Need to set ThemesURL' ].
	response := ZnEasy get: url.
	response isSuccess
		ifFalse: [ self error: 'Cannot get Themes.zip' ].
	ref := 'Themes.zip' asFileReference.
	ref binaryWriteStream
		nextPutAll: response contents;
		close.
	(ZipArchive new readFrom: ref fullName) extractAllTo: FileLocator workingDirectory.
]

{ #category : #fonts }
ScratchTheme class >> labelFont [
	^ self fontAt: #Label
]

{ #category : #colors }
ScratchTheme class >> labelOffColor [
	^ self colorAt: #labelOffColor
]

{ #category : #colors }
ScratchTheme class >> labelOnColor [
	^ self colorAt: #labelOnColor
]

{ #category : #colors }
ScratchTheme class >> listBlockColor [
	^ self colorAt: #listBlockColor
]

{ #category : #'instance creation' }
ScratchTheme class >> newThemeNamed: aString [
	| obj |
	obj := self new.
	self setupFont: obj.
	self readForms: aString to: obj.
	^ obj
]

{ #category : #colors }
ScratchTheme class >> palettePaneColor [
	^ self colorAt: #palettePaneColor
]

{ #category : #colors }
ScratchTheme class >> plotterFrameColor [
	^ self colorAt: #plotterFrameColor
]

{ #category : #colors }
ScratchTheme class >> plotterPaneColor [
	^ self colorAt: #plotterPaneColor
]

{ #category : #private }
ScratchTheme class >> readForms: aString to: aTheme [ 
	| base dir |
	base := 'Themes' asFileReference.
	base exists
		ifFalse: [self error: 'Themes directory not found'].
	dir := base / 'common'.
	dir isDirectory
		ifFalse: [self error: 'common directory not found'].
	aTheme readFormsFrom: dir.
	dir := base / aString.
	dir isDirectory
		ifFalse: [self error: aString , ' directory not found'].
	aTheme readFormsFrom: dir.
]

{ #category : #colors }
ScratchTheme class >> scriptsPaneColor [
	^ self colorAt: #scriptsPaneColor
]

{ #category : #private }
ScratchTheme class >> setupFont: aTheme [
	aTheme fontAt: #Arg name: 'Verdana' size: 10.
	aTheme fontAt: #Label name: 'VerdanaBoldNarrowSpace' size: 10.
	aTheme fontAt: #MenuTitle name: 'VerdanaBold' size: 14.
	aTheme fontAt: #Button name: 'VerdanaBold' size: 10.
	aTheme fontAt: #Category name: 'VerdanaBold' size: 10.
	aTheme fontAt: #Tab name: 'VerdanaBold' size: 11.
	aTheme fontAt: #CommentBlock name: 'Verdana' size: 10.
	aTheme fontAt: #TalkBubble name: 'VerdanaBold' size: 12.
	aTheme fontAt: #ToolTip name: 'Verdana' size: 13.
	aTheme fontAt: #ReporterToolTip name: 'Verdana' size: 14.
	aTheme fontAt: #XYReadout name: 'Verdana' size: 10.
	aTheme fontAt: #XYReadoutBold name: 'VerdanaBold' size: 10.
	aTheme fontAt: #CostumesPage name: 'VerdanaBold' size: 11.
	aTheme fontAt: #SoundsPage name: 'VerdanaBold' size: 11.
	aTheme fontAt: #ViewerPage name: 'VerdanaBold' size: 11.
	aTheme fontAt: #UpdatingStringField name: 'VerdanaBold' size: 11.
	aTheme fontAt: #Watcher name: 'VerdanaBold' size: 10.
	aTheme fontAt: #WatcherLarge name: 'VerdanaBold' size: 14.
	aTheme fontAt: #PaintUtilityButton name: 'VerdanaBold' size: 10.
	aTheme fontAt: #PaintSetRotationCenter name: 'VerdanaBold' size: 11.
	aTheme fontAt: #LibraryItemName name: 'VerdanaBold' size: 9	.
	aTheme fontAt: #LibraryItemInfo name: 'Verdana' size: 6	.
	aTheme fontAt: #MediaItemInfo name: 'Verdana' size: 9	.
	aTheme fontAt: #DialogBoxTitle name: 'VerdanaBold' size: 14.
	aTheme fontAt: #DialogBoxMessage name: 'VerdanaBold' size: 13.
	aTheme fontAt: #DialogBoxButton name: 'VerdanaBold' size: 11.
	aTheme fontAt: #ProjectNotes name: 'Verdana' size: 10.
	aTheme fontAt: #LinkMorphDefault name: 'VerdanaBold' size: 10.
	aTheme fontAt: #ShareLink name: 'VerdanaBold' size: 13.
	aTheme fontAt: #SoundRecorderButton name: 'VerdanaBold' size: 13.
	aTheme fontAt: #SoundRecorderTimer name: 'NewYorkBold' size: 10.
	aTheme fontAt: #StringDialogTypeIn name: 'Verdana' size: 12.
	aTheme fontAt: #NewVariableDialogBox name: 'Verdana' size: 11.
	aTheme fontAt: #AboutScratch name: 'VerdanaBold' size: 11.
	aTheme fontAt: #UploadTagLabel name: 'VerdanaBold' size: 10.
	aTheme fontAt: #UploadTag name: 'Verdana' size: 10.
	aTheme fontAt: #UploadDialogLabel name: 'VerdanaBold' size: 10.
	aTheme fontAt: #UploadDialogContents name: 'Verdana' size: 10.
	aTheme fontAt: #UploadDialogComment name: 'Verdana' size: 10.
	aTheme fontAt: #FolderShortcut name: 'Verdana' size: 11.
	aTheme fontAt: #FileChooserNewFileTitle name: 'VerdanaBold' size: 10.
	aTheme fontAt: #FileChooserNewFilename name: 'Verdana' size: 10.
	aTheme fontAt: #FileChooserLabel name: 'VerdanaBold' size: 10.
	aTheme fontAt: #FileChooserContents name: 'Verdana' size: 12.
	aTheme fontAt: #FileChooserComment name: 'Verdana' size: 10.
	aTheme fontAt: #FilePickerDirectoryName name: 'VerdanaBold' size: 9	.
	aTheme fontAt: #FilePickerEntry name: 'Verdana' size: 11.
	aTheme fontAt: #FilePickerEntryHighlighted name: 'VerdanaBold' size: 11.
	aTheme fontAt: #FrameMorphProjectTitle name: 'VerdanaBold' size: 13
]

{ #category : #private }
ScratchTheme class >> setupThemeColor: aTheme [
	| systemTheme |
	systemTheme := Smalltalk ui theme.
	aTheme
		colorAt: #blockArgColor put: systemTheme backgroundColor;
		colorAt: #dialogBoxTextColor put: systemTheme textColor;
		colorAt: #labelOnColor put: Color black;
		colorAt: #labelOffColor put: Color white;
		colorAt: #listBlockColor put: (Color r: 0.85 g: 0.303 b: 0.068);
		colorAt: #plotterFrameColor put: systemTheme windowShadowColor;
		colorAt: #plotterPaneColor put: systemTheme windowColor;
		colorAt: #palettePaneColor put: systemTheme windowColor;
		colorAt: #scriptsPaneColor put: systemTheme windowColor;
		colorAt: #textColor put: systemTheme textColor;
		colorAt: #textSelectionColor put: systemTheme selectionColor
]

{ #category : #private }
ScratchTheme class >> setupThemeNamed: aString [
	| obj |
	self themeIsInstalled
		ifFalse: [ self getThemes ].
	obj := self newThemeNamed: aString.
	self setupThemeColor: obj.
	self current: obj
]

{ #category : #colors }
ScratchTheme class >> textColor [
	^ self colorAt: #textColor
]

{ #category : #colors }
ScratchTheme class >> textSelectionColor [
	^ self colorAt: #textSelectionColor
]

{ #category : #testing }
ScratchTheme class >> themeIsInstalled [
	^ 'Themes' asFileReference in: [ :ref | ref isDirectory and: [ ref entries notEmpty ] ]
]

{ #category : #accessing }
ScratchTheme class >> themesURL [
	^ ThemesURL
]

{ #category : #accessing }
ScratchTheme class >> themesURL: aString [
	ThemesURL := aString
]

{ #category : #colors }
ScratchTheme class >> variableBlockColor [
	^ Color h: 25 s: 0.88 v: 0.95
]

{ #category : #accessing }
ScratchTheme >> colorAt: aSymbol [
	^ colors at: aSymbol asSymbol
]

{ #category : #accessing }
ScratchTheme >> colorAt: aSymbol put: aColor [
	colors at: aSymbol asSymbol put: aColor
]

{ #category : #private }
ScratchTheme >> colors [
	^ colors copy
]

{ #category : #accessing }
ScratchTheme >> fontAt: aSymbol [
	^ fonts at: aSymbol
]

{ #category : #accessing }
ScratchTheme >> fontAt: aSymbol name: aString size: anInteger [
	| font |
	font := StrikeFont fontName: aString size: anInteger.
	fonts at: aSymbol put: font
]

{ #category : #accessing }
ScratchTheme >> formAt: aSymbol [
	^ forms at: aSymbol asSymbol
]

{ #category : #accessing }
ScratchTheme >> formAt: aSymbol ifAbsent: aBlock [
	^ forms at: aSymbol asSymbol ifAbsent: aBlock
]

{ #category : #accessing }
ScratchTheme >> formAt: aSymbol put: aForm [
	forms at: aSymbol asSymbol put: aForm
]

{ #category : #private }
ScratchTheme >> forms [
	^ forms copy
]

{ #category : #initialization }
ScratchTheme >> initialize [
	colors := Dictionary new.
	forms := Dictionary new.
	fonts := Dictionary new
]

{ #category : #'file read' }
ScratchTheme >> readFormsFrom: aFileReference [
	| img fn |
	aFileReference files
		do: [ :entry | 
			fn := entry fullName.
			Cursor read showWhile: [ img := [ Form fromFileNamed: fn ] ifError: [ self error	"nil" ] ].
			img ifNotNil: [ self formAt: entry base asSymbol put: img ] ].
]
