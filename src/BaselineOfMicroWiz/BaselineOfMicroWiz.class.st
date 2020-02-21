Class {
	#name : #BaselineOfMicroWiz,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicroWiz
}

{ #category : #baselines }
BaselineOfMicroWiz >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'FromScratch';
				package: 'MicroWiz' with: [ spec requires: #('FromScratch') ] ]
]
