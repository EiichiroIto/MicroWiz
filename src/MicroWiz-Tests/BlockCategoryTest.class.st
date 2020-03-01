"
A BlockCategoryTest is a test class for testing the behavior of BlockCategory
"
Class {
	#name : #BlockCategoryTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
BlockCategoryTest >> newDef [
	^ BlockCategory new
]

{ #category : #test }
BlockCategoryTest >> testBlock [
	| d |
	d := self newDef.
	d categoryName: 'abc'.
	self assert: d block equals: 'abc'
]

{ #category : #test }
BlockCategoryTest >> testCategoryName [
	| d |
	d := self newDef.
	self assert: d categoryName isNil.
	d categoryName: 'abc'.
	self assert: d categoryName equals: 'abc'.
	d categoryName: 'def'.
	self assert: d categoryName equals: 'def'
]

{ #category : #test }
BlockCategoryTest >> testIsCategory [
	self assert: self newDef isCategory
]
