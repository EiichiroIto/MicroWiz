"
A MicroWizGeneratorTest is a test class for testing the behavior of MicroWizGenerator
"
Class {
	#name : #MicroWizGeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroWizGeneratorTest >> newGenerator [
	^ MicroWizGenerator new
]

{ #category : #test }
MicroWizGeneratorTest >> testAppendWithNewline [
	| g |
	g := self newGenerator.
	g appendWithNewline: 'abc'.
	g appendWithNewline: 'def'.
	self assert: g code equals: 'abc' , String lf , 'def' , String lf
]

{ #category : #test }
MicroWizGeneratorTest >> testCode [
	| g |
	g := self newGenerator.
	self assert: g code isEmpty.
	g appendWithNewline: 'abc'.
	g appendWithNewline: 'def'.
	self assert: g code equals: 'abc' , String lf , 'def' , String lf
]

{ #category : #test }
MicroWizGeneratorTest >> testExtModules [
	| g |
	g := self newGenerator.
	self assert: g extModules isCollection.
	self assert: g extModules isEmpty
]

{ #category : #test }
MicroWizGeneratorTest >> testIndent [
	| g |
	g := self newGenerator.
	self assert: g indent equals: 0.
	g indent: 1.
	self assert: g indent equals: 1.
	g indent: 2.
	self assert: g indent equals: 2
]

{ #category : #test }
MicroWizGeneratorTest >> testInitialize [
	| g |
	g := self newGenerator.
	self assert: g listVars isCollection.
	self assert: g vars isCollection
]

{ #category : #test }
MicroWizGeneratorTest >> testListVars [
	| g |
	g := self newGenerator.
	self assert: g listVars isCollection.
	self assert: g listVars isEmpty
]

{ #category : #test }
MicroWizGeneratorTest >> testNewlineString [
	| g |
	g := self newGenerator.
	self assert: g newlineString equals: String lf
]

{ #category : #test }
MicroWizGeneratorTest >> testUseListVar [
	| g |
	g := self newGenerator.
	self assert: g listVars isEmpty.
	g useListVar: 'a'.
	self assert: (g listVars includes: 'a').
	self deny: (g listVars includes: 'b')
]

{ #category : #test }
MicroWizGeneratorTest >> testUseVar [
	| g |
	g := self newGenerator.
	self assert: g vars isEmpty.
	g useVar: 'a'.
	self assert: (g vars includes: 'a').
	self deny: (g vars includes: 'b')
]

{ #category : #test }
MicroWizGeneratorTest >> testValueOf [
	| g |
	g := self newGenerator.
	self assert: (g valueOf: 'a') equals: 'a'.
	self assert: (g valueOf: 10) equals: '10'.
	self assert: (g valueOf: [10]) equals: '10'
]

{ #category : #test }
MicroWizGeneratorTest >> testVars [
	| g |
	g := self newGenerator.
	self assert: g vars isCollection.
	self assert: g vars isEmpty
]
