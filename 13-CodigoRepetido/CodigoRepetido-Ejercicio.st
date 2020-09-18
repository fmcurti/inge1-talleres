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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:40:16'!
initializeBookWithTestCustomer: customerName
	|customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: customerName.
	^customerBook! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:48:55'!
numberOfActiveCustomers: activeCustomers SuspendedCustomers: suspendedCustomers TotalCustomers: totalCustomers in: customerBook

	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:32:51'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook executionTime |
	
	customerBook := CustomerBook new.
	
	executionTime := self timeExecution: [
	customerBook addCustomerNamed: 'John Lennon'.
	].
	
	self assert: (executionTime) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:41:32'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook executionTime paulMcCartney |
	
	paulMcCartney:= 'Paul McCartney'.
	customerBook := self initializeBookWithTestCustomer: paulMcCartney.
	  
	executionTime := self timeExecution: [
	customerBook removeCustomerNamed: paulMcCartney.
	].
	
	self assert: (executionTime) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:42:18'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook:= self initializeBookWithTestCustomer: johnLennon .
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:51:15'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
		
	paulMcCartney := 'Paul McCartney'.
	customerBook:= self initializeBookWithTestCustomer: paulMcCartney.


	customerBook suspendCustomerNamed: paulMcCartney.
	
	self numberOfActiveCustomers: 0 SuspendedCustomers: 1 TotalCustomers: 1   in: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:50:22'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook  := self initializeBookWithTestCustomer: paulMcCartney .
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self numberOfActiveCustomers: 0 SuspendedCustomers: 0 TotalCustomers: 0   in: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:44:53'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |			

	johnLennon := 'John Lennon'.
	customerBook := self initializeBookWithTestCustomer: johnLennon .
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:44:32'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self initializeBookWithTestCustomer: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FC 9/17/2020 21:31:49'!
timeExecution: codigoATimear
       
  	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	codigoATimear value.
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


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
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
