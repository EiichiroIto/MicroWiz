Class {
	#name : #MicroWizSexpImporter,
	#superclass : #ScratchSexpImporter,
	#category : #'MicroWiz-Converter'
}

{ #category : #private }
MicroWizSexpImporter >> importWorld: aCollection [
	aCollection first = appName
		ifFalse: [ self error ].
	aCollection second do: [ :each | project assureExistsBreed: each ].
	aCollection third do: [ :each | project assureImportModule: each ].
	self importScripts: aCollection fourth
]
