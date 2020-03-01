Class {
	#name : #ExtModuleDef,
	#superclass : #MicroWizModuleDef,
	#instVars : [
		'moduleName',
		'varName',
		'header'
	],
	#category : #'MicroWiz-Modules'
}

{ #category : #accessing }
ExtModuleDef >> header [
	^ header ifNil: [ '' ]
]

{ #category : #accessing }
ExtModuleDef >> header: aString [
	header := aString
]

{ #category : #api }
ExtModuleDef >> moduleFilename [
	^ self moduleName , '.py'
]

{ #category : #accessing }
ExtModuleDef >> moduleName [
	^ moduleName
]

{ #category : #accessing }
ExtModuleDef >> moduleName: aString [
	moduleName := aString
]

{ #category : #printing }
ExtModuleDef >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: moduleName asString;
		nextPut: $,;
		nextPutAll: (blockDefs ifNil: [ 0 ] ifNotNil: [ blockDefs size ]) asString;
		nextPut: $)
]

{ #category : #private }
ExtModuleDef >> setupBlockDefs [
	blockDefs do: [ :each | each moduleName: self moduleName ]
]

{ #category : #accessing }
ExtModuleDef >> varName [
	^ varName
]

{ #category : #accessing }
ExtModuleDef >> varName: aString [
	varName := aString
]
