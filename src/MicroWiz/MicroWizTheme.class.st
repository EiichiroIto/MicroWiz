Class {
	#name : #MicroWizTheme,
	#superclass : #ScratchTheme,
	#category : #'MicroWiz-Spec2'
}

{ #category : #'class initialization' }
MicroWizTheme class >> initialize [
	self setupThemeNamed: 'microwiz'
]

{ #category : #private }
MicroWizTheme class >> themesURL [
	^ 'https://raw.githubusercontent.com/EiichiroIto/MicroWiz/master/Themes.zip'
]
