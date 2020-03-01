"
A BlockSeparatorTest is a test class for testing the behavior of BlockSeparator
"
Class {
	#name : #BlockSeparatorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
BlockSeparatorTest >> newDef [
	^ BlockSeparator new
]

{ #category : #test }
BlockSeparatorTest >> testBlock [
	| d |
	d := self newDef.
	self assert: d block equals: '-'
]

{ #category : #test }
BlockSeparatorTest >> testIsSeparator [
	self assert: self newDef isSeparator
]
