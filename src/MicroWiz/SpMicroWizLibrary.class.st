Class {
	#name : #SpMicroWizLibrary,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonMain',
		'buttonSelect',
		'buttonAdd',
		'buttonDelete',
		'buttonOther'
	],
	#category : #'MicroWiz-Spec2'
}

{ #category : #specs }
SpMicroWizLibrary class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #buttonMain;
		add: #buttonOther;
		add: #buttonAdd withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonSelect withConstraints: [ :c | c width: self buttonWidth ];
		add: #buttonDelete withConstraints: [ :c | c width: self buttonWidth ];
		yourself
]

{ #category : #initialization }
SpMicroWizLibrary >> initializePresenters [
	buttonMain := self newButton
		label: 'main';
		icon: (self iconNamed: #page);
		yourself.
	buttonOther := self newButton
		label: '(none)';
		icon: (self iconNamed: #page);
		yourself.
	buttonSelect := self newButton
		icon: (self iconNamed: #book);
		yourself.
	buttonAdd := self newButton
		icon: (self iconNamed: #add);
		yourself.
	buttonDelete := self newButton
		icon: (self iconNamed: #delete);
		yourself.
	self focusOrder
		add: buttonMain;
		add: buttonSelect;
		add: buttonAdd;
		add: buttonDelete
]

{ #category : #accessing }
SpMicroWizLibrary >> mainLabel [
	^ buttonMain label asString
]

{ #category : #accessing }
SpMicroWizLibrary >> otherLabel [
	^ buttonOther label asString
]

{ #category : #accessing }
SpMicroWizLibrary >> otherLabel: aString [
	buttonOther label: aString
]

{ #category : #accessing }
SpMicroWizLibrary >> selectButton: aString [
	buttonMain state: (self mainLabel = aString).
	buttonOther state: (self otherLabel = aString)
]

{ #category : #accessing }
SpMicroWizLibrary >> whenAddButtonPressed: aBlock [
	buttonAdd action: aBlock
]

{ #category : #accessing }
SpMicroWizLibrary >> whenDeleteButtonPressed: aBlock [
	buttonDelete action: aBlock
]

{ #category : #accessing }
SpMicroWizLibrary >> whenMainButtonPressed: aBlock [
	buttonMain action: aBlock
]

{ #category : #accessing }
SpMicroWizLibrary >> whenOtherButtonPressed: aBlock [
	buttonOther action: [ aBlock cull: self otherLabel ]
]

{ #category : #accessing }
SpMicroWizLibrary >> whenSelectButtonPressed: aBlock [
	buttonSelect action: aBlock
]
