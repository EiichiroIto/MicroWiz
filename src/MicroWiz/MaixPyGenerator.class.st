Class {
	#name : #MaixPyGenerator,
	#superclass : #MicroPythonGenerator,
	#category : #'MicroWiz-MPython'
}

{ #category : #private }
MaixPyGenerator >> lcd [
	self import: 'lcd'.
	^ 'lcd'
]

{ #category : #'display ops' }
MaixPyGenerator >> lcdClear [
	self
		appendWithNewline: self lcd , '.' , (self nullaryFunction: 'clear')
]

{ #category : #'display ops' }
MaixPyGenerator >> lcdDeinit [
	self
		appendWithNewline: self lcd , '.' , (self nullaryFunction: 'deinit')
]

{ #category : #'display ops' }
MaixPyGenerator >> lcdDisplay: image [
	self
		appendWithNewline: self lcd , '.' , (self unaryFunction: 'display' arg: image)
]

{ #category : #'display ops' }
MaixPyGenerator >> lcdDrawString: text x: x y: y fg: fg bg: bg [
	self
		appendWithNewline:
			self lcd , '.' , 'draw_string(' , (self valueOf: x) , ','
				, (self valueOf: y) , ',' , (self valueOf: text) , ',' , self lcd
				, '.' , fg , ',' , self lcd , '.' , bg , ')'
]

{ #category : #'display ops' }
MaixPyGenerator >> lcdInit [
	self
		appendWithNewline: self lcd , '.' , (self nullaryFunction: 'init')
]

{ #category : #'display ops' }
MaixPyGenerator >> lcdRotation: num [
	self
		appendWithNewline: self lcd , '.' , (self unaryFunction: 'rotation' arg: num)
]

{ #category : #private }
MaixPyGenerator >> sensor [
	self import: 'sensor'.
	^ 'sensor'
]

{ #category : #'display ops' }
MaixPyGenerator >> sensorReset [
	self
		appendWithNewline: self sensor , '.' , (self nullaryFunction: 'reset')
]

{ #category : #'display ops' }
MaixPyGenerator >> sensorRun: num [
	self
		appendWithNewline: self sensor , '.' , (self unaryFunction: 'run' arg: num)
]

{ #category : #'display ops' }
MaixPyGenerator >> sensorSetFrameSize: choice [
	self
		appendWithNewline: self sensor , '.set_framesize(' , self sensor , '.' , choice , ')'
]

{ #category : #'display ops' }
MaixPyGenerator >> sensorSetPixFormat: choice [
	self
		appendWithNewline: self sensor , '.set_pixformat(' , self sensor , '.' , choice , ')'
]

{ #category : #'display ops' }
MaixPyGenerator >> sensorSetVFlip: bool [
	self
		appendWithNewline: self sensor , '.' , (self unaryFunction: 'set_vflip' arg: bool)
]

{ #category : #'display ops' }
MaixPyGenerator >> sensorSnapshot [
	^ self sensor , '.' , (self nullaryFunction: 'snapshot')
]
