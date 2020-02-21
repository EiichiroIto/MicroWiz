Class {
	#name : #TimerMorph,
	#superclass : #Morph,
	#instVars : [
		'target',
		'stepTime'
	],
	#category : #'MicroWiz-Spec2'
}

{ #category : #stepping }
TimerMorph >> step [
	target ifNil: [ ^ self ].
	target step
]

{ #category : #stepping }
TimerMorph >> stepTime [
	^ stepTime
]

{ #category : #accessing }
TimerMorph >> stepTime: anInteger [
	stepTime := anInteger
]

{ #category : #accessing }
TimerMorph >> target [
	^ target
]

{ #category : #accessing }
TimerMorph >> target: anObject [
	target := anObject
]

{ #category : #stepping }
TimerMorph >> wantsSteps [
	^ true
]
