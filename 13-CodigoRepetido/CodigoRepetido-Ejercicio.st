!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook paulMcCartney johnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:30:39'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self should: [customerBook addCustomerNamed: 'John Lennon'.] notTakeMoreThan: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:31:49'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	customerBook addCustomerNamed: paulMcCartney.
	
	self should:  [ customerBook removeCustomerNamed: paulMcCartney. ] notTakeMoreThan: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:25:19'!
test03CanNotAddACustomerWithEmptyName 

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:26:04'!
test04CanNotRemoveAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon.
	
	[customerBook removeCustomerNamed: paulMcCartney.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:25:23'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	customerBook addCustomerNamed: paulMcCartney.

	customerBook suspendCustomerNamed: paulMcCartney.
	
	self numberOfActiveCustomers: 0 SuspendedCustomers: 1 in: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:25:23'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	customerBook  addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self numberOfActiveCustomers: 0 SuspendedCustomers: 0 in: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:25:27'!
test07CanNotSuspendAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'T 9/22/2020 18:25:27'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	customerBook addCustomerNamed: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'setUp' stamp: 'T 9/22/2020 18:25:57'!
setUp

	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	johnLennon := 'John Lennon'.! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'T 9/22/2020 18:25:06'!
numberOfActiveCustomers: activeCustomers SuspendedCustomers: suspendedCustomers in: aCustomerBook

	self assert: activeCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: activeCustomers + suspendedCustomers equals: aCustomerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'T 9/22/2020 18:29:36'!
should: aClosure notTakeMoreThan: limitTime

	| executionTime |
	
	executionTime := self timeExecution: aClosure.
	
	self assert: (executionTime) < (limitTime * millisecond)! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'T 9/22/2020 18:28:04'!
timeExecution: closureToTime
       
  	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closureToTime value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^millisecondsAfterRunning  - millisecondsBeforeRunning.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'helpers' stamp: 'T 9/22/2020 18:22:15'!
findAndRemove: aCustomer from: aCustomerGroup
	1 to: aCustomerGroup size do: 
	[ :index |
		aCustomer = (aCustomerGroup at: index)
			ifTrue: [
				aCustomerGroup removeAt: index.
				^ aCustomer
			] 
	].! !

!CustomerBook methodsFor: 'helpers' stamp: 'T 9/22/2020 18:22:55'!
move: aCustomer from: aCustomerGroup to: anotherCustomerGroup
	
	aCustomerGroup remove: aCustomer.
	anotherCustomerGroup add: aCustomer
! !


!CustomerBook methodsFor: 'customer management' stamp: 'FC 9/18/2020 18:26:29'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FC 9/18/2020 18:27:02'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FC 9/18/2020 18:43:10'!
removeCustomerNamed: aName 
 
	(self findAndRemove: aName  from: active) = aName ifTrue: [^ aName] .

	(self findAndRemove: aName  from: suspended) = aName ifTrue: [^ aName] .
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FC 9/18/2020 18:49:40'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	self move: aName from: active to: suspended.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
