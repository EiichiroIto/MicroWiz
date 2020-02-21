"
An ExtModuleImporterTest is a test class for testing the behavior of ExtModuleImporter
"
Class {
	#name : #ExtModuleImporterTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
ExtModuleImporterTest >> newImporter [
	^ ExtModuleImporter new
]

{ #category : #test }
ExtModuleImporterTest >> testImport [
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
ExtModuleImporterTest >> testImportBlockDef [
	| i in out |
	i := self newImporter.
	in := #('commandBlock:args:code:imports:' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c)).
	out := i importBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	in := #('reporterBlock:args:return:code:imports:' 'vl read' () 'r' 'vl.read()' #()).
	out := i importBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef)
]

{ #category : #test }
ExtModuleImporterTest >> testImportBlockDefsInto [
	| i in out |
	i := self newImporter.
	in := #(#('commandBlock:args:code:imports:' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c)) #('reporterBlock:args:return:code:imports:' 'vl read' () 'r' 'vl.read()' #())).
	out := OrderedCollection new.
	i importBlockDefs: in into: out.
	self assert: out size equals: 2.
	self assert: (out first isKindOf: ExtBlockDef).
	self assert: (out second isKindOf: ExtBlockDef)
]

{ #category : #test }
ExtModuleImporterTest >> testImportCommandBlockDef [
	| i in out |
	i := self newImporter.
	in := #('commandBlock:args:code:imports' 'set oled w %n h %n' (64 128) 'oled=SSD1306_I2C(%n,%n,i2c)' #(i2c)).
	out := i importCommandBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'set oled w %n h %n'.
	self assertCollection: out defaultArgs equals: #(64 128).
	self assert: out code equals: 'oled=SSD1306_I2C(%n,%n,i2c)'.
	self assertCollection: out imports equals: #(i2c)
]

{ #category : #test }
ExtModuleImporterTest >> testImportFrom [
	| i in out |
	i := self newImporter.
	in := #('MicroWiz' #('module:var:headers:blocks:' 'oled' 'abc' #('aaa' 'bbb') #())).
	out := i importFrom: in.
	self assert: (out isKindOf: ExtModuleDef)
]

{ #category : #test }
ExtModuleImporterTest >> testImportModule [
	| i in out |
	i := self newImporter.
	in := #('module:var:headers:blocks:' 'oled' 'abc' #('aaa' 'bbb') #()).
	out := i importModule: in.
	self assert: (out isKindOf: ExtModuleDef).
	self assert: out moduleName equals: 'oled'.
	self assert: out varName equals: 'abc'.
	self assert: out header equals: 'aaa' , String lf , 'bbb'.
	self assert: out blockDefs isEmpty
]

{ #category : #test }
ExtModuleImporterTest >> testImportReporterBlockDef [
	| i in out |
	i := self newImporter.
	in := #('reporterBlock:args:return:code:imports:' 'vl read' () 'r'
	 'vl.read()' #()).
	out := i importReporterBlockDef: in.
	self assert: (out isKindOf: ExtBlockDef).
	self assert: out block equals: 'vl read'.
	self assert: out defaultArgs isEmpty.
	self assert: out code equals: 'vl.read()'.
	self assert: out imports isEmpty
]
