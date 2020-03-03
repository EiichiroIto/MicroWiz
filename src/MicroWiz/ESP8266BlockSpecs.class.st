Class {
	#name : #ESP8266BlockSpecs,
	#superclass : #MicroPythonBlockSpecs,
	#category : #'MicroWiz-MPython'
}

{ #category : #'argument menus' }
ESP8266BlockSpecs >> addArgBuilderTo: anArgBuilder [
	super addArgBuilderTo: anArgBuilder.
	anArgBuilder
		addChoiceArg: $P
			selector: #gpioModeNames
			target: self
			initialChoice: '';
		addChoiceArg: $W
			selector: #wifiConnectNames
			target: self
			initialChoice: '';
		addChoiceArg: $w
			selector: #wifiConfigNames
			target: self
			initialChoice: ''
]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> gpioModeNames [
	^ #(IN OUT PULL_UP)
]

{ #category : #'block specs' }
ESP8266BlockSpecs >> setupBlockCategoryTo: aBlockDef [
	super setupBlockCategoryTo: aBlockDef.
	aBlockDef
		addCategory: 'neopixel' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'network' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'io' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'i2c' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'spi' color: (Color h: 225 s: 0.65 v: 0.83)
]

{ #category : #private }
ESP8266BlockSpecs >> setupIntModuleDef [
	super setupIntModuleDef.
	self addIntModuleDefNamed: 'esp8266'
]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> wifiConfigNames [
	^ #(mac)
]

{ #category : #'argument menus' }
ESP8266BlockSpecs >> wifiConnectNames [
	^ #(STA_IF AP_IF)
]
