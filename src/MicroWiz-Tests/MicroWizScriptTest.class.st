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
MicroWizScriptTest >> testInitialize [
	| s |
	s := self newScript.
	self assert: s varNames isEmpty.
	self assert: s listVarNames isEmpty
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
