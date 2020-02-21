"
A MicroPythonGeneratorTest is a test class for testing the behavior of MicroPythonGenerator
"
Class {
	#name : #MicroPythonGeneratorTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
MicroPythonGeneratorTest >> newGenerator [
	^ MicroPythonGenerator new
]

{ #category : #test }
MicroPythonGeneratorTest >> testAbs [
	| g |
	g := self newGenerator.
	self assert: (g abs: 10) equals: 'abs(10)'.
	self assert: (g abs: 1.5) equals: 'abs(1.5)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testAbsSign [
	| g |
	g := self newGenerator.
	self assert: (g abs: 6 sign: -5) equals: 'math.copysign(6,-5)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testAddExtModule [
	| g |
	g := self newGenerator.
	self assert: g extModules isCollection.
	self assert: g extModules isEmpty.
	g addExtModule: 'abc'.
	self assert: (g extModules includes: 'abc').
	self deny: (g extModules includes: 'def').
	g addExtModule: 'def'.
	self assert: (g extModules includes: 'abc').
	self assert: (g extModules includes: 'def')
]

{ #category : #test }
MicroPythonGeneratorTest >> testAddInit [
	| g |
	g := self newGenerator.
	self assert: g inits isEmpty.
	g addInit: 'a'.
	self assert: (g inits includes: 'a')
]

{ #category : #test }
MicroPythonGeneratorTest >> testAndWith [
	| g |
	g := self newGenerator.
	self
		assert: (g and: [ g getTrue ] with: [ g getFalse ])
		equals: 'True and False'
]

{ #category : #test }
MicroPythonGeneratorTest >> testAnyOf [
	| g |
	g := self newGenerator.
	self assert: (g anyOf: 'x') equals: 'random.random_choice(x)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testAppendToList [
	| g |
	g := self newGenerator.
	g append: '1' toList: 'x'.
	self assert: g code equals: 'x.append(1)' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testAppendWithNewline [
	| g |
	g := self newGenerator.
	g appendWithNewline: 'abc'.
	g appendWithNewline: 'def'.
	self assert: g code equals: 'abc' , String lf , 'def' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testBinaryFunctionArg1Arg2 [
	| g |
	g := self newGenerator.
	self
		assert: (g binaryFunction: 'abc' arg1: [ 10 ] arg2: [ 1 + 2 ])
		equals: 'abc(10,3)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testBinaryOperatorArg1Arg2 [
	| g |
	g := self newGenerator.
	self
		assert: (g binaryOperator: '+' arg1: [ 10 ] arg2: [ 1 + 2 ])
		equals: '10+3'
]

{ #category : #test }
MicroPythonGeneratorTest >> testBreak [
	| g |
	g := self newGenerator.
	g break.
	self assert: g code equals: 'break' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testCallSub [
	| g |
	g := self newGenerator.
	g callSub: 'a'.
	self assert: g code equals: '_r=a()' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testChangeVarBy [
	| g |
	g := self newGenerator.
	g changeVar: 'x' by: '2'.
	self assert: g code equals: 'x = x + 2' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testCode [
	| g |
	g := self newGenerator.
	self assert: g code isEmpty.
	g appendWithNewline: 'abc'.
	g appendWithNewline: 'def'.
	self assert: g code equals: 'abc' , String lf , 'def' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testComputeFunctionOf [
	| g |
	g := self newGenerator.
	self assert: (g computeFunction: 'abs' of: 'x') equals: 'abs(x)'.
	self assert: (g computeFunction: 'sin' of: 'x') equals: 'math.sin(x)'.
	self assert: (g computeFunction: 'ln' of: 'x') equals: 'math.log(x)'.
	self
		assert: (g computeFunction: 'log' of: 'x')
		equals: 'math.log10(x)'.
	self
		assert: (g computeFunction: '10 ^' of: 'x')
		equals: 'math.pow(10,x)'.
	self assert: (g computeFunction: 'e ^' of: 'x') equals: 'math.exp(x)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testConcatenateWith [
	| g |
	g := self newGenerator.
	self assert: (g concatenate: 'x' with: 'y') equals: 'x + y'
]

{ #category : #test }
MicroPythonGeneratorTest >> testContentsOfList [
	| g |
	g := self newGenerator.
	self assert: (g contentsOfList: 'x') equals: 'x'
]

{ #category : #test }
MicroPythonGeneratorTest >> testContinue [
	| g |
	g := self newGenerator.
	g continue.
	self assert: g code equals: 'continue' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDef [
	| g |
	g := self newGenerator.
	g def: 'abc'.
	self assert: g code equals: 'def abc():' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDelInit [
	| g |
	g := self newGenerator.
	self assert: g inits isEmpty.
	g addInit: 'a'.
	g addInit: 'b'.
	self assert: (g inits includes: 'a').
	self assert: (g inits includes: 'b').
	g delInit: 'a'.
	g delInit: 'c'.
	self deny: (g inits includes: 'a').
	self assert: (g inits includes: 'b').
	self deny: (g inits includes: 'c')
]

{ #category : #test }
MicroPythonGeneratorTest >> testDeleteLineOfList [
	| g |
	g := self newGenerator.
	g deleteLine: 5 ofList: 'x'.
	self assert: g code equals: 'del x[5]' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDivideBy [
	| g |
	g := self newGenerator.
	self assert: (g divide: 1 by: 2) equals: '1 / 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoForeverBegin [
	| g |
	g := self newGenerator.
	g doForeverBegin.
	self assert: g code equals: 'while True:' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoForeverEnd [
	| g |
	g := self newGenerator.
	g doForeverEnd.
	self assert: g code equals: ''
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoIfBegin [
	| g |
	g := self newGenerator.
	g doIfBegin: 'a'.
	self assert: g code equals: 'if a:' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoIfElse [
	| g |
	g := self newGenerator.
	g doIfElse: 'a'.
	self assert: g code equals: 'else:' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoIfEnd [
	| g |
	g := self newGenerator.
	g doIfEnd: 'x'.
	self assert: g code equals: ''
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoRepeatBegin [
	| g |
	g := self newGenerator.
	g doRepeatBegin: '10'.
	self assert: g code equals: 'for _v1 in range(10):' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoRepeatEndLabels [
	| g |
	g := self newGenerator.
	g doRepeatEndLabels: 'x'.
	self assert: g code equals: ''
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoUntilBegin [
	| g |
	g := self newGenerator.
	g doUntilBegin: '1=2'.
	self assert: g code equals: 'while not(1=2):' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoUntilEnd [
	| g |
	g := self newGenerator.
	g doUntilEnd: 10.
	self assert: g code equals: ''
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoWhileBegin [
	| g |
	g := self newGenerator.
	g doWhileBegin: '1=2'.
	self assert: g code equals: 'while 1=2:' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testDoWhileEnd [
	| g |
	g := self newGenerator.
	g doWhileEnd: 10.
	self assert: g code equals: ''
]

{ #category : #test }
MicroPythonGeneratorTest >> testEqualTo [
	| g |
	g := self newGenerator.
	self assert: (g equal: 1 to: 2) equals: '1 == 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testEvaluateOf [
	| g |
	g := self newGenerator.
	self assert: (g evaluate: 'a' of: 'b') equals: 'b.a()'
]

{ #category : #test }
MicroPythonGeneratorTest >> testExecuteOf [
	| g |
	g := self newGenerator.
	g execute: 'a' of: 'b'.
	self assert: g code equals: 'b.a()' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testExtModules [
	| g |
	g := self newGenerator.
	self assert: g extModules isCollection.
	self assert: g extModules isEmpty
]

{ #category : #test }
MicroPythonGeneratorTest >> testFalseString [
	| g |
	g := self newGenerator.
	self assert: g falseString equals: 'False'
]

{ #category : #test }
MicroPythonGeneratorTest >> testFromImport [
	| g |
	g := self newGenerator.
	self assert: g modules isEmpty.
	g from: 'machine' import: 'abc'.
	self assert: ((g modules at: 'machine') includes: 'abc')
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateFromImport [
	| g |
	g := self newGenerator.
	g generateFrom: 'abc' import: 'def'.
	self assert: g code equals: 'from abc import def' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateHeader [
	| g |
	g := self newGenerator.
	g generateHeader.
	self assert: g header isEmpty.
	g import: 'abc'.
	g from: 'def' import: 'ghi'.
	g useVar: 'a'.
	g useListVar: 'b'.
	g generateHeader.
	self
		assert: g header
		equals:
			'import abc' , String lf , 'from def import ghi' , String lf
				, 'a=None' , String lf , 'b=[]' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateImport [
	| g |
	g := self newGenerator.
	g generateImport: 'abc'.
	self assert: g code equals: 'import abc' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateIndent [
	| g |
	g := self newGenerator.
	g generateIndent: 2.
	self assert: g code equals: '        '
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateInitLists [
	| g |
	g := self newGenerator.
	g useListVar: 'a'.
	g useListVar: 'b'.
	g generateInitLists.
	self assert: g code equals: 'a=[]' , String lf , 'b=[]' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateInitModules [
	| g |
	g := self newGenerator.
	g import: 'abc'.
	g import: 'def'.
	g from: 'a' import: 'b'.
	g from: 'c' import: 'd'.
	g generateInitModules.
	self
		assert: g code
		equals:
			'import abc' , String lf , 'import def' , String lf
				, 'from a import b' , String lf , 'from c import d' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGenerateInitVars [
	| g |
	g := self newGenerator.
	g useVar: 'a'.
	g useVar: 'b'.
	g generateInitVars.
	self assert: g code equals: 'a=None' , String lf , 'b=None' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGeneratePass [
	| g |
	g := self newGenerator.
	g generatePass.
	self assert: g code equals: 'pass' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testGetFalse [
	| g |
	g := self newGenerator.
	self assert: g getFalse equals: 'False'
]

{ #category : #test }
MicroPythonGeneratorTest >> testGetLineOfList [
	| g |
	g := self newGenerator.
	self assert: (g getLine: 5 ofList: 'x') equals: 'x[5]'
]

{ #category : #test }
MicroPythonGeneratorTest >> testGetList [
	| g |
	g := self newGenerator.
	self assert: (g getList: 'x') equals: 'x'
]

{ #category : #test }
MicroPythonGeneratorTest >> testGetTrue [
	| g |
	g := self newGenerator.
	self assert: g getTrue equals: 'True'
]

{ #category : #test }
MicroPythonGeneratorTest >> testHeader [
	| g |
	g := self newGenerator.
	self assert: g header isEmpty.
	g import: 'abc'.
	self assert: g header equals: 'import abc' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testImport [
	| g |
	g := self newGenerator.
	self assert: g imports isEmpty.
	g import: 'abc'.
	self assert: (g imports includes: 'abc').
	g import: 'def'.
	self assert: (g imports includes: 'abc').
	self assert: (g imports includes: 'def')
]

{ #category : #test }
MicroPythonGeneratorTest >> testImports [
	| g |
	g := self newGenerator.
	self assert: g imports isCollection.
	self assert: g imports isEmpty
]

{ #category : #test }
MicroPythonGeneratorTest >> testInitialize [
	| g |
	g := self newGenerator.
	self assert: g varNo equals: 0.
	self assert: g imports isCollection.
	self assert: g listVars isCollection.
	self assert: g vars isCollection.
	self assert: g inits isCollection.
	self assert: g modules isDictionary
]

{ #category : #test }
MicroPythonGeneratorTest >> testInits [
	| g |
	g := self newGenerator.
	self assert: g inits isCollection.
	self assert: g inits isEmpty
]

{ #category : #test }
MicroPythonGeneratorTest >> testInsertAtOfList [
	| g |
	g := self newGenerator.
	g insert: 1 at: 2 ofList: 'x'.
	self assert: g code equals: 'x.insert(2,1)' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testIsBetweenAnd [
	| g |
	g := self newGenerator.
	self assert: (g is: 2 between: 3 and: 4) equals: '(3)<(2)<(4)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testIsNone [
	| g |
	g := self newGenerator.
	self assert: (g isNone: 'x') equals: 'x is None'
]

{ #category : #test }
MicroPythonGeneratorTest >> testLessThan [
	| g |
	g := self newGenerator.
	self assert: (g less: 1 than: 2) equals: '1 < 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testLetterOf [
	| g |
	g := self newGenerator.
	self assert: (g letter: 6 of: 'x') equals: '(x)[6]'
]

{ #category : #test }
MicroPythonGeneratorTest >> testLineCountOfList [
	| g |
	g := self newGenerator.
	self assert: (g lineCountOfList: 'x') equals: 'len(x)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testListContains [
	| g |
	g := self newGenerator.
	self assert: (g list: 'x' contains: 5) equals: '5 in x'
]

{ #category : #test }
MicroPythonGeneratorTest >> testListDirInto [
	| g |
	g := self newGenerator.
	g listDirInto: 'a'.
	self assert: g code equals: 'a=os.listdir()' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testListPosition [
	| g |
	g := self newGenerator.
	self assert: (g listPosition: 1) equals: '1'.
	self assert: (g listPosition: [21]) equals: '21'.
	self assert: (g listPosition: '''all''') equals: ':'.
	self assert: (g listPosition: '''last''') equals: '-1'
]

{ #category : #test }
MicroPythonGeneratorTest >> testListVars [
	| g |
	g := self newGenerator.
	self assert: g listVars isCollection.
	self assert: g listVars isEmpty
]

{ #category : #test }
MicroPythonGeneratorTest >> testLiteralStringFrom [
	| g |
	g := self newGenerator.
	self assert: (g literalStringFrom: 'a') equals: '''a'''.
	self assert: (g literalStringFrom: '10') equals: '10'.
	self assert: (g literalStringFrom: 10) equals: '10'
]

{ #category : #test }
MicroPythonGeneratorTest >> testMath [
	| g |
	g := self newGenerator.
	self assert: g math equals: 'math.'.
	self assert: (g imports includes: 'math')
]

{ #category : #test }
MicroPythonGeneratorTest >> testMinusWith [
	| g |
	g := self newGenerator.
	self assert: (g minus: 1 with: 2) equals: '1 - 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testModBy [
	| g |
	g := self newGenerator.
	self assert: (g mod: 1 by: 2) equals: '1 % 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testModules [
	| g |
	g := self newGenerator.
	self assert: g modules isDictionary.
	self assert: g modules isEmpty
]

{ #category : #test }
MicroPythonGeneratorTest >> testMoreThan [
	| g |
	g := self newGenerator.
	self assert: (g more: 1 than: 2) equals: '1 > 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testMultiplyAnd [
	| g |
	g := self newGenerator.
	self assert: (g multiply: 1 and: 2) equals: '1 * 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testNeoPixel [
	| g |
	g := self newGenerator.
	self assert: (g neoPixel: 3) equals: '_np3'.
	self assert: (g imports includes: 'neopixel')
]

{ #category : #test }
MicroPythonGeneratorTest >> testNeoPixelNoRGB [
	| g |
	g := self newGenerator.
	g
		neoPixel: 1
		no: 2
		r: 3
		g: 4
		b: 5.
	self assert: g code equals: '_np1[2]=(3,4,5)' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testNewVariable [
	| g |
	g := self newGenerator.
	self assert: g newVariable equals: '_v1'.
	self assert: g newVariable equals: '_v2'.
	self assert: g varNo equals: 2
]

{ #category : #test }
MicroPythonGeneratorTest >> testNewlineCR [
	| g |
	g := self newGenerator.
	self assert: g newlineString equals: String lf.
	g newlineCR.
	self assert: g newlineString equals: String cr
]

{ #category : #test }
MicroPythonGeneratorTest >> testNewlineCRLF [
	| g |
	g := self newGenerator.
	self assert: g newlineString equals: String lf.
	g newlineCRLF.
	self assert: g newlineString equals: String crlf
]

{ #category : #test }
MicroPythonGeneratorTest >> testNewlineLF [
	| g |
	g := self newGenerator.
	self assert: g newlineString equals: String lf.
	g newlineCRLF.
	self assert: g newlineString equals: String crlf.
	g newlineLF.
	self assert: g newlineString equals: String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testNewlineString [
	self testNewlineLF
]

{ #category : #test }
MicroPythonGeneratorTest >> testNot [
	| g |
	g := self newGenerator.
	self assert: (g not: g getFalse) equals: 'not(False)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testNullaryFunction [
	| g |
	g := self newGenerator.
	self
		assert: (g nullaryFunction: 'abc')
		equals: 'abc()'
]

{ #category : #test }
MicroPythonGeneratorTest >> testNumberOf [
	| g |
	g := self newGenerator.
	self assert: (g numberOf: '''123''') equals: 'int(''123'')'
]

{ #category : #test }
MicroPythonGeneratorTest >> testOrWith [
	| g |
	g := self newGenerator.
	self
		assert: (g or: [ g getTrue ] with: [ g getFalse ])
		equals: 'True or False'
]

{ #category : #test }
MicroPythonGeneratorTest >> testPlusAnd [
	| g |
	g := self newGenerator.
	self assert: (g plus: 1 and: 2) equals: '1 + 2'
]

{ #category : #test }
MicroPythonGeneratorTest >> testPrint [
	| g |
	g := self newGenerator.
	g print: 10.
	self assert: g code equals: 'print(10)' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testQuotedString [
	| g |
	g := self newGenerator.
	self assert: (g quotedString: 'abc') equals: '''abc'''.
	self assert: (g quotedString: 'ab''c') equals: '''ab\''c'''.
	self assert: (g quotedString: 'ab\c') equals: '''ab\\c'''
]

{ #category : #test }
MicroPythonGeneratorTest >> testRandom [
	| g |
	g := self newGenerator.
	self assert: g random equals: 'random.'.
	self assert: (g imports includes: 'random')
]

{ #category : #test }
MicroPythonGeneratorTest >> testRandomFromTo [
	| g |
	g := self newGenerator.
	self assert: (g randomFrom: 1 to: 10) equals: 'random.randint(1,10)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testReplaceAllListWith [
	| g |
	g := self newGenerator.
	g replaceAllList: 'x' with: '''a b c'''.
	self assert: g code equals: 'x = (''a b c'').split()' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testReturn [
	| g |
	g := self newGenerator.
	g return: [ 0 ].
	self assert: g code equals: 'return 0' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testReturnValue [
	| g |
	g := self newGenerator.
	self assert: g returnValue equals: '_r'
]

{ #category : #test }
MicroPythonGeneratorTest >> testRounded [
	| g |
	g := self newGenerator.
	self assert: (g rounded: 'x') equals: 'round(x)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testSetLineOfListTo [
	| g |
	g := self newGenerator.
	g setLine: 4 ofList: 'x' to: 5.
	self assert: g code equals: 'x[4] = 5' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testSetRandomSeed [
	| g |
	g := self newGenerator.
	g setRandomSeed: 123.
	self assert: g code equals: 'random.seed(123)' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testSetVarTo [
	| g |
	g := self newGenerator.
	g setVar: 'x' to: '1+2'.
	self assert: g code equals: 'x = 1+2' , String lf
]

{ #category : #test }
MicroPythonGeneratorTest >> testStopThread [
	| g |
	g := self newGenerator.
	g stopThread.
	self assert: g code equals: ''
]

{ #category : #test }
MicroPythonGeneratorTest >> testStringLength [
	| g |
	g := self newGenerator.
	self assert: (g stringLength: '''abc''') equals: 'len(''abc'')'
]

{ #category : #test }
MicroPythonGeneratorTest >> testStringOf [
	| g |
	g := self newGenerator.
	self assert: (g stringOf: '123') equals: 'str(123)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testTernaryFunctionArg1Arg2Arg3 [
	| g |
	g := self newGenerator.
	self
		assert: (g ternaryFunction: 'abc' arg1: [ 10 ] arg2: [ 1 + 2 ] arg3: [ 4 ])
		equals: 'abc(10,3,4)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testUnaryFunctionArg [
	| g |
	g := self newGenerator.
	self
		assert: (g unaryFunction: 'abc' arg: [ 10 ])
		equals: 'abc(10)'
]

{ #category : #test }
MicroPythonGeneratorTest >> testUnquoteString [
	| g |
	g := self newGenerator.
	self assert: (g unquoteString: 'abc') equals: 'abc'.
	self assert: (g unquoteString: '''abc') equals: '''abc'.
	self assert: (g unquoteString: 'abc''') equals: 'abc'''.
	self assert: (g unquoteString: '''abc''') equals: 'abc'
]

{ #category : #test }
MicroPythonGeneratorTest >> testUseListVar [
	| g |
	g := self newGenerator.
	self assert: g listVars isEmpty.
	g useListVar: 'a'.
	self assert: (g listVars includes: 'a').
	self deny: (g listVars includes: 'b')
]

{ #category : #test }
MicroPythonGeneratorTest >> testUseVar [
	| g |
	g := self newGenerator.
	self assert: g vars isEmpty.
	g useVar: 'a'.
	self assert: (g vars includes: 'a').
	self deny: (g vars includes: 'b')
]

{ #category : #test }
MicroPythonGeneratorTest >> testValueOf [
	| g |
	g := self newGenerator.
	self assert: (g valueOf: 'a') equals: 'a'.
	self assert: (g valueOf: 10) equals: '10'.
	self assert: (g valueOf: [10]) equals: '10'
]

{ #category : #test }
MicroPythonGeneratorTest >> testVarNo [
	| g |
	g := self newGenerator.
	self assert: g varNo equals: 0
]

{ #category : #test }
MicroPythonGeneratorTest >> testVariableArgString [
	| g |
	g := self newGenerator.
	self assert: (g variableArgString: 'a') equals: 'a'.
	self assert: (g vars includes: 'a')
]

{ #category : #test }
MicroPythonGeneratorTest >> testVars [
	| g |
	g := self newGenerator.
	self assert: g vars isCollection.
	self assert: g vars isEmpty
]