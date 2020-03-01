"
A MicroWizBlockDefTest is a test class for testing the behavior of MicroWizBlockDef
"
Class {
	#name : #MicroWizBlockDefTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroWizBlockDefTest >> newDef [
	^ MicroWizBlockDef new
]

{ #category : #test }
MicroWizBlockDefTest >> testIsBlockDef [
	self deny: self newDef isBlockDef
]

{ #category : #test }
MicroWizBlockDefTest >> testIsCategory [
	self deny: self newDef isCategory
]

{ #category : #test }
MicroWizBlockDefTest >> testIsReporter [
	self deny: self newDef isReporter
]

{ #category : #test }
MicroWizBlockDefTest >> testIsSeparator [
	self deny: self newDef isSeparator
]
