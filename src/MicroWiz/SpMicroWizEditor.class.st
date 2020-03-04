Class {
	#name : #SpMicroWizEditor,
	#superclass : #SpScratchEditor,
	#instVars : [
		'imageProxy',
		'plotter'
	],
	#category : #'MicroWiz-Spec2'
}

{ #category : #specs }
SpMicroWizEditor class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				spacing: 10;
				add: #imageProxy
					withConstraints: [ :c | c width: self imageWidth ];
				add:
					(SpBoxLayout newVertical
						add: #labelName;
						add: #labelStatus;
						yourself);
				yourself)
			withConstraints: [ :c | c height: self imageHeight ];
		add: #notebook;
		yourself
]

{ #category : #private }
SpMicroWizEditor class >> imageHeight [
	^ 48
]

{ #category : #private }
SpMicroWizEditor class >> imageWidth [
	^ 48
]

{ #category : #accessing }
SpMicroWizEditor >> addPlots: aCollection [
	self plotter
		ifNotNil: [ :morph | morph addPlots: aCollection ]
]

{ #category : #private }
SpMicroWizEditor >> createPlotterPage [
	plotter := self newMorph.
	plotter morph: self newPlotter.
	^ SpNotebookPage
		title: self plotterLabel
		icon: (self iconNamed: #morph)
		provider: [ plotter ]
]

{ #category : #initialization }
SpMicroWizEditor >> initializePresenters [
	super initializePresenters.
	imageProxy := self newImage.
	notebook addPage: self createPlotterPage
]

{ #category : #private }
SpMicroWizEditor >> newPlotter [
	^ ScratchPlotterMorph new
		maxSize: 100;
		yourself
]

{ #category : #private }
SpMicroWizEditor >> plotter [
	^ plotter morph
]

{ #category : #private }
SpMicroWizEditor >> plotterLabel [
	^ 'Plotter'
]

{ #category : #accessing }
SpMicroWizEditor >> proxy: aProxy [
	imageProxy
		image:
			(aProxy icon
				scaledToSize: self class imageWidth @ self class imageHeight)
]

{ #category : #accessing }
SpMicroWizEditor >> whenPlotterClicked: aBlock [
	self plotter whenMouseClicked: aBlock
]
