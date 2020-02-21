"
An ExtBlockDefTest is a test class for testing the behavior of ExtBlockDef
"
Class {
	#name : #ExtBlockDefTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ExtBlockDefTest >> newDef [
	^ ExtBlockDef new
]

{ #category : #test }
ExtBlockDefTest >> testArgPermutation [
	| d |
	d := self newDef.
	d block: '%n ab %n';
	code: '%n , %n'.
	self assertCollection: d argPermutation equals: #(1 2).
	d code: '%n2 , %n1'.
	self assertCollection: d argPermutation equals: #(2 1)
]

{ #category : #test }
ExtBlockDefTest >> testAssignSelectorId [
	| d |
	d := self newDef.
	d block: 'this %s is %n a %x pen'.
	self assert: d selector isNil.
	d assignSelector: 'abc' id: 10.
	self assert: d selector equals: #extAbc10arg1:arg2:arg3:.
	self assert: d moduleName equals: 'abc'
]

{ #category : #test }
ExtBlockDefTest >> testBlock [
	| d |
	d := self newDef.
	self assert: d block isNil.
	d block: 'abc'.
	self assert: d block equals: 'abc'.
	d block: 'def'.
	self assert: d block equals: 'def'
]

{ #category : #test }
ExtBlockDefTest >> testBlockTuple [
	| d ret |
	d := self newDef.
	d
		block: 'set oled w %n h %n';
		defaultArgs: #(64 128).
	d assignSelector: 'oled' id: 1.
	ret := d blockTuple.
	self
		assertCollection: ret
		equals: #('set oled w %n h %n' - #extOled1arg1:arg2: 64 128)
]

{ #category : #test }
ExtBlockDefTest >> testCode [
	| d |
	d := self newDef.
	self assert: d code isNil.
	d code: 'abc'.
	self assert: d code equals: 'abc'.
	d code: 'def'.
	self assert: d code equals: 'def'
]

{ #category : #test }
ExtBlockDefTest >> testCodeWithArgs [
	| d ret |
	d := self newDef.
	d block: 'a %n b %n'.
	d code: '%n2=%n1'.
	ret := d codeWithArgs: { 'abc' . 'def' }.
	self assert: ret equals: 'def=abc'
]

{ #category : #test }
ExtBlockDefTest >> testDefaultArgs [
	| d |
	d := self newDef.
	self assert: d defaultArgs isEmpty.
	d defaultArgs: #(1 2 3).
	self assertCollection: d defaultArgs equals: #(1 2 3)
]

{ #category : #test }
ExtBlockDefTest >> testEvaluatedArgs [
	| d ret |
	d := self newDef.
	d block: '%s a %s b %s c'.
	d code: '%s2 , %s1 , %s3'.
	ret := d
		evaluatedArgs:
			{[ #a ].
			[ #b ].
			[ #c ]}.
	self assertCollection: ret equals: #(b a c)
]

{ #category : #test }
ExtBlockDefTest >> testImports [
	| d |
	d := self newDef.
	self assert: d imports isEmpty.
	d imports: #(1 2 3).
	self assertCollection: d imports equals: #(1 2 3).
	d imports: #(4 5 6).
	self assertCollection: d imports equals: #(4 5 6)
]

{ #category : #test }
ExtBlockDefTest >> testIsReporter [
	| d |
	d := self newDef.
	self deny: d isReporter.
	d return: 'r'.
	self assert: d isReporter.
	d return: '-'.
	self deny: d isReporter.
	d return: 'b'.
	self assert: d isReporter
]

{ #category : #test }
ExtBlockDefTest >> testModuleName [
	| d |
	d := self newDef.
	self assert: d moduleName isNil.
	d moduleName: 'abc'.
	self assert: d moduleName equals: 'abc'.
	d moduleName: 'def'.
	self assert: d moduleName equals: 'def'
]

{ #category : #test }
ExtBlockDefTest >> testReturn [
	| d |
	d := self newDef.
	self assert: d return equals: '-'.
	d return: 'r'.
	self assert: d return equals: 'r'
]

{ #category : #test }
ExtBlockDefTest >> testSelector [
	| d |
	d := self newDef.
	self assert: d selector isNil.
	d selector: #abc.
	self assert: d selector equals: #abc.
	d selector: #def.
	self assert: d selector equals: #def
]
