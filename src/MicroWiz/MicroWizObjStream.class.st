Class {
	#name : #MicroWizObjStream,
	#superclass : #ObjStream,
	#category : #'MicroWiz-Project'
}

{ #category : #'class initialization' }
MicroWizObjStream class >> initialize [
	"MicroWizObjStream initialize"
	self setupVariables
]

{ #category : #private }
MicroWizObjStream class >> userClasses [
	^ super userClasses, #(
		"id		class"
		(111		MicroWizProject)
		(112		MicroWizScript)
	)
]

{ #category : #'entry points' }
MicroWizObjStream >> readObjFrom: aStream showProgress: aBoolean [
	| str |
	str := aStream upToEnd asString.
	^ STON fromString: str
]

{ #category : #'entry points' }
MicroWizObjStream >> storeObj: anObject on: aStream [
	| str |
	str := STON toString: anObject.
	aStream nextPutAll: str asByteArray
]
