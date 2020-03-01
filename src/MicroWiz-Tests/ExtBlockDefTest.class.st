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
ExtBlockDefTest >> testBlockTuple [
	| d ret |
	d := self newDef.
	d
		block: 'set oled w %n h %n';
		defaultArgs: #(64 128).
	d moduleName: 'oled'.
	d id: 1.
	ret := d blockTuple.
	self
		assertCollection: ret
		equals: #('set oled w %n h %n' - #extOled1arg1:arg2: 64 128)
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
ExtBlockDefTest >> testPrefix [
	| d |
	d := self newDef.
	d moduleName: 'abc'.
	self assert: d prefix equals: 'extAbc'
]

{ #category : #test }
ExtBlockDefTest >> testSelector [
	| d |
	d := self newDef.
	d block: 'this %s is %n a %x pen'.
	d moduleName: 'abc'.
	d id: 10.
	self assert: d selector equals: #extAbc10arg1:arg2:arg3:
]
