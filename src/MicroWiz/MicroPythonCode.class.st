Class {
	#name : #MicroPythonCode,
	#superclass : #MicroWizCode,
	#category : #'MicroWiz-MPython'
}

{ #category : #'control ops' }
MicroPythonCode >> doIterateBegin: aMorph [
	| list var |
	list := aMorph blockArgs first choice.
	var := aMorph blockArgs second varName.
	generator doIterateBegin: list var: var
]

{ #category : #'control ops' }
MicroPythonCode >> doIterateEnd: aMorph [
	generator doIterateEnd
]
