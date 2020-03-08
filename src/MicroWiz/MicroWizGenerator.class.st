Class {
	#name : #MicroWizGenerator,
	#superclass : #Object,
	#instVars : [
		'extModules',
		'indent',
		'listVars',
		'stream',
		'vars'
	],
	#category : #'MicroWiz-Core'
}

{ #category : #private }
MicroWizGenerator >> appendWithNewline: aString [
	stream
		nextPutAll: aString;
		nextPutAll: self newlineString
]

{ #category : #accessing }
MicroWizGenerator >> code [
	^ stream contents
]

{ #category : #'control ops' }
MicroWizGenerator >> doForeverBegin [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doForeverEnd [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doIfBegin: cond [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doIfElse [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doIfEnd [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doRepeatBegin: aNumber var: aString [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doRepeatEnd [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doUntilBegin: cond [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doUntilEnd [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doWhileBegin: cond [
	self subclassResponsibility
]

{ #category : #'control ops' }
MicroWizGenerator >> doWhileEnd [
	self subclassResponsibility
]

{ #category : #private }
MicroWizGenerator >> extModules [
	^ extModules
]

{ #category : #'code generator' }
MicroWizGenerator >> generateExtCode: aSymbol arguments: aCollection for: aScript [
	self subclassResponsibility
]

{ #category : #'code generator' }
MicroWizGenerator >> generateHeader [
	self indent: 0
]

{ #category : #'code generator' }
MicroWizGenerator >> generateIntCode: aSymbol arguments: aCollection for: aScript [
	self subclassResponsibility
]

{ #category : #accessing }
MicroWizGenerator >> header [
	stream := WriteStream on: String new.
	self generateHeader.
	^ stream contents
]

{ #category : #accessing }
MicroWizGenerator >> indent [
	^ indent
]

{ #category : #accessing }
MicroWizGenerator >> indent: anInteger [
	indent := anInteger
]

{ #category : #initialization }
MicroWizGenerator >> initialize [
	super initialize.
	stream := WriteStream on: String new.
	extModules := Set new.
	listVars := Set new.
	vars := Set new.
	indent := 0
]

{ #category : #private }
MicroWizGenerator >> listVars [
	^ listVars
]

{ #category : #'code generator' }
MicroWizGenerator >> literalStringFrom: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
MicroWizGenerator >> newlineString [
	^ String lf
]

{ #category : #'control ops' }
MicroWizGenerator >> stopThread [
	self subclassResponsibility
]

{ #category : #private }
MicroWizGenerator >> useListVar: aString [
	listVars add: aString
]

{ #category : #private }
MicroWizGenerator >> useVar: aString [
	vars add: aString.
]

{ #category : #private }
MicroWizGenerator >> valueOf: anObject [
	anObject isBlock ifTrue: [ ^ anObject value asString ].
	^ anObject asString
]

{ #category : #private }
MicroWizGenerator >> vars [
	^ vars
]
