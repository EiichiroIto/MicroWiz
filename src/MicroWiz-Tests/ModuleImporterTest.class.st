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
ModuleImporterTest >> testImportCategory [
	| i in out |
	i := self newImporter.
	in := #('category:' 'sensing').
	out := i importCategory: in.
	self assert: (out isKindOf: BlockCategory).
	self assert: out categoryName equals: 'sensing'
]

{ #category : #test }
ModuleImporterTest >> testImportCommandBlockDef [
	| i in out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	in := #('commandBlock:args:code:imports' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c)).
	out := i importCommandBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'set oled w %n h %n'.
	self assertCollection: out defaultArgs equals: #(64 128).
	self assert: out code equals: 'oled=SSD1306_I2C(%n,%n,i2c)'.
	self assertCollection: out imports equals: #(i2c).
	self assert: out id equals: out block hash.
	in := #('commandBlock:args:code:imports' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c) 5).
	out := i importCommandBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'set oled w %n h %n'.
	self assertCollection: out defaultArgs equals: #(64 128).
	self assert: out code equals: 'oled=SSD1306_I2C(%n,%n,i2c)'.
	self assertCollection: out imports equals: #(i2c).
	self assert: out id equals: 5
]

{ #category : #test }
ModuleImporterTest >> testImportExtModule [
	| i in out |
	i := self newImporter.
	in := #('module:var:headers:blocks:' 'oled' 'abc' #('aaa' 'bbb') #()).
	out := i importExtModule: in.
	self assert: (out isKindOf: ExtModuleDef).
	self assert: out moduleName equals: 'oled'.
	self assert: out varName equals: 'abc'.
	self assert: out header equals: 'aaa' , String lf , 'bbb'.
	self assert: out blockDefs isEmpty
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
ModuleImporterTest >> testImportIntModule [
	| i in out |
	i := self newImporter.
	in := #('proxy:blocks:' 'microbit' #()).
	out := i importIntModule: in.
	self assert: (out isKindOf: IntModuleDef).
	self assert: out proxyName equals: 'microbit'.
	self assert: out blockDefs isEmpty
]

{ #category : #test }
ModuleImporterTest >> testImportReporterBlockDef [
	| i in out |
	i := self newImporter.
	i blockDefClass: ExtBlockDef.
	in := #('reporterBlock:args:return:code:imports:' 'vl read' () 'r'
	 'vl.read()' #()).
	out := i importReporterBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'vl read'.
	self assert: out defaultArgs isEmpty.
	self assert: out code equals: 'vl.read()'.
	self assert: out imports isEmpty.
	self assert: out id equals: out block hash.
	in := #('reporterBlock:args:return:code:imports:' 'vl read' () 'r'
	 'vl.read()' #() 9).
	out := i importReporterBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'vl read'.
	self assert: out defaultArgs isEmpty.
	self assert: out code equals: 'vl.read()'.
	self assert: out imports isEmpty.
	self assert: out id equals: 9
]
