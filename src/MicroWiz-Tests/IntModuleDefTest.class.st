"
An IntModuleDefTest is a test class for testing the behavior of IntModuleDef
"
Class {
	#name : #IntModuleDefTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
IntModuleDefTest >> newDef [
	^ IntModuleDef new
]

{ #category : #test }
IntModuleDefTest >> testProxyName [
	| d |
	d := self newDef.
	self assert: d proxyName isNil.
	d proxyName: 'abc'.
	self assert: d proxyName equals: 'abc'.
	d proxyName: 'def'.
	self assert: d proxyName equals: 'def'
]
