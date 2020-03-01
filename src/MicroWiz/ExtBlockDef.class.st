Class {
	#name : #ExtBlockDef,
	#superclass : #BlockDef,
	#instVars : [
		'moduleName'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
ExtBlockDef >> moduleName [
	^ moduleName
]

{ #category : #accessing }
ExtBlockDef >> moduleName: aString [
	moduleName := aString
]

{ #category : #private }
ExtBlockDef >> prefix [
	^ 'ext' , self moduleName asCamelCase
]
