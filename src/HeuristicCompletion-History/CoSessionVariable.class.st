Class {
	#name : 'CoSessionVariable',
	#superclass : 'Object',
	#instVars : [
		'vocabularyCache'
	],
	#classVars : [
		'Current'
	],
	#category : 'HeuristicCompletion-History',
	#package : 'HeuristicCompletion-History'
}

{ #category : 'accessing' }
CoSessionVariable class >> current [ 

	^ Current ifNil: [ Current := self new ]
]

{ #category : 'actions' }
CoSessionVariable class >> deinstall [
	<script>
	
	self environment codeChangeAnnouncer unsubscribe: self current.
	CoSessionVariable allInstances 
		do: [ :each | self environment codeChangeAnnouncer unsubscribe: each ]
]

{ #category : 'actions' }
CoSessionVariable class >> install [
	<script>
	
	self environment codeChangeAnnouncer
		when: ClassAdded 
		send: #addNewVariableInVocabulary: 
		to: self current.
	"
	This does not work for now because we are expecting a node and the menu does not give us a node
	in addition we do not get the."
	"self environment codeChangeAnnouncer
		when: CompletionItemSelected
		send: #addMessageInVocabulary: 
		to: self current."
]

{ #category : 'initialization' }
CoSessionVariable class >> reset [
	<script>
	Current ifNotNil: [ 
		self environment codeChangeAnnouncer
			unsubscribe: Current.
	Current := nil ]
]

{ #category : 'adding' }
CoSessionVariable >> addNewVariableInVocabulary: anAnn [
	
	self addVocabulary: (anAnn class -> anAnn class) at: DateAndTime now 
]

{ #category : 'adding' }
CoSessionVariable >> addVariableInVocabulary: anAnn [

	self addVocabulary: anAnn selectedItem class  at: DateAndTime now
]

{ #category : 'adding' }
CoSessionVariable >> addVocabulary: aString at: aDateAndTime [

	vocabularyCache at: aString put: aDateAndTime
]

{ #category : 'initialization' }
CoSessionVariable >> initialize [

	super initialize.
	vocabularyCache := LRUCache new maximumWeight: 1000
]

{ #category : 'accessing' }
CoSessionVariable >> size [
	^ vocabularyCache size
]

{ #category : 'matching' }
CoSessionVariable >> words [

	^ vocabularyCache keys
]
