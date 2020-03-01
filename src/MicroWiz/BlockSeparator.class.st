Class {
	#name : #BlockSeparator,
	#superclass : #MicroWizBlockDef,
	#category : #'MicroWiz-Modules'
}

{ #category : #'block specs' }
BlockSeparator >> block [
	^ '-'
]

{ #category : #testing }
BlockSeparator >> isSeparator [
	^ true
]
