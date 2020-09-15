!classDefinition: #I category: #ActividadNumeroPeano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActividadNumeroPeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #ActividadNumeroPeano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'errores' stamp: 'T 9/15/2020 18:47:42'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'errores' stamp: 'T 9/15/2020 18:43:01'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Los numeros negativos no son soportados por este mensaje.'! !


!I class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:19:39'!
* unNumeroDePeano
	^ unNumeroDePeano.! !

!I class methodsFor: 'operaciones' stamp: 'T 9/14/2020 21:28:12'!
+ unNumeroDePeano
	^ unNumeroDePeano next.! !

!I class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:44:04'!
- unNumeroDePeano
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:53:00'!
/ unNumeroDePeano
	^ unNumeroDePeano  = I ifTrue: [^ self] ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].! !

!I class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:17:02'!
next
	^self createChildNamed: self name,'I'.! !


!classDefinition: #II category: #ActividadNumeroPeano!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActividadNumeroPeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #ActividadNumeroPeano!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:20:35'!
* unNumeroDePeano
	^ (self previous  * unNumeroDePeano) + unNumeroDePeano.! !

!II class methodsFor: 'operaciones' stamp: 'T 9/14/2020 22:02:51'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next.! !

!II class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:38:22'!
- unNumeroDePeano
	^unNumeroDePeano = I 
	ifTrue: 
		[^ self previous] 
	ifFalse: 
		[^self previous - unNumeroDePeano previous].
	
	"self error: 'No es posible dividir I por un numero mayor que el"! !

!II class methodsFor: 'operaciones' stamp: 'T 9/15/2020 18:54:05'!
/ unNumeroDePeano
	|cociente dividendo|
	
	[self - unNumeroDePeano] on: Error do: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	cociente := I.
	dividendo := self.
	[ unNumeroDePeano ~= dividendo ] whileTrue: [ cociente := cociente next. dividendo := dividendo - unNumeroDePeano ].
	^ cociente.! !

!II class methodsFor: 'operaciones' stamp: 'T 9/14/2020 21:53:30'!
previous
	^self parent! !


!classDefinition: #III category: #ActividadNumeroPeano!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActividadNumeroPeano'!


!classDefinition: #IIII category: #ActividadNumeroPeano!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActividadNumeroPeano'!


!classDefinition: #numerosDePeanoTest category: #ActividadNumeroPeano!
DenotativeObject subclass: #numerosDePeanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ActividadNumeroPeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'numerosDePeanoTest class' category: #ActividadNumeroPeano!
numerosDePeanoTest class
	instanceVariableNames: ''!

!numerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'T 9/15/2020 02:16:55'!
test01SiguienteDeIEsII
	Assert that: I next isEqualTo: II.! !

!numerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'T 9/15/2020 02:17:20'!
test02SiguienteDeIIEsIII
	Assert that: II next isEqualTo: III.! !

!numerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'T 9/15/2020 02:19:35'!
test03SumaDeIYIEsElSiguienteDeI
	Assert that: I + I isEqualTo: I next.! !

!numerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'T 9/15/2020 02:21:40'!
test04AnteriorDeIIEsI
	Assert that: II previous isEqualTo: I.! !

!numerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'T 9/15/2020 02:21:45'!
test05RestaDeIIYIEsElAnteriorDeII
	Assert that: II - I isEqualTo: II previous.! !

!numerosDePeanoTest class methodsFor: 'as yet unclassified' stamp: 'T 9/15/2020 18:55:20'!
test06MultiplicacionDeIYIEsI
	Assert that: I * I isEqualTo: I.! !
