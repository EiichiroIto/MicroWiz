Class {
	#name : #ULispCode,
	#superclass : #MicroWizCode,
	#category : #'MicroWiz-uLisp'
}

{ #category : #'control ops' }
ULispCode >> doWhenBegin: aMorph [
	| val |
	val := aMorph blockArgs first argString: parser.
	generator doWhenBegin: val
]

{ #category : #'control ops' }
ULispCode >> doWhenEnd: aMorph [
	generator doWhenEnd
]

{ #category : #'control ops' }
ULispCode >> withI2cBegin: aMorph [
	| var addr |
	var := aMorph blockArgs first varName.
	addr := aMorph blockArgs second argString: parser.
	generator withI2cBegin: addr var: var
]

{ #category : #'control ops' }
ULispCode >> withI2cEnd: aMorph [
	generator withI2cEnd
]
