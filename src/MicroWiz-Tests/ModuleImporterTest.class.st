"
An ExtModuleImporterTest is a test class for testing the behavior of ExtModuleImporter
"
Class {
	#name : #ModuleImporterTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ModuleImporterTest >> newImporter [
	^ ModuleImporter new
]

{ #category : #test }
ModuleImporterTest >> testBlockDefClass [
	| i |
	i := self newImporter.
	self assert: i blockDefClass isNil.
	i blockDefClass: ExtBlockDef.
	self assert: i blockDefClass equals: ExtBlockDef.
	i blockDefClass: BlockDef.
	self assert: i blockDefClass equals: BlockDef
]

{ #category : #test }
ModuleImporterTest >> testCategory [
	| i out |
	i := self newImporter.
	out := i category: 'sensing'.
	self assert: (out isKindOf: BlockCategory).
	self assert: out categoryName equals: 'sensing'
]

{ #category : #test }
ModuleImporterTest >> testCommandBlockArgsCodeImports [
	| i out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	out := i
		commandBlock: 'set oled w %n h %n'
		args: #(64 128)
		code: 'oled=SSD1306_I2C(%n,%n,i2c)'
		imports: #(i2c)
		id: 5.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'set oled w %n h %n'.
	self assertCollection: out defaultArgs equals: #(64 128).
	self assert: out code equals: 'oled=SSD1306_I2C(%n,%n,i2c)'.
	self assertCollection: out imports equals: #(i2c).
	self assert: out id equals: 5
]

{ #category : #test }
ModuleImporterTest >> testCommandBlockArgsCodeImportsId [
	| i out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	out := i
		commandBlock: 'set oled w %n h %n'
		args: #(64 128)
		code: 'oled=SSD1306_I2C(%n,%n,i2c)'
		imports: #(i2c).
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'set oled w %n h %n'.
	self assertCollection: out defaultArgs equals: #(64 128).
	self assert: out code equals: 'oled=SSD1306_I2C(%n,%n,i2c)'.
	self assertCollection: out imports equals: #(i2c).
	self assert: out id equals: out block hash
]

{ #category : #test }
ModuleImporterTest >> testImport [
	| i in out |
	i := self newImporter.
	in := '(MicroWiz (module:var:headers:blocks: "oled" "oled" ("from ssd1306 import SSD1306_I2C") ()))'.
	out := i import: in.
	self assert: (out isKindOf: ExtModuleDef).
	self assert: out moduleName equals: 'oled'.
	self assert: out varName equals: 'oled'.
	self assert: out header equals: 'from ssd1306 import SSD1306_I2C'.
	self assert: out blockDefs isEmpty
]

{ #category : #test }
ModuleImporterTest >> testImportBlockDef [
	| i in out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	in := #('commandBlock:args:code:imports:' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c)).
	out := i importBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	in := #('reporterBlock:args:return:code:imports:' 'vl read' () 'r' 'vl.read()' #()).
	out := i importBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	in := #('category:' 'sensing').
	out := i importBlockDef: in.
	self assert: (out isKindOf: BlockCategory).
	self assert: out categoryName equals: 'sensing'.
	in := #('separator').
	out := i importBlockDef: in.
	self assert: (out isKindOf: BlockSeparator)
]

{ #category : #test }
ModuleImporterTest >> testImportBlockDefsInto [
	| i in out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	in := #(#('commandBlock:args:code:imports:' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c)) #('reporterBlock:args:return:code:imports:' 'vl read' () 'r' 'vl.read()' #())).
	out := OrderedCollection new.
	i importBlockDefs: in into: out.
	self assert: out size equals: 2.
	self assert: (out first isKindOf: ExtBlockDef).
	self assert: (out second isKindOf: ExtBlockDef)
]

{ #category : #test }
ModuleImporterTest >> testImportFrom [
	| i in out |
	i := self newImporter.
	in := #('MicroWiz' #('module:var:headers:blocks:' 'oled' 'abc' #('aaa' 'bbb') #())).
	out := i importFrom: in.
	self assert: (out isKindOf: ExtModuleDef)
]

{ #category : #test }
ModuleImporterTest >> testModuleVarHeadersBlocks [
	| i out |
	i := self newImporter.
	out := i
		module: 'oled'
		var: 'abc'
		headers: #('aaa' 'bbb')
		blocks: #().
	self assert: (out isKindOf: ExtModuleDef).
	self assert: out moduleName equals: 'oled'.
	self assert: out varName equals: 'abc'.
	self assert: out header equals: 'aaa' , String lf , 'bbb'.
	self assert: out blockDefs isEmpty
]

{ #category : #test }
ModuleImporterTest >> testProxyBlocks [
	| i out |
	i := self newImporter.
	out := i proxy: 'microbit' blocks: #().
	self assert: (out isKindOf: IntModuleDef).
	self assert: out proxyName equals: 'microbit'.
	self assert: out blockDefs isEmpty
]

{ #category : #test }
ModuleImporterTest >> testReporterBlockArgsReturnCodeImports [
	| i out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	out := i
		reporterBlock: 'vl read'
		args: #()
		return: 'r'
		code: 'vl.read()'
		imports: #().
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'vl read'.
	self assert: out defaultArgs isEmpty.
	self assert: out code equals: 'vl.read()'.
	self assert: out imports isEmpty.
	self assert: out id equals: out block hash
]

{ #category : #test }
ModuleImporterTest >> testReporterBlockArgsReturnCodeImportsId [
	| i out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	out := i
		reporterBlock: 'vl read'
		args: #()
		return: 'r'
		code: 'vl.read()'
		imports: #()
		id: 9.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'vl read'.
	self assert: out defaultArgs isEmpty.
	self assert: out code equals: 'vl.read()'.
	self assert: out imports isEmpty.
	self assert: out id equals: 9
]

{ #category : #test }
ModuleImporterTest >> testSeparator [
	| i out |
	i := self newImporter.
	out := i separator.
	self assert: (out isKindOf: BlockSeparator)
]
