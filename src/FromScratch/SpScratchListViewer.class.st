Class {
	#name : #SpScratchListViewer,
	#superclass : #SpPresenter,
	#instVars : [
		'categories',
		'pageViewer',
		'target'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpScratchListViewer class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #categories height: 200;
		add: #pageViewer;
		yourself
]

{ #category : #accessing }
SpScratchListViewer >> categories: aCollection [
	categories items: (aCollection collect: [ :each | each asLowercase ]) sort
]

{ #category : #initialization }
SpScratchListViewer >> connectPresenters [
	categories
		display: [ :each | each asCamelCase ];
		icons: [ :each | 
			ScratchTheme
				formAt: (each , 'Pressed') asSymbol
				ifAbsent: [ ScratchTheme formAt: #unknownPressed ] ];
		whenSelectionChangedDo: [ :each | self updateContents ]
]

{ #category : #accessing }
SpScratchListViewer >> currentCategory [
	^ categories selection selectedItem
]

{ #category : #accessing }
SpScratchListViewer >> currentCategory: aString [
	aString ifNil: [ ^ self ].
	categories selectItem: aString asLowercase
]

{ #category : #initialization }
SpScratchListViewer >> initializePresenters [
	pageViewer := self newMorph.
	pageViewer morph: (ScrollFrameMorph2 new growthFraction: 0.1).
	categories := self newList
		beSingleSelection;
		yourself
]

{ #category : #private }
SpScratchListViewer >> pageViewerContents: aMorph [
	pageViewer morph contents: aMorph
]

{ #category : #accessing }
SpScratchListViewer >> target [
	^ target
]

{ #category : #accessing }
SpScratchListViewer >> target: anObject [
	| current |
	current := self currentCategory.
	target := anObject.
	target ifNil: [ ^ self currentCategory: nil ].
	self categories: target blockCategories.
	self currentCategory: current.
	self currentCategory ifNil: [ categories selectIndex: 1 ]
]

{ #category : #private }
SpScratchListViewer >> updateContents [
	| p |
	p := self target
		ifNil: [ ScratchBlockPaletteMorph new ]
		ifNotNil: [ self target viewerPageForCategory: self currentCategory ].
	p color: ScratchTheme palettePaneColor.
	p fixLayout.
	pageViewer morph contents: p
]
