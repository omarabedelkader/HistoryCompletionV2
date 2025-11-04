"
I am an heuristic that autocompletes messages based on a session vocabulary.
"
Class {
	#name : 'CoSessionMessagesHeuristic',
	#superclass : 'CoASTNodeFetcherHeuristic',
	#instVars : [
		'session'
	],
	#category : 'HeuristicCompletion-History',
	#package : 'HeuristicCompletion-History'
}

{ #category : 'requests' }
CoSessionMessagesHeuristic >> appliesForNode: aNode inContext: aContext [

	^ aNode isMethod or: [ aNode isMessage ]
]

{ #category : 'requests' }
CoSessionMessagesHeuristic >> buildFetcherFor: aMessageNode inContext: aContext [
	
	^ CoCollectionFetcher onCollection: 
			( self session words collect: [ :each | (NECSelectorEntry contents: each key node: each value) ])
]

{ #category : 'accessing' }
CoSessionMessagesHeuristic >> session [
	^ session ifNil: [ session := CoSession current ]
]

{ #category : 'accessing' }
CoSessionMessagesHeuristic >> session: anObject [
	session := anObject
]
