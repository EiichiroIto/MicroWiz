Class {
	#name : #BlockDefTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
BlockDefTest >> newDef [
	^ BlockDef new
]

{ #category : #test }
BlockDefTest >> testArgPermutation [
	| d |
	d := self newDef.
	d block: '%a of %b of %c of %d';
	code: '%a de %b de %c de %d'.
	self assertCollection: d argPermutation equals: #(1 2 3 4).
	d code: '%d de %c de %b de %a'.
	self assertCollection: d argPermutation equals: #(4 3 2 1).

	d block: '%a of %m of %m of %t';
	code: '%a de %m de %m de %t'.
	self assertCollection: d argPermutation equals: #(1 2 3 4).
	d code: '%t de %m2 de %m1 de %a'.
	self assertCollection: d argPermutation equals: #(4 3 2 1).
	d code: '%t1 de %m2 %t1 de %m1 de %a'.
	self assertCollection: d argPermutation equals: #(4 3 4 2 1)
]

{ #category : #test }
BlockDefTest >> testBlock [
	| d |
	d := self newDef.
	self assert: d block isNil.
	d block: 'abc'.
	self assert: d block equals: 'abc'.
	d block: 'def'.
	self assert: d block equals: 'def'
]

{ #category : #test }
BlockDefTest >> testBlockTuple [
	| d ret |
	d := self newDef.
	d
		block: 'set oled w %n h %n';
		defaultArgs: #(64 128);
		id: 1.
	ret := d blockTuple.
	self
		assertCollection: ret
		equals: #('set oled w %n h %n' - #int1arg1:arg2: 64 128)
]

{ #category : #test }
BlockDefTest >> testCode [
	| d |
	d := self newDef.
	self assert: d code isNil.
	d code: 'abc'.
	self assert: d code equals: 'abc'.
	d code: 'def'.
	self assert: d code equals: 'def'
]

{ #category : #test }
BlockDefTest >> testCodeWithArgs [
	| d ret |
	d := self newDef.
	d block: 'a %n b %n'.
	d code: '%n2=%n1'.
	ret := d codeWithArgs: { 'abc' . 'def' }.
	self assert: ret equals: 'def=abc'.
	d block: 'set digital pin %n for %P'.
	d code: '_pin%n1=Pin(%n1,Pin.%P)'.
	ret := d codeWithArgs: { '5' . 'OUTPUT' }.
	self assert: ret equals: '_pin5=Pin(5,Pin.OUTPUT)'.
	d block: 'set pwm pin %n freq %n duty %n'.
	d code: '_pwm%n1=PWM(Pin(%n1),freq=%n2,duty=%n3)'.
	ret := d codeWithArgs: { '3' . '123' . '456' }.
	self assert: ret equals: '_pwm3=PWM(Pin(3),freq=123,duty=456)'.
	d block: 'i2c write %s to %n'.
	d code: 'i2c.write(%n,bytes(%''s))'.
	ret := d
		codeWithArgs:
			{[ '''[1,2,3]''' ].
			[ 5 ]}.
	self assert: ret equals: 'i2c.write(5,bytes([1,2,3]))'
]

{ #category : #test }
BlockDefTest >> testDefaultArgs [
	| d |
	d := self newDef.
	self assert: d defaultArgs isEmpty.
	d defaultArgs: #(1 2 3).
	self assertCollection: d defaultArgs equals: #(1 2 3)
]

{ #category : #test }
BlockDefTest >> testEvaluatedArgs [
	| d ret |
	d := self newDef.
	d block: 'lcd text %s at %n , %n fg %c bg %c'.
	d code: 'lcd.draw_string(%n1,%n2,%s,lcd.%c1,lcd.%c2)'.
	ret := d
		evaluatedArgs:
			{[ 'hello' ].
			[ '101' ].
			[ '102' ].
			[ 'RED' ].
			[ 'BLACK' ]}.
	self
		assertCollection: ret
		equals: #('101' '102' 'hello' 'RED' 'BLACK').
	d block: 'set digital pin %n for %P'.
	d code: '_pin%n1=Pin(%n1,Pin.%P)'.
	ret := d
		evaluatedArgs:
			{[ 5 ].
			[ 'OUTPUT' ]}.
	self assertCollection: ret equals: #('5' '5' 'OUTPUT').
	d block: 'abc %s def %n'.
	d code: 'x%''sy%n'.
	ret := d
		evaluatedArgs:
			{[ '''OUTPUT''' ].
			[ 5 ]}.
	self assertCollection: ret equals: #('OUTPUT' '5').
	d block: 'i2c write %s to %n'.
	d code: 'i2c.write(%n,bytes(%''s))'.
	ret := d
		evaluatedArgs:
			{[ '''[1,2,3]''' ].
			[ 0 ]}.
	self assertCollection: ret equals: #('0' '[1,2,3]')
]

{ #category : #test }
BlockDefTest >> testFindPosIn [
	| d |
	d := self newDef.
	self assert: (d findPos: '%a' in: #('%a' '%b' '%c' '%d')) equals: 1.
	self assert: (d findPos: '%b' in: #('%a' '%b' '%c' '%d')) equals: 2.
	self assert: (d findPos: '%c' in: #('%a' '%b' '%c' '%d')) equals: 3.
	self assert: (d findPos: '%d' in: #('%a' '%b' '%c' '%d')) equals: 4.
	self assert: (d findPos: '%a1' in: #('%a' '%a' '%a' '%a')) equals: 1.
	self assert: (d findPos: '%a2' in: #('%a' '%a' '%a' '%a')) equals: 2.
	self assert: (d findPos: '%a3' in: #('%a' '%a' '%a' '%a')) equals: 3.
	self assert: (d findPos: '%a4' in: #('%a' '%a' '%a' '%a')) equals: 4.
	self assert: (d findPos: '%b1' in: #('%a' '%b' '%b' '%a')) equals: 2.
	self assert: (d findPos: '%b2' in: #('%a' '%b' '%b' '%a')) equals: 3
]

{ #category : #test }
BlockDefTest >> testId [
	| d |
	d := self newDef.
	d id: 123.
	self assert: d id equals: 123.
	d block: 'abc'.
	d id: nil.
	self assert: d id equals: 238630446
]

{ #category : #test }
BlockDefTest >> testImports [
	| d |
	d := self newDef.
	self assert: d imports isEmpty.
	d imports: #(1 2 3).
	self assertCollection: d imports equals: #(1 2 3).
	d imports: #(4 5 6).
	self assertCollection: d imports equals: #(4 5 6)
]

{ #category : #test }
BlockDefTest >> testIsArgSpec [
	| d |
	d := self newDef.
	self assert: (d isArgSpec: '%a').
	self assert: (d isArgSpec: '%b').
	self deny: (d isArgSpec: '%').
	self deny: (d isArgSpec: 'x')
]

{ #category : #test }
BlockDefTest >> testIsBlockDef [
	| d |
	d := self newDef.
	self assert: d isBlockDef
]

{ #category : #test }
BlockDefTest >> testIsReporter [
	| d |
	d := self newDef.
	self deny: d isReporter.
	d return: 'r'.
	self assert: d isReporter.
	d return: '-'.
	self deny: d isReporter.
	d return: 'b'.
	self assert: d isReporter
]

{ #category : #test }
BlockDefTest >> testIsSeparator [
	| d |
	d := self newDef.
	self deny: d isSeparator
]

{ #category : #test }
BlockDefTest >> testIsUnquoteArg [
	| d |
	d := self newDef.
	self deny: (d isUnquoteArg: '%a').
	self deny: (d isUnquoteArg: '%b').
	self deny: (d isUnquoteArg: '%').
	self deny: (d isUnquoteArg: '%''').
	self deny: (d isUnquoteArg: 'x').
	self assert: (d isUnquoteArg: '%''a').
	self assert: (d isUnquoteArg: '%''b')
]

{ #category : #test }
BlockDefTest >> testParseCommandSpec [
	| d |
	d := self newDef.
	self
		assertCollection: (d parseCommandSpec: 'abc %n')
		equals: #(abc '%n').
	self
		assertCollection: (d parseCommandSpec: 'abc %n    def %s')
		equals: #(abc '%n' def '%s').
	self
		assertCollection: (d parseCommandSpec: 'abc%n1def%s23gh')
		equals: #(abc '%n1' def '%s23' gh).
	self
		assertCollection: (d parseCommandSpec: 'abc% def%')
		equals: #(abc '%' def '%').
	self
		assertCollection: (d parseCommandSpec: 'abc%''a def%')
		equals: #(abc '%''a' def '%')
]

{ #category : #test }
BlockDefTest >> testPrefix [
	| d |
	d := self newDef.
	self assert: d prefix equals: 'int'
]

{ #category : #test }
BlockDefTest >> testPrintOn [
	| d st |
	d := self newDef.
	d block: 'this %s is %n a %x pen'.
	d id: 10.
	st := WriteStream on: String new.
	d printOn: st.
	self assert: st contents equals: 'BlockDef(10,this %s is %n a %x pen)'
]

{ #category : #test }
BlockDefTest >> testPrivSelector [
	self testSelector
]

{ #category : #test }
BlockDefTest >> testReturn [
	| d |
	d := self newDef.
	self assert: d return equals: '-'.
	d return: 'r'.
	self assert: d return equals: 'r'
]

{ #category : #test }
BlockDefTest >> testSelector [
	| d |
	d := self newDef.
	d privSelector: #abc.
	self assert: d selector equals: #abc.
	d privSelector: #def.
	self assert: d selector equals: #def
]

{ #category : #test }
BlockDefTest >> testSelector2 [
	| d |
	d := self newDef.
	d block: 'this %s is %n a %x pen'.
	d id: 10.
	self assert: d selector equals: #int10arg1:arg2:arg3:
]

{ #category : #test }
BlockDefTest >> testSplitArg [
	| d |
	d := self newDef.
	self assert: (d splitArg: '%') equals: #('%' '').
	self assert: (d splitArg: '%a') equals: #('%a' '').
	self assert: (d splitArg: '%a1') equals: #('%a1' '').
	self assert: (d splitArg: '%''a1') equals: #('%''a1' '').
	self assert: (d splitArg: '%ab') equals: #('%a' 'b').
	self assert: (d splitArg: '%%') equals: #('%' '%').
	self assert: (d splitArg: '%$') equals: #('%' '$')
]

{ #category : #test }
BlockDefTest >> testUnquoteString [
	| g |
	g := self newDef.
	self assert: (g unquoteString: 'abc') equals: 'abc'.
	self assert: (g unquoteString: '''abc') equals: '''abc'.
	self assert: (g unquoteString: 'abc''') equals: 'abc'''.
	self assert: (g unquoteString: '''abc''') equals: 'abc'
]
