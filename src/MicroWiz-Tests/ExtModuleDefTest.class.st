"
An ExtModuleDefTest is a test class for testing the behavior of ExtModuleDef
"
Class {
	#name : #ExtModuleDefTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ExtModuleDefTest >> newBlockDef [
	^ ExtBlockDef new
]

{ #category : #private }
ExtModuleDefTest >> newDef [
	^ ExtModuleDef new
]

{ #category : #test }
ExtModuleDefTest >> testHeader [
	| d |
	d := self newDef.
	self assert: d header isEmpty.
	d header: 'abc'.
	self assert: d header equals: 'abc'.
	d header: 'def'.
	self assert: d header equals: 'def'
]

{ #category : #test }
ExtModuleDefTest >> testModuleFilename [
	| d |
	d := self newDef.
	d moduleName: 'abc'.
	self assert: d moduleFilename equals: 'abc.py'.
	d moduleName: 'def'.
	self assert: d moduleFilename equals: 'def.py'
]

{ #category : #test }
ExtModuleDefTest >> testModuleName [
	| d |
	d := self newDef.
	self assert: d moduleName isNil.
	d moduleName: 'abc'.
	self assert: d moduleName equals: 'abc'.
	d moduleName: 'def'.
	self assert: d moduleName equals: 'def'
]

{ #category : #test }
ExtModuleDefTest >> testSetupBlockDefs [
	| d b1 b2 b3 |
	d := self newDef.
	b1 := self newBlockDef
		block: 'a %n b %s';
		id: 1;
		yourself.
	b2 := self newBlockDef
		block: 'aaa %x bbb';
		id: 2;
		yourself.
	b3 := self newBlockDef
		block: 'ab cd ef';
		id: 3;
		yourself.
	d
		blockDefs:
			{b1.
			b2.
			b3}.
	d moduleName: 'abc'.
	d setupBlockDefs.
	self assert: b1 selector equals: #extAbc1arg1:arg2:.
	self assert: b2 selector equals: #extAbc2arg1:.
	self assert: b3 selector equals: #extAbc3
]

{ #category : #test }
ExtModuleDefTest >> testVarName [
	| d |
	d := self newDef.
	self assert: d varName isNil.
	d varName: 'abc'.
	self assert: d varName equals: 'abc'.
	d varName: 'def'.
	self assert: d varName equals: 'def'
]
