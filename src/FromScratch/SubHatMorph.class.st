Class {
	#name : #SubHatMorph,
	#superclass : #HatBlockMorph,
	#instVars : [
		'subName'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #converting }
SubHatMorph >> asBlockTuple [
	^ Array with: self class name with: self subName
]

{ #category : #'code generation' }
SubHatMorph >> emitCode: aGenerator indent: indent [
	aGenerator emitSubHatBlock: self indent: indent.
]

{ #category : #initialization }
SubHatMorph >> initialize [
	super initialize.
	subName := ''.
]

{ #category : #accessing }
SubHatMorph >> subName [
	^ subName
]

{ #category : #accessing }
SubHatMorph >> subName: aString [
	subName := aString.
	scriptNameMorph contents: ('Sub ', aString).
	self fixBlockLayout.
	self applicationDo: [ :app | app updateContents ]
]
