Class {
	#name : #ExtModuleImporter,
	#superclass : #Object,
	#category : #'MicroWiz-Converter'
}

{ #category : #accessing }
ExtModuleImporter >> import: aString [
	| lex list |
	lex := SexpLexer new read: aString.
	list := SexpParser new parse: lex.
	^ self importFrom: list
]

{ #category : #private }
ExtModuleImporter >> importBlockDef: anArray [
	anArray first = 'commandBlock:args:code:imports:'
		ifTrue: [ ^ self importCommandBlockDef: anArray ].
	anArray first = 'reporterBlock:args:return:code:imports:'
		ifTrue: [ ^ self importReporterBlockDef: anArray ].
	self error: 'invalid block def'
]

{ #category : #private }
ExtModuleImporter >> importBlockDefs: anArray into: aCollection [
	anArray do: [ :each | aCollection add: (self importBlockDef: each) ]
]

{ #category : #private }
ExtModuleImporter >> importCommandBlockDef: anArray [
	^ ExtBlockDef new
		block: anArray second;
		defaultArgs: anArray third;
		code: anArray fourth;
		imports: anArray fifth;
		yourself
]

{ #category : #private }
ExtModuleImporter >> importFrom: anArray [
	anArray first = SpMicroWiz appName
		ifFalse: [ self error: 'invalid appName' ].
	^ self importModule: anArray second
]

{ #category : #private }
ExtModuleImporter >> importModule: anArray [
	| module |
	module := ExtModuleDef new.
	anArray first = 'module:var:headers:blocks:'
		ifFalse: [ self error: 'invalid module header' ].
	module
		moduleName: anArray second;
		varName: anArray third;
		header: (anArray fourth joinUsing: String lf);
		blockDefs: OrderedCollection new.
	self importBlockDefs: anArray fifth into: module blockDefs.
	^ module
]

{ #category : #private }
ExtModuleImporter >> importReporterBlockDef: anArray [
	^ ExtBlockDef new
		block: anArray second;
		defaultArgs: anArray third;
		return: anArray fourth;
		code: anArray fifth;
		imports: anArray sixth;
		yourself
]
