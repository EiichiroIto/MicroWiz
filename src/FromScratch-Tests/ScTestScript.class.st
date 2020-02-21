Class {
	#name : #ScTestScript,
	#superclass : #ScratchScript,
	#category : #'FromScratch-Tests'
}

{ #category : #'argument menus' }
ScTestScript >> listVarNames [
	^ #(d 'e f')
]

{ #category : #accessing }
ScTestScript >> objName [
	^ 'test'
]

{ #category : #'arithmetic ops' }
ScTestScript >> plus: a and: b [
	^ a + b
]

{ #category : #'argument menus' }
ScTestScript >> varNames [
	^ #(a 'b c')
]
