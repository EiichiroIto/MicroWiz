Class {
	#name : #MicrobitProxy,
	#superclass : #MicroPythonProxy,
	#category : #'MicroWiz-Microbit'
}

{ #category : #api }
MicrobitProxy >> icon [
	^ ScratchTheme formAt: #microbit
]

{ #category : #api }
MicrobitProxy >> newBlockSpecs [
	^ MicrobitBlockSpecs new
]

{ #category : #api }
MicrobitProxy >> newCode [
	^ MicroWizCode new
		generator: MicrobitGenerator new;
		yourself
]
