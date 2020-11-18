!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aBook anotherBook invalidBook aCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:31:19'!
test01newCartShouldBeEmpty
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:31:34'!
test02canAddOneCopyOfValidBook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: 1 copiesOf:aBook.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:31:51'!
test03canAddOneCopyOfManyValidBooks
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: 1 copiesOf: aBook.
	aCart add: 1 copiesOf: anotherBook.
	
	self deny: aCart isEmpty.
	self assert: (aCart contains: aBook).
	self assert: (aCart contains: anotherBook).! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:32:13'!
test04canNotAddCopiesOfBookNotInCatalog
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [ aCart add: 1 copiesOf: invalidBook ] raise: Error withMessageText: Cart invalidBookMessage.
	
	self assert: aCart isEmpty. 
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:32:32'!
test05canNotAddNegativeCopiesOfABook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [ aCart add: -1 copiesOf: aBook ] raise: Error withMessageText: Cart invalidQuantity.
	
	self assert: aCart isEmpty. 
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:32:50'!
test06canNotAddZeroCopiesOfABook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [ aCart add: 0 copiesOf: aBook ] raise: Error withMessageText: Cart invalidQuantity.
	
	self assert: aCart isEmpty. 
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:33:03'!
test07canAddMultipleCopiesOfOneValidBook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: 2 copiesOf: aBook.

	self deny: aCart isEmpty.
	self assert: (aCart copiesOf: aBook) equals: 2.
! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'FC 11/16/2020 19:07:55'!
setUp
	
	aBook := 'Librito'.
	anotherBook := 'Design Patterns'.
	invalidBook := 'Computer Networks: A systems approach'.
	aCatalog := OrderedCollection with: aBook with: anotherBook.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'FC 11/16/2020 19:38:55'!
contains: aBook
	^contents includes: aBook.! !

!Cart methodsFor: 'testing' stamp: 'FC 11/16/2020 18:57:38'!
isEmpty
	^contents isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'FC 11/16/2020 19:42:27'!
initializeFor: aCatalog
	catalog := aCatalog.
	contents := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'FC 11/16/2020 19:41:31'!
add: aQuantity copiesOf: aBook
	(catalog includes: aBook) ifFalse:[self error: self class invalidBookMessage].
	(aQuantity <= 0) ifTrue: [self error: self class invalidQuantity].
	contents add: aBook withOccurrences: aQuantity.! !


!Cart methodsFor: 'accessing' stamp: 'FC 11/16/2020 19:39:15'!
copiesOf: aBook
	^contents occurrencesOf: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'FC 11/16/2020 19:10:18'!
withCatalog: aCatalog
	^self new initializeFor: aCatalog.! !


!Cart class methodsFor: 'error' stamp: 'FC 11/16/2020 19:09:50'!
invalidBookMessage
	^'Book not in catalog'.! !

!Cart class methodsFor: 'error' stamp: 'FC 11/16/2020 19:28:39'!
invalidQuantity
	^'Book quantity must be positive'.! !
