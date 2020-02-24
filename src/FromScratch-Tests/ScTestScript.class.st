Class {
	#name : #ScTestScript,
	#superclass : #ScratchScript,
	#instVars : [
		'objName'
	],
	#category : #'FromScratch-Tests'
}

{ #category : #'argument menus' }
ScTestScript >> listVarNames [
	^ #(d 'e f')
]

{ #category : #accessing }
ScTestScript >> objName [
	^ objName
]

{ #category : #accessing }
ScTestScript >> objName: aString [
	objName := aString
]

{ #category : #'arithmetic ops' }
ScTestScript >> plus: a and: b [
	^ a + b
]

{ #category : #'argument menus' }
ScTestScript >> varNames [
	^ #(a 'b c')
]
