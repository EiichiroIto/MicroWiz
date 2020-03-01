Class {
	#name : #MicroWizBlockDef,
	#superclass : #Object,
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
MicroWizBlockDef >> block [
	self subclassResponsibility
]

{ #category : #api }
MicroWizBlockDef >> blockTuple [
	^ self block
]

{ #category : #testing }
MicroWizBlockDef >> isBlockDef [
	^ false
]

{ #category : #testing }
MicroWizBlockDef >> isCategory [
	^ false
]

{ #category : #testing }
MicroWizBlockDef >> isReporter [
	^ false
]

{ #category : #testing }
MicroWizBlockDef >> isSeparator [
	^ false
]
