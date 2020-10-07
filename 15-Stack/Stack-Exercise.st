!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:16:28'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:16:21'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:16:35'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:25:35'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:16:46'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:16:53'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:17:01'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:17:34'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:17:04'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'FC 10/5/2020 17:17:41'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'mentaGranizada ddl chocolate ddlGranizado chocolateSuizo sampleStack sentenceFinder emptyStack emptyFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/7/2020 18:31:01'!
test01shouldFindDulceDeLeche
	
	| foundSentences |
	
	foundSentences := sentenceFinder find: 'Dulce'.
	
	self assert:  (foundSentences  size) equals: 2.
	self shouldContain: foundSentences Element: ddl. 
	self shouldContain: foundSentences Element: ddlGranizado.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/5/2020 18:15:31'!
test02shouldBeEmpty
	
	| foundSentences |
	
	foundSentences := sentenceFinder find: 'Banana'.
	
	self assert:  (foundSentences  size) equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/7/2020 18:32:49'!
test03findIsCaseSensitive
	
	| foundSentences |
	
	foundSentences := sentenceFinder find: 'chocolate'.
	
	self assert:  (foundSentences  size) equals: 1.
	self shouldContain: foundSentences Element: chocolateSuizo ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/5/2020 20:52:42'!
test04cantFindEmptyString
	
	
	self
		should: [ sentenceFinder find: '' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorMessageBlankPrefix ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/5/2020 20:53:02'!
test05cantFindTrailingSpacesString
	
	
	self
		should: [ sentenceFinder find: '         ' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorMessageBlankPrefix ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/7/2020 18:35:06'!
test06findShouldNotModifyUnderlyingStack
	
	
	sentenceFinder find: 'Hola'.
	
	self assert: sampleStack size equals: 5.
	self assert: sampleStack top equals: chocolateSuizo.
	self assert: (sampleStack pop; 
						top) equals: ddlGranizado.
	self assert: (sampleStack pop; 
						top) equals: chocolate.
	self assert: (sampleStack pop; 
						top) equals: ddl.
	self assert: (sampleStack pop; 
						top) equals: mentaGranizada .						! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'FC 10/7/2020 18:39:15'!
test07cantFindOnEmptyStack	
	|foundSentences|
	foundSentences := emptyFinder find: 'Dulce'.
	
	self assert: foundSentences isEmpty.
	self assert: 	emptyStack isEmpty.! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'FC 10/7/2020 18:31:40'!
shouldContain: aCollection Element: anElement
	aCollection detect: [:element | element = anElement ] ifNone: [self fail.]! !


!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'FC 10/7/2020 18:38:00'!
setUp 
	
	mentaGranizada := 'Menta granizada'.
	ddl := 'Dulce de leche'.
	chocolate := 'Chocolate'.
	ddlGranizado := 'Dulce de leche granizado'.
	chocolateSuizo := 'chocolate suizo'.
	
	sampleStack := OOStack new.
	sampleStack push: mentaGranizada;
				push: ddl;
				push: chocolate;
				push: ddlGranizado;
				push: chocolateSuizo.
				
	emptyStack := OOStack new.
				
	sentenceFinder := SentenceFinderByPrefix  newWith: sampleStack.
	emptyFinder := SentenceFinderByPrefix  newWith: emptyStack.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'FC 10/5/2020 19:42:41'!
initialize
	stackElements := OOStackBase new! !


!OOStack methodsFor: 'operations' stamp: 'FC 10/5/2020 20:43:51'!
pop
	|topElement|
	
	topElement := stackElements current.
	stackElements := stackElements previous.
	
	^topElement ! !

!OOStack methodsFor: 'operations' stamp: 'FC 10/5/2020 20:42:59'!
push: anElement
	
	stackElements := OOStackTop  newWith: anElement  And: stackElements.! !


!OOStack methodsFor: 'accessing' stamp: 'FC 10/5/2020 17:27:15'!
size
	^stackElements size.! !

!OOStack methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:40:16'!
top
	^stackElements current.
	! !


!OOStack methodsFor: 'testing' stamp: 'FC 10/5/2020 17:22:25'!
isEmpty
	^stackElements isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElements category: 'Stack-Exercise'!
Object subclass: #OOStackElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElements methodsFor: 'testing' stamp: 'FC 10/5/2020 20:51:04'!
isEmpty
	self subclassResponsibility.! !


!OOStackElements methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:50:45'!
current
	self subclassResponsibility.! !

!OOStackElements methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:50:44'!
previous
	self subclassResponsibility.! !

!OOStackElements methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:50:41'!
size
	self subclassResponsibility.! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackElements subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'testing' stamp: 'FC 10/5/2020 20:48:41'!
isEmpty
	^true! !


!OOStackBase methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:45:14'!
current
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:45:26'!
previous
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:44:13'!
size
	^0! !


!classDefinition: #OOStackTop category: 'Stack-Exercise'!
OOStackElements subclass: #OOStackTop
	instanceVariableNames: 'current previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTop methodsFor: 'testing' stamp: 'FC 10/5/2020 20:48:46'!
isEmpty
	^false! !


!OOStackTop methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:39:48'!
current
	^current! !

!OOStackTop methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:39:52'!
previous
	^previous! !

!OOStackTop methodsFor: 'accessing' stamp: 'FC 10/5/2020 20:49:43'!
size
	^1 + previous size.! !


!OOStackTop methodsFor: 'initialization' stamp: 'FC 10/5/2020 20:41:40'!
initializeWith: anElement And: previousStack
	previous := previousStack.
	current := anElement ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackTop class' category: 'Stack-Exercise'!
OOStackTop class
	instanceVariableNames: ''!

!OOStackTop class methodsFor: 'as yet unclassified' stamp: 'FC 10/5/2020 20:42:08'!
newWith: anElement And: previousStack
	^self new initializeWith: anElement And: previousStack.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack auxStack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'FC 10/7/2020 18:24:48'!
addToFoundIfTopBeginsWith: aPrefix
		auxStack push: (stack pop).
		(auxStack top beginsWith: aPrefix ) ifTrue: [foundSentences add: auxStack top].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'FC 10/7/2020 18:27:15'!
reconstructStack

	^ [auxStack isEmpty] whileFalse: [ stack push: auxStack pop]! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'FC 10/7/2020 18:27:15'!
find: aPrefix
	
	aPrefix withBlanksTrimmed  = '' ifTrue:[ 
		self error: SentenceFinderByPrefix errorMessageBlankPrefix
		].
	
	
	foundSentences := OrderedCollection  new.
	
	auxStack := OOStack new.
	
	[stack isEmpty] whileFalse: [ 
			self addToFoundIfTopBeginsWith: aPrefix
		 ].
	
	self reconstructStack.
	
	
	^foundSentences.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'FC 10/5/2020 18:02:07'!
initializeWith: aStack
	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errorMessages' stamp: 'FC 10/5/2020 17:55:15'!
errorMessageBlankPrefix

	^ 'Cant find empty prefix.'! !


!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'FC 10/5/2020 18:13:32'!
newWith: aStack.
	^self new initializeWith: aStack.! !
