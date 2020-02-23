Class {
	#name : #SpMicroWizEditor,
	#superclass : #SpScratchEditor,
	#instVars : [
		'imageProxy'
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

{ #category : #initialization }
SpMicroWizEditor >> initializePresenters [
	super initializePresenters.
	imageProxy := self newImage
]

{ #category : #accessing }
SpMicroWizEditor >> proxy: aProxy [
	imageProxy
		image:
			(aProxy icon
				scaledToSize: self class imageWidth @ self class imageHeight)
]
