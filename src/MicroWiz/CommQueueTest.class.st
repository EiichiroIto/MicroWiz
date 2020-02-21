"
A CommQueueTest is a test class for testing the behavior of CommQueue
"
Class {
	#name : #CommQueueTest,
	#superclass : #TestCase,
	#category : #'MicroWiz-Tests'
}

{ #category : #private }
CommQueueTest >> newComm [
	^ DummyComm new
]

{ #category : #private }
CommQueueTest >> newQueue [
	^ CommQueue new
]

{ #category : #test }
CommQueueTest >> testComm [
	| q c |
	q := self newQueue.
	self assert: q comm isNil.
	c := self newComm.
	q comm: c.
	self assert: q comm equals: c
]

{ #category : #test }
CommQueueTest >> testDefaultDelimiter [
	| q |
	q := self newQueue.
	self assert: q defaultDelimiter equals: Character cr asciiValue
]

{ #category : #test }
CommQueueTest >> testDefaultTimeout [
	| q |
	q := self newQueue.
	self assert: q defaultTimeout equals: 1000
]

{ #category : #test }
CommQueueTest >> testDelimiter [
	| q |
	q := self newQueue.
	self assert: q delimiter equals: q defaultDelimiter.
	q delimiter: Character lf asciiValue.
	self assert: q delimiter equals: Character lf asciiValue
]

{ #category : #test }
CommQueueTest >> testEnqueueWithDelimiter [
	| q |
	q := self newQueue.
	q pending add: 1.
	q pending add: 2.
	q pending add: 3.
	q delimiter: 99.
	self assert: q queue isEmpty.
	q enqueueWithDelimiter.
	self assert: q queue size equals: 1.
	self assertCollection: q queue first equals: #[1 2 3 99].
	self assert: q pending isEmpty
]

{ #category : #test }
CommQueueTest >> testFlush [
	| q c |
	q := self newQueue.
	c := self newComm.
	q comm: c.
	q pending addAll: #[1 2 3].
	q queue add: #[4 5 6].
	c getQueue add: #[7 8 9].
	self deny: q pending isEmpty.
	self deny: q queue isEmpty.
	self deny: c getQueue isEmpty.
	q flush.
	self assert: q pending isCollection.
	self assert: q pending isEmpty.
	self assert: q queue isCollection.
	self assert: q queue isEmpty.
	self assert: c getQueue isCollection.
	self assert: c getQueue isEmpty
]

{ #category : #test }
CommQueueTest >> testGet [
	| q c |
	q := self newQueue.
	c := self newComm.
	q comm: c.
	self assert: q get isNil.
	self assert: q queue isEmpty.
	q queue add: #[1 2 3].
	self assertCollection: q get equals: #[1 2 3].
	self assert: q queue isEmpty.
	self assert: q get isNil.
	c addGetQueue: #[4 5 6 13 7 8 9 13 10 11].
	self assertCollection: q get equals: #[4 5 6 13].
	self assertCollection: q get equals: #[7 8 9 13].
	self assert: q get isNil.
	q timeout: 10.
	0.1 asSeconds wait.
	self assertCollection: q get equals: #[10 11]
]

{ #category : #test }
CommQueueTest >> testInitialize [
	| q |
	q := self newQueue.
	self assert: q pending isCollection.
	self assert: q pending isEmpty.
	self assert: q queue isCollection.
	self assert: q queue isEmpty.
	self assert: q timeout equals: q defaultTimeout.
	self assert: q delimiter equals: q defaultDelimiter.
	self assert: q lastMSec isInteger
]

{ #category : #test }
CommQueueTest >> testIsTimeout [
	| q |
	q := self newQueue.
	self deny: q isTimeout.
	self deny: q isTimeout.
	q timeout: 100.
	0.1 asSeconds wait.
	self assert: q isTimeout
]

{ #category : #test }
CommQueueTest >> testLastMSec [
	| q |
	q := self newQueue.
	self assert: q lastMSec isInteger
]

{ #category : #test }
CommQueueTest >> testPending [
	| q |
	q := self newQueue.
	self assert: q pending isCollection.
	self assert: q pending isEmpty
]

{ #category : #test }
CommQueueTest >> testProcessReceived [
	| q |
	q := self newQueue.
	q pending add: 99.
	q processReceived: #[1 2 13 4 5 6 13 7 8].
	self assert: q queue size equals: 2.
	self assertCollection: q queue first equals: #[99 1 2 13].
	self assertCollection: q queue second equals: #[4 5 6 13].
	self assertCollection: q pending asByteArray equals: #[7 8]
]

{ #category : #test }
CommQueueTest >> testQueue [
	| q |
	q := self newQueue.
	self assert: q queue isCollection.
	self assert: q queue isEmpty
]

{ #category : #test }
CommQueueTest >> testTimeout [
	| q |
	q := self newQueue.
	self assert: q timeout equals: q defaultTimeout.
	q timeout: 234.
	self assert: q timeout equals: 234.
	q timeout: 123.
	self assert: q timeout equals: 123
]

{ #category : #test }
CommQueueTest >> testUpdateLastMSec [
	| q x |
	q := self newQueue.
	x := q lastMSec.
	0.1 asSeconds wait.
	q updateLastMSec.
	self assert: q lastMSec - x >= 100
]
