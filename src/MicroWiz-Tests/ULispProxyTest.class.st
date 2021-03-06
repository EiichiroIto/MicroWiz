"
An ULispProxyTest is a test class for testing the behavior of ULispProxy
"
Class {
	#name : #ULispProxyTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ULispProxyTest >> newProxy [
	^ ULispProxy new
]

{ #category : #test }
ULispProxyTest >> testHasPrompts [
	| p |
	p := self newProxy.
	self assert: (p hasPrompts: '123> abc').
	self assert: (p hasPrompts: '123> ').
	self assert: (p hasPrompts: '12> abc').
	self assert: (p hasPrompts: '1> abc').
	self assert: (p hasPrompts: '1> a').
	self deny: (p hasPrompts: '123>abc').
	self deny: (p hasPrompts: '123>').
	self deny: (p hasPrompts: '12a> abc').
	self deny: (p hasPrompts: 'a> abc').
	self deny: (p hasPrompts: '> abc')
]

{ #category : #test }
ULispProxyTest >> testIsPromptResponse [
	| p |
	p := self newProxy.
	p
		clearResponse;
		addResponse: '123> '.
	self assert: p isPromptResponse.
	p
		clearResponse;
		addResponse: '12> '.
	self assert: p isPromptResponse.
	p
		clearResponse;
		addResponse: '1> '.
	self assert: p isPromptResponse.
	p
		clearResponse;
		addResponse: '12> ' , String cr.
	self assert: p isPromptResponse.
	p
		clearResponse;
		addResponse: '123>abc'.
	self deny: p isPromptResponse.
	p
		clearResponse;
		addResponse: '123>'.
	self deny: p isPromptResponse.
	p
		clearResponse;
		addResponse: '12a>'.
	self deny: p isPromptResponse.
	p
		clearResponse;
		addResponse: '12a> abc'.
	self deny: p isPromptResponse.
	p
		clearResponse;
		addResponse: 'a> abc'.
	self deny: p isPromptResponse.
	p
		clearResponse;
		addResponse: '> abc'.
	self deny: p isPromptResponse.
	p
		clearResponse;
		addResponse: '12> ' , String crlf.
	self deny: p isPromptResponse
]

{ #category : #test }
ULispProxyTest >> testRemovePrompts [
	| p |
	p := self newProxy.
	self assert: (p removePrompts: '123> abc') equals: 'abc'.
	self assert: (p removePrompts: '123> ') equals: ''.
	self assert: (p removePrompts: '12> abc') equals: 'abc'.
	self assert: (p removePrompts: '1> abc') equals: 'abc'.
	self assert: (p removePrompts: '1> a') equals: 'a'.
	self assert: (p removePrompts: '123>abc') equals: '123>abc'.
	self assert: (p removePrompts: '123>') equals: '123>'.
	self assert: (p removePrompts: '12a> abc') equals: '12a> abc'.
	self assert: (p removePrompts: 'a> abc') equals: 'a> abc'.
	self assert: (p removePrompts: '> abc') equals: '> abc'
]
