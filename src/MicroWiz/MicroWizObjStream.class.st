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
