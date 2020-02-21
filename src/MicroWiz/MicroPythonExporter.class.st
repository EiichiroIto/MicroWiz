Class {
	#name : #MicroPythonExporter,
	#superclass : #ScratchExporter,
	#category : #'MicroWiz-Converter'
}

{ #category : #private }
MicroPythonExporter >> writeFooter: aProject [
	"do nothing"
]

{ #category : #private }
MicroPythonExporter >> writeHeader: aProject [
	"do nothing"
]

{ #category : #private }
MicroPythonExporter >> writeScript: aScript [
	| project application code name |
	project := aScript project.
	application := project application.
	name := aScript objName.
	code := application newCode parseHats: aScript hatBlocks.
	stream nextPutAll: code
]
