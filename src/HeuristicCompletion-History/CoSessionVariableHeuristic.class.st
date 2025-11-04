Class {
	#name : 'CoSessionVariableHeuristic',
	#superclass : 'CoASTNodeFetcherHeuristic',
	#instVars : [
		'session'
	],
	#category : 'HeuristicCompletion-History',
	#package : 'HeuristicCompletion-History'
}

{ #category : 'requests' }
CoSessionVariableHeuristic >> appliesForNode: aNode inContext: aContext [

	^ aNode isVariable
]

{ #category : 'requests' }
CoSessionVariableHeuristic >> buildFetcherFor: aMessageNode inContext: aContext [
	
        ^ CoCollectionFetcher onCollection:
                        (self session words collect: [ :each |
                                | key node |
                                each isAssociation
                                        ifTrue: [ key := each key. node := each value ]
                                        ifFalse: [ key := each. node := nil ].
                                NECVariableEntry
                                        contents: (key isString
                                                ifTrue: [ key ]
                                                ifFalse: [ key asString ])
                                        node: node ])
]

{ #category : 'accessing' }
CoSessionVariableHeuristic >> session [
	^ session ifNil: [ session := CoSessionVariable current ]
]

{ #category : 'accessing' }
CoSessionVariableHeuristic >> session: anObject [
	session := anObject
]
