"
A SpMicroWizStageTest is a test class for testing the behavior of SpMicroWizStage
"
Class {
	#name : #SpMicroWizStageTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
SpMicroWizStageTest >> newApplication [
	^ SpMicroWiz new
]

{ #category : #private }
SpMicroWizStageTest >> newStage [
	^ SpMicroWizFrame basicNew
		application: self newApplication;
		initialize;
		privStage
]

{ #category : #test }
SpMicroWizStageTest >> testFilterOutput [
	| s fr app plotter ret |
	s := self newStage.
	fr := s owner.
	self assert: (fr isKindOf: SpMicroWizFrame).
	app := fr application.
	self assert: (app isKindOf: SpMicroWiz).
	plotter := fr privEditor plotter.
	self assert: (plotter isKindOf: ScratchPlotterMorph).
	app suppressPaste: false.
	plotter acceptPlots: false.
	ret := s filterOutput: 'abc'.
	self assert: ret equals: 'abc'.
	ret := s filterOutput: '123' , String cr , '456'.
	self assert: ret equals: '123' , String cr , '456'.
	ret := s filterOutput: '123' , String cr , '456' , String cr.
	self assert: ret equals: '123' , String cr , '456' , String cr.
	ret := s filterOutput: '=== 123' , String cr , 'def' , String cr.
	self assert: ret equals: '=== 123' , String cr , 'def' , String cr.
	app suppressPaste: true.
	ret := s filterOutput: '=== 123' , String cr , 'def' , String cr.
	self assert: ret equals: 'def' , String cr.
	ret := s filterOutput: '=== 123' , String cr , 'def'.
	self assert: ret equals: 'def'.
	plotter acceptPlots: true.
	self assert: plotter numData equals: 0.
	ret := s filterOutput: '123' , String cr , '456'.
	self assert: ret equals: '456'.
	self assert: plotter numData equals: 1.
	plotter reset.
	ret := s filterOutput: '123' , String cr , '456' , String cr.
	self assert: ret isEmpty.
	self assert: plotter numData equals: 2
]

{ #category : #test }
SpMicroWizStageTest >> testInPasteMode [
	| s |
	s := self newStage.
	self deny: s inPasteMode.
	s inPasteMode: true.
	self assert: s inPasteMode.
	s inPasteMode: false.
	self deny: s inPasteMode
]

{ #category : #test }
SpMicroWizStageTest >> testPlotDataFromString [
	| s ret |
	s := self newStage.
	self assert: (s plotDataFromString: 'abc') isEmpty.
	ret := s plotDataFromString: '123'.
	self assert: ret size equals: 1.
	self assert: (ret first isKindOf: ScratchPlotData).
	self assert: ret first channel equals: 1.
	self assert: ret first data equals: 123.
	ret := s plotDataFromString: '45 67'.
	self assert: ret size equals: 2.
	self assert: (ret first isKindOf: ScratchPlotData).
	self assert: ret first channel equals: 1.
	self assert: ret first data equals: 45.
	self assert: (ret second isKindOf: ScratchPlotData).
	self assert: ret second channel equals: 2.
	self assert: ret second data equals: 67.
	ret := s plotDataFromString: '[45, 67]'.
	self assert: ret size equals: 2.
	self assert: (ret first isKindOf: ScratchPlotData).
	self assert: ret first channel equals: 1.
	self assert: ret first data equals: 45.
	self assert: (ret second isKindOf: ScratchPlotData).
	self assert: ret second channel equals: 2.
	self assert: ret second data equals: 67
]
