"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFromScratch,
	#superclass : #PackageManifest,
	#category : #'FromScratch-Manifest'
}

{ #category : #'code-critics' }
ManifestFromScratch class >> ruleRBLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CommandBlockMorphTest #testEvaluateInfixWithArgs #false)) #'2020-02-21T09:57:42.512167+09:00') )
]
