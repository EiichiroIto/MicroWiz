Class {
	#name : #MicroWizSexpExporter,
	#superclass : #ScratchSexpExporter,
	#category : #'MicroWiz-Converter'
}

{ #category : #private }
MicroWizSexpExporter >> writeHeader: aProject [
	stream
		nextPut: $(;
		nextPutAll: appName;
		nextPut: Character space.
	self writeScriptNames: aProject.
	stream nextPut: Character space.
	self writeModuleNames: aProject.
	stream
		nextPut: Character lf;
		nextPut: Character space;
		nextPut: $(
]

{ #category : #private }
MicroWizSexpExporter >> writeModuleNames: aProject [
	stream nextPut: $(.
	aProject modules
		do: [ :each | stream nextPutAll: each ]
		separatedBy: [ stream nextPut: Character space ].
	stream nextPut: $)
]
