Class {
	#name : #ESP8266Generator,
	#superclass : #MicroPythonGenerator,
	#category : #'MicroWiz-MPython'
}

{ #category : #private }
ESP8266Generator >> i2c [
	self from: 'machine' import: 'I2C'.
	^ '_i2c'
]

{ #category : #'io ops' }
ESP8266Generator >> i2cWrite: str to: addr [
	self
		appendWithNewline:
			self i2c , '.writeto(' , (self valueOf: addr) , ',bytes('
				, (self unquoteString: (self valueOf: str)) , '))'
]
