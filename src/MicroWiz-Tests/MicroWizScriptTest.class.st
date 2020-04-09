"
A MicroWizScriptTest is a test class for testing the behavior of MicroWizScript
"
Class {
	#name : #MicroWizScriptTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroWizScriptTest >> newScript [
	^ MicroWizScript new
]

{ #category : #test }
MicroWizScriptTest >> testAddList [
	| s |
	s := self newScript.
	self assert: s listVarNames isEmpty.
	s addList: 'abc'.
	s addList: 'def'.
	self assert: (s listVarNames includes: 'abc').
	self assert: (s listVarNames includes: 'def')
]

{ #category : #test }
MicroWizScriptTest >> testAddVariable [
	| s |
	s := self newScript.
	self assert: s varNames isEmpty.
	s addVariable: 'abc'.
	s addVariable: 'def'.
	self assert: (s varNames includes: 'abc').
	self assert: (s varNames includes: 'def')
]

{ #category : #test }
MicroWizScriptTest >> testCompareHatBlockAnd [
	| s a b |
	s := self newScript.
	a := SubHatMorph new subName: 'a'.
	b := SubHatMorph new subName: 'b'.
	self assert: (s compareHatBlock: a and: b).
	self deny: (s compareHatBlock: b and: a).
	a := EventHatMorph new eventName: 'a'.
	self assert: (s compareHatBlock: b and: a).
	self deny: (s compareHatBlock: a and: b)
]

{ #category : #test }
MicroWizScriptTest >> testDeleteList [
	| s |
	s := self newScript.
	self assert: s listVarNames isEmpty.
	s addList: 'abc'.
	s addList: 'def'.
	self assert: (s listVarNames includes: 'abc').
	self assert: (s listVarNames includes: 'def').
	self deny: (s listVarNames includes: 'ghi').
	s deleteList: 'abc'.
	s deleteList: 'ghi'.
	self deny: (s listVarNames includes: 'abc').
	self assert: (s listVarNames includes: 'def').
	self deny: (s listVarNames includes: 'ghi')
]

{ #category : #test }
MicroWizScriptTest >> testDeleteVariable [
	| s |
	s := self newScript.
	self assert: s varNames isEmpty.
	s addVariable: 'abc'.
	s addVariable: 'def'.
	self assert: (s varNames includes: 'abc').
	self assert: (s varNames includes: 'def').
	self deny: (s varNames includes: 'ghi').
	s deleteVariable: 'abc'.
	s deleteVariable: 'ghi'.
	self deny: (s varNames includes: 'abc').
	self assert: (s varNames includes: 'def').
	self deny: (s varNames includes: 'ghi')
]

{ #category : #test }
MicroWizScriptTest >> testHatBlocks [
	| s ret |
	s := self newScript.
	s blocksBin addMorph: (EventHatMorph new eventName: 'a').
	s blocksBin addMorph: (SubHatMorph new subName: 'b').
	s blocksBin addMorph: (SubHatMorph new subName: 'c').
	ret := s hatBlocks.
	self assert: ret first subName equals: 'b'.
	self assert: ret second subName equals: 'c'.
	self assert: ret third eventName equals: 'a'
]

{ #category : #test }
MicroWizScriptTest >> testInitialize [
	| s |
	s := self newScript.
	self assert: s varNames isEmpty.
	self assert: s listVarNames isEmpty
]

{ #category : #test }
MicroWizScriptTest >> testIsValidSubName [
	| s |
	s := self newScript.
	self assert: (s isValidSubName: 'abc').
	self assert: (s isValidSubName: 'abc123').
	self deny: (s isValidSubName: '').
	self deny: (s isValidSubName: ' ').
	self deny: (s isValidSubName: '2abc').
	self deny: (s isValidSubName: '2a-bc').
	self deny: (s isValidSubName: '2a bc')
]

{ #category : #test }
MicroWizScriptTest >> testListVarNames [
	self testAddList
]

{ #category : #test }
MicroWizScriptTest >> testObjName [
	| s |
	s := self newScript.
	self assert: s objName isNil.
	s objName: 'abc'.
	self assert: s objName equals: 'abc'.
	s objName: 'def'.
	self assert: s objName equals: 'def'
]

{ #category : #test }
MicroWizScriptTest >> testVarNames [
	self testAddVariable
]

{ #category : #test }
MicroWizScriptTest >> testVariableNameInUse [
	| s |
	s := self newScript.
	self deny: (s variableNameInUse: 'abc').
	self deny: (s variableNameInUse: 'def').
	self deny: (s variableNameInUse: 'ghi').
	s addVariable: 'abc'.
	self assert: (s variableNameInUse: 'abc').
	self deny: (s variableNameInUse: 'def').
	self deny: (s variableNameInUse: 'ghi').
	s addList: 'def'.
	self assert: (s variableNameInUse: 'abc').
	self assert: (s variableNameInUse: 'def').
	self deny: (s variableNameInUse: 'ghi')
]
