Class {
	#name : #ScratchStackFrame,
	#superclass : #Object,
	#instVars : [
		'parentFrame',
		'expression',
		'arguments',
		'pc',
		'startTime',
		'startValue',
		'shouldUnlight'
	],
	#category : #'FromScratch-Process'
}

{ #category : #accessing }
ScratchStackFrame >> addArgument: anObject [
	arguments add: anObject
]

{ #category : #accessing }
ScratchStackFrame >> arguments [
	^ arguments
]

{ #category : #accessing }
ScratchStackFrame >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
ScratchStackFrame >> expression [
	^ expression
]

{ #category : #accessing }
ScratchStackFrame >> expression: anObject [
	expression := anObject
]

{ #category : #initialization }
ScratchStackFrame >> initialize [
	parentFrame := nil.
	expression := nil.
	arguments := OrderedCollection new.
	pc := 1.
	shouldUnlight := false
]

{ #category : #accessing }
ScratchStackFrame >> parentFrame [
	^ parentFrame
]

{ #category : #accessing }
ScratchStackFrame >> parentFrame: anObject [
	parentFrame := anObject
]

{ #category : #accessing }
ScratchStackFrame >> pc [
	^ pc
]

{ #category : #accessing }
ScratchStackFrame >> pc: anObject [
	pc := anObject
]

{ #category : #accessing }
ScratchStackFrame >> shouldUnlight [
	^ shouldUnlight
]

{ #category : #accessing }
ScratchStackFrame >> shouldUnlight: anObject [
	shouldUnlight := anObject
]

{ #category : #accessing }
ScratchStackFrame >> shouldYield [
	"Answers true iff this is a dummy frame simply indicating that the process should yield control."

	^ expression = #shouldYield
]

{ #category : #accessing }
ScratchStackFrame >> shouldYield: aBoolean [
	"Makes this into a special stack frame that tells the evaluator to yield control to another process. When this flag is set, the rest of the stack frame is ignored."

	aBoolean
		ifTrue: [ expression := #shouldYield ]
		ifFalse: [ self error: 'Should not call shouldYield: with false.' ]
]

{ #category : #accessing }
ScratchStackFrame >> startTime [
	^ startTime
]

{ #category : #accessing }
ScratchStackFrame >> startTime: anObject [
	startTime := anObject
]

{ #category : #accessing }
ScratchStackFrame >> startValue [
	^ startValue
]

{ #category : #accessing }
ScratchStackFrame >> startValue: anObject [
	startValue := anObject
]
