"
A MicroWizProjectTest is a test class for testing the behavior of MicroWizProject
"
Class {
	#name : #MicroWizProjectTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroWizProjectTest >> newProject [
	^ MicroWizProject new
]

{ #category : #test }
MicroWizProjectTest >> testAddModule [
	| p |
	p := self newProject.
	self assert: p modules isEmpty.
	p addModule: #abc.
	self assert: p modules size equals: 1.
	self assert: p modules first equals: #abc.
	p addModule: #def.
	self assert: p modules size equals: 2.
	self assert: p modules first equals: #abc.
	self assert: p modules second equals: #def
]

{ #category : #test }
MicroWizProjectTest >> testCommClass [
	| p |
	p := self newProject.
	self assert: p commClass isNil.
	p commClass: #SerialComm.
	self assert: p commClass equals: #SerialComm.
	p commClass: #DummyComm.
	self assert: p commClass equals: #DummyComm
]

{ #category : #test }
MicroWizProjectTest >> testDeleteModule [
	| p |
	p := self newProject.
	self assert: p modules isEmpty.
	p addModule: #abc.
	p addModule: #def.
	p addModule: #ghi.
	self assert: p modules size equals: 3.
	self assert: p modules first equals: #abc.
	self assert: p modules second equals: #def.
	self assert: p modules third equals: #ghi.
	p deleteModule: #def.
	p deleteModule: #pqr.
	self assert: p modules size equals: 2.
	self assert: p modules first equals: #abc.
	self assert: p modules second equals: #ghi
]

{ #category : #test }
MicroWizProjectTest >> testModules [
	| p |
	p := self newProject.
	self assert: p modules isEmpty
]

{ #category : #test }
MicroWizProjectTest >> testProxyClass [
	| p |
	p := self newProject.
	self assert: p proxyClass isNil.
	p proxyClass: #MicroPythonProxj.
	self assert: p proxyClass equals: #MicroPythonProxj.
	p proxyClass: #MicrobitProxy.
	self assert: p proxyClass equals: #MicrobitProxy
]

{ #category : #test }
MicroWizProjectTest >> testToggleModule [
	| p |
	p := self newProject.
	self assert: p modules isEmpty.
	p addModule: 'abc'.
	self assert: (p moduleInUse: 'abc').
	self deny: (p moduleInUse: 'def').
	p toggleModule: 'abc'.
	p toggleModule: 'def'.
	self deny: (p moduleInUse: 'abc').
	self assert: (p moduleInUse: 'def')
]
