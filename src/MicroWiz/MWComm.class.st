Class {
	#name : #MWComm,
	#superclass : #Object,
	#category : #'MicroWiz-Comm'
}

{ #category : #api }
MWComm >> close [
	self subclassResponsibility
]

{ #category : #api }
MWComm >> get [
	self subclassResponsibility
]

{ #category : #api }
MWComm >> isConnected [
	self subclassResponsibility
]

{ #category : #api }
MWComm >> open [
	self subclassResponsibility
]

{ #category : #accessing }
MWComm >> options [
	self subclassResponsibility
]

{ #category : #accessing }
MWComm >> optionsNamed: aString [
	self subclassResponsibility
]

{ #category : #api }
MWComm >> put: aByteArray [
	self subclassResponsibility
]

{ #category : #accessing }
MWComm >> setOption: aString to: anObject [
	self subclassResponsibility
]
