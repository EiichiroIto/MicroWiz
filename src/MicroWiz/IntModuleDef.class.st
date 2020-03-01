Class {
	#name : #IntModuleDef,
	#superclass : #MicroWizModuleDef,
	#instVars : [
		'proxyName'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #arithmetic }
IntModuleDef >> + otherDef [
	| newDef collection |
	newDef := self class new.
	newDef proxyName: self proxyName , '+' , otherDef proxyName.
	collection := self blockDefs copy.
	collection addAll: otherDef blockDefs.
	newDef blockDefs: collection.
	collection := self blockDict copy.
	collection addAll: otherDef blockDict.
	newDef blockDict: collection.
	^ newDef
]

{ #category : #accessing }
IntModuleDef >> proxyName [
	^ proxyName
]

{ #category : #accessing }
IntModuleDef >> proxyName: anObject [
	proxyName := anObject
]
