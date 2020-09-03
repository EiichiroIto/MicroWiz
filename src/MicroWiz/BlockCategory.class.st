Class {
	#name : #BlockCategory,
	#superclass : #MicroWizBlockDef,
	#instVars : [
		'categoryName'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
BlockCategory >> block [
	^ categoryName
]

{ #category : #accessing }
BlockCategory >> categoryName [
	^ categoryName
]

{ #category : #accessing }
BlockCategory >> categoryName: anObject [
	categoryName := anObject
]

{ #category : #testing }
BlockCategory >> isCategory [
	^ true
]

{ #category : #accessing }
BlockCategory >> moduleName: aString [
	"do nothing"
]

{ #category : #printing }
BlockCategory >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: categoryName asString;
		nextPut: $)
]
