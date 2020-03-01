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

{ #category : #accessing }
ModuleImporter >> import: aString [
	| lex list |
	lex := SexpLexer new read: aString.
	list := SexpParser new parse: lex.
	^ self importFrom: list
]

{ #category : #private }
ModuleImporter >> importBlockDef: anArray [
	| sel |
	sel := anArray first.
	sel = 'commandBlock:args:code:imports:'
		ifTrue: [ ^ self importCommandBlockDef: anArray ].
	sel = 'reporterBlock:args:return:code:imports:'
		ifTrue: [ ^ self importReporterBlockDef: anArray ].
	sel = 'category:'
		ifTrue: [ ^ self importCategory: anArray ].
	sel = 'separator'
		ifTrue: [ ^ BlockSeparator new ].
	self error: 'invalid block def'
]

{ #category : #private }
ModuleImporter >> importBlockDefs: anArray into: aCollection [
	anArray do: [ :each | aCollection add: (self importBlockDef: each) ]
]

{ #category : #private }
ModuleImporter >> importCategory: anArray [
	^ BlockCategory new
		categoryName: anArray second;
		yourself
]

{ #category : #private }
ModuleImporter >> importCommandBlockDef: anArray [
	| def |
	def := self blockDefClass new
		block: anArray second;
		defaultArgs: anArray third;
		code: anArray fourth;
		imports: anArray fifth;
		yourself.
	anArray size > 5
		ifTrue: [ def id: anArray sixth ].
	^ def
]

{ #category : #private }
ModuleImporter >> importExtModule: anArray [
	| module |
	blockDefClass := ExtBlockDef.
	module := ExtModuleDef new.
	module
		moduleName: anArray second;
		varName: anArray third;
		header: (anArray fourth joinUsing: String lf);
		blockDefs: OrderedCollection new.
	self importBlockDefs: anArray fifth into: module blockDefs.
	^ module
]

{ #category : #private }
ModuleImporter >> importFrom: anArray [
	anArray first = SpMicroWiz appName
		ifFalse: [ self error: 'invalid appName' ].
	anArray second first = 'module:var:headers:blocks:'
		ifTrue: [ ^ self importExtModule: anArray second ].
	anArray second first = 'proxy:blocks:'
		ifTrue: [ ^ self importIntModule: anArray second ].
	self error: 'invalid module'
]

{ #category : #private }
ModuleImporter >> importIntModule: anArray [
	| module |
	blockDefClass := BlockDef.
	module := IntModuleDef new.
	module
		proxyName: anArray second;
		blockDefs: OrderedCollection new.
	self importBlockDefs: anArray third into: module blockDefs.
	^ module
]

{ #category : #private }
ModuleImporter >> importReporterBlockDef: anArray [
	| def |
	def := self blockDefClass new
		block: anArray second;
		defaultArgs: anArray third;
		return: anArray fourth;
		code: anArray fifth;
		imports: anArray sixth;
		yourself.
	anArray size > 6
		ifTrue: [ def id: anArray seventh ].
	^ def
]
