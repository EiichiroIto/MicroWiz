"
An ULispGeneratorTest is a test class for testing the behavior of ULispGenerator
"
Class {
	#name : #ULispGeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ULispGeneratorTest >> newGenerator [
	^ ULispGenerator new
]

{ #category : #test }
ULispGeneratorTest >> testBinaryFunctionArg1Arg2 [
	| g ret |
	g := self newGenerator.
	ret := g binaryFunction: 'a' arg1: 'x' arg2: 'y'.
	self assert: ret equals: '(a x y)'
]

{ #category : #test }
ULispGeneratorTest >> testDoForeverBegin [
	| g |
	g := self newGenerator.
	g doForeverBegin.
	self assert: g code equals: '(loop' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoForeverEnd [
	| g |
	g := self newGenerator.
	g doForeverEnd.
	self assert: g code equals: ')' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoIfBegin [
	| g |
	g := self newGenerator.
	g doIfBegin: [ 'test' ].
	self assert: g code equals: '(if test (progn ' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoIfElse [
	| g |
	g := self newGenerator.
	g doIfElse.
	self assert: g code equals: ') (progn' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoIfEnd [
	| g |
	g := self newGenerator.
	g doIfEnd.
	self assert: g code equals: '))' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoRepeatBeginVar [
	| g |
	g := self newGenerator.
	g doRepeatBegin: 5 var: 'x'.
	self assert: g code equals: '(dotimes (x 5)' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoRepeatEnd [
	| g |
	g := self newGenerator.
	g doRepeatEnd.
	self assert: g code equals: ')' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoWhenBegin [
	| g |
	g := self newGenerator.
	g doWhenBegin: [ 'test' ].
	self assert: g code equals: '(when test' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testDoWhenEnd [
	| g |
	g := self newGenerator.
	g doWhenEnd.
	self assert: g code equals: ')' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testGenerateIndent [
	| g |
	g := self newGenerator.
	g generateIndent: 5.
	self assert: g code equals: '     '
]

{ #category : #test }
ULispGeneratorTest >> testGeneratePass [
	| g |
	g := self newGenerator.
	g generatePass.
	self assert: g code isEmpty
]

{ #category : #test }
ULispGeneratorTest >> testLiteralStringFrom [
	| g ret |
	g := self newGenerator.
	ret := g literalStringFrom: 'x'.
	self assert: ret equals: '"x"'.
	ret := g literalStringFrom: '123'.
	self assert: ret equals: '123'.
	ret := g literalStringFrom: 456.
	self assert: ret equals: '456'
]

{ #category : #test }
ULispGeneratorTest >> testLocalVarArgString [
	| g ret |
	g := self newGenerator.
	ret := g localVarArgString: 'x'.
	self assert: ret equals: 'x'.
	ret := g localVarArgString: 'y'.
	self assert: ret equals: 'y'
]

{ #category : #test }
ULispGeneratorTest >> testQuotedString [
	| g ret |
	g := self newGenerator.
	ret := g quotedString: 'nil'.
	self assert: ret equals: 'nil'.
	ret := g quotedString: 't'.
	self assert: ret equals: 't'.
	ret := g quotedString: 'x'.
	self assert: ret equals: '"x"'
]

{ #category : #test }
ULispGeneratorTest >> testStopThread [
	| g |
	g := self newGenerator.
	g stopThread.
	self assert: g code isEmpty
]

{ #category : #test }
ULispGeneratorTest >> testUnaryFunctionArg [
	| g ret |
	g := self newGenerator.
	ret := g unaryFunction: 'a' arg: 'x'.
	self assert: ret equals: '(a x)'
]

{ #category : #test }
ULispGeneratorTest >> testWithI2cBeginVar [
	| g |
	g := self newGenerator.
	g withI2cBegin: 5 var: 'x'.
	self assert: g code equals: '(with-i2c (x 5)' , String lf
]

{ #category : #test }
ULispGeneratorTest >> testWithI2cEnd [
	| g |
	g := self newGenerator.
	g withI2cEnd.
	self assert: g code equals: ')' , String lf
]
