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
ExtModuleDefTest >> testAssignSelectors [
	| d b1 b2 b3 |
	d := self newDef.
	b1 := self newBlockDef
		block: 'a %n b %s';
		yourself.
	b2 := self newBlockDef
		block: 'aaa %x bbb';
		yourself.
	b3 := self newBlockDef
		block: 'ab cd ef';
		yourself.
	d
		blockDefs:
			{b1.
			b2.
			b3}.
	d moduleName: 'abc'.
	d assignSelectors.
	self assert: b1 selector equals: #extAbc1arg1:arg2:.
	self assert: b2 selector equals: #extAbc2arg1:.
	self assert: b3 selector equals: #extAbc3
]

{ #category : #test }
ExtModuleDefTest >> testBlockDefAt [
	| d b1 b2 b3 |
	d := self newDef.
	b1 := self newBlockDef
		block: 'a %n b %s';
		yourself.
	b2 := self newBlockDef
		block: 'aaa %x bbb';
		yourself.
	b3 := self newBlockDef
		block: 'ab cd ef';
		yourself.
	d
		blockDefs:
			{b1.
			b2.
			b3}.
	d moduleName: 'abc'.
	d setup.
	self assert: (d blockDefAt: #extAbc1arg1:arg2:) equals: b1.
	self assert: (d blockDefAt: #extAbc2arg1:) equals: b2.
	self assert: (d blockDefAt: #extAbc3) equals: b3.
	self assert: (d blockDefAt: #extAbc4) isNil
]

{ #category : #test }
ExtModuleDefTest >> testBlockDefs [
	| d |
	d := self newDef.
	self assert: d blockDefs isNil.
	d blockDefs: #(1 2 3).
	self assertCollection: d blockDefs equals: #(1 2 3)
]

{ #category : #test }
ExtModuleDefTest >> testBlockTuples [
	| d b1 b2 ret |
	d := self newDef.
	b1 := self newBlockDef
		block: 'set oled w %n h %n';
		defaultArgs: #(64 128).
	b2 := self newBlockDef
		block: 'vl read';
		return: 'r';
		defaultArgs: #().
	d
		moduleName: 'oled';
		blockDefs:
			{b1.
			b2};
		setup.
	ret := d blockTuples.
	self assert: ret size equals: 2.
	self
		assertCollection: ret first
		equals: #('set oled w %n h %n' - #extOled1arg1:arg2: 64 128).
	self assertCollection: ret second equals: #('vl read' r extOled2)
]

{ #category : #test }
ExtModuleDefTest >> testBlocks [
	| d b1 b2 b3 ret |
	d := self newDef.
	b1 := self newBlockDef
		block: 'abc';
		yourself.
	b2 := self newBlockDef
		block: 'def';
		yourself.
	b3 := self newBlockDef
		block: 'ghi';
		yourself.
	d
		blockDefs:
			{b1.
			b2.
			b3}.
	ret := d blocks.
	self
		assertCollection: ret
		equals: 'abc' , String lf , 'def' , String lf , 'ghi'
]

{ #category : #test }
ExtModuleDefTest >> testConvertToDictionary [
	| d b1 b2 b3 |
	d := self newDef.
	b1 := self newBlockDef
		block: 'a %n b %s';
		yourself.
	b2 := self newBlockDef
		block: 'aaa %x bbb';
		yourself.
	b3 := self newBlockDef
		block: 'ab cd ef';
		yourself.
	d blockDefs: { b1. b2. b3 }.
	d moduleName: 'abc'.
	d assignSelectors.
	d convertToDictionary.
	self assert: d blockDefs isDictionary.
	self assert: (d blockDefs includesKey: #extAbc1arg1:arg2:).
	self assert: (d blockDefs includesKey: #extAbc2arg1:).
	self assert: (d blockDefs includesKey: #extAbc3)
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
ExtModuleDefTest >> testSetup [
	self
		testAssignSelectors;
		testConvertToDictionary
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
