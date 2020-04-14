Class {
	#name : #ModuleImporter,
	#superclass : #Object,
	#instVars : [
		'blockDefClass'
	],
	#category : #'MicroWiz-Converter'
}

{ #category : #accessing }
ModuleImporter >> blockDefClass [
	^ blockDefClass
]

{ #category : #accessing }
ModuleImporter >> blockDefClass: anObject [
	blockDefClass := anObject
]

{ #category : #private }
ModuleImporter >> category: aString [
	^ BlockCategory new
		categoryName: aString;
		yourself
]

{ #category : #private }
ModuleImporter >> commandBlock: aString1 args: anArray1 code: aString2 imports: anArray2 [
	^ self
		commandBlock: aString1
		args: anArray1
		code: aString2
		imports: anArray2
		id: nil
]

{ #category : #private }
ModuleImporter >> commandBlock: aString1 args: anArray1 code: aString2 imports: anArray2 id: anInteger [
	^ self blockDefClass new
		block: aString1;
		defaultArgs: anArray1;
		code: aString2;
		imports: anArray2;
		id: anInteger;
		yourself
]

{ #category : #accessing }
ModuleImporter >> import: aString [
	| lex list |
	lex := SexpLexer new read: aString.
	list := SexpParser new parse: lex.
	^ self importFrom: list
]

{ #category : #private }
ModuleImporter >> importBlockDef: anArray [
	^ self perform: anArray first asSymbol withArguments: anArray allButFirst
]

{ #category : #private }
ModuleImporter >> importBlockDefs: anArray into: aCollection [
	anArray do: [ :each | aCollection add: (self importBlockDef: each) ]
]

{ #category : #private }
ModuleImporter >> importFrom: anArray [
	anArray first = SpMicroWiz appName
		ifFalse: [ self error: 'invalid appName' ].
	^ self
		perform: anArray second first asSymbol
		withArguments: anArray second allButFirst
]

{ #category : #private }
ModuleImporter >> module: aString1 var: aString2 headers: anArray1 blocks: anArray2 [
	| module |
	blockDefClass := ExtBlockDef.
	module := ExtModuleDef new.
	module
		moduleName: aString1;
		varName: aString2;
		header: (anArray1 joinUsing: String lf);
		blockDefs: OrderedCollection new.
	self importBlockDefs: anArray2 into: module blockDefs.
	^ module
]

{ #category : #private }
ModuleImporter >> proxy: aString blocks: anArray [
	| module |
	blockDefClass := BlockDef.
	module := IntModuleDef new.
	module
		proxyName: aString;
		blockDefs: OrderedCollection new.
	self importBlockDefs: anArray into: module blockDefs.
	^ module
]

{ #category : #private }
ModuleImporter >> reporterBlock: aString1 args: anArray1 return: aString2 code: aString3 imports: anArray2 [
	^ self
		reporterBlock: aString1
		args: anArray1
		return: aString2
		code: aString3
		imports: anArray2
		id: nil
]

{ #category : #private }
ModuleImporter >> reporterBlock: aString1 args: anArray1 return: aString2 code: aString3 imports: anArray2 id: anInteger [
	^ self blockDefClass new
		block: aString1;
		defaultArgs: anArray1;
		return: aString2;
		code: aString3;
		imports: anArray2;
		id: anInteger;
		yourself
]

{ #category : #private }
ModuleImporter >> separator [
	^ BlockSeparator new
]
