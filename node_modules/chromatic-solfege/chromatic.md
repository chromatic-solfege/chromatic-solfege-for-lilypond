
JavaScript Module `chromatic/chromatic.js`
===========================================

## Overview
'Chromatic.js' is a Node.js library to operate the notes and the intervals
which are defined in Chromatic-Solfege. In this module, it defines all notes of
Chromatic-Solfege and offers functions to transpose specified note names.

## Usage
	var chromatic = require( 'chromatic' );
	var r = chromatic.transpose( "re", "mi" )
	console.log( r ); // "fi"

## Methods
- transpose
- transposeScript
- enharmonize
- enharmonize2
- isQuadrupleSharp
- isQuadrupleFlat
- isQuadrupleAccidental
- isTripleSharp
- isTripleFlat
- isTripleAccidental
- isDoubleSharp
- isDoubleFlat
- isDoubleAccidental
- isSharp
- isFlat
- isNatural
- isNote
- isAccidental
- isIrregularAccidental
- putTripleAccidentals
- respell
- note2number
- number2note
- note2alphabet
- note2alphabet_tex
- commandInterface

### transpose( root : string, intervals: string, is_absolute : boolean ) : string

This function transposes a single note.

- root
	Specifies the root note.

- intervals
	Specifies the interval from the root note.

- is_absolute
TODO

- returns 
	transposed note name as a string value.

	console.log( chromatic.transpose( "do", "do" ) ); // "do"
	console.log( chromatic.transpose( "do", "re" ) ); // "re"
	console.log( chromatic.transpose( "do", "mi" ) ); // "mi"
	console.log( chromatic.transpose( "fa", "do" ) ); // "fa"
	console.log( chromatic.transpose( "fa", "re" ) ); // "sol"
	console.log( chromatic.transpose( "fa", "mi" ) ); // "la"

### transposeScript( macro : string, preference : Object )

This function transposes multiple notes at once. This function takes a string
text which contains a simple macro language which we call Chromatic Solfege
Note Specifier Abstraction Layer. See below for the information about the macro
language.

- macro
	Takes a simple macro program.

- preference
	Takes an object to override the current preference. This module takes
	multilevel preference object system. See below.

- returns
	an array that contains transposed note names.


### enharmonize

This function returns an enharmonized note name of the given note.

- note
	A note name to enharmonize or an array contains note names to enharmonize.

	console.log( c.enharmonize( "raw" ) ); // "do"
	console.log( c.enharmonize( "de"  ) ); // "ti"


### enharmonize2

This function returns an enharmonic note name of the given note. The note will
be selected by an internally defined priority. This function is left for
backward compatibility and new applications should not use this function.

- note name
	A note name to convert.

- type
	Specifies the algorithm of convertion. 
	This should be one of following strings: 'ds', 's', 'n', 'f', 'df'.


### isQuadrupleSharp( note )
Returns true if the specified value is a quadruple sharp.

### isQuadrupleFlat( note )
Returns true if the specified value is a quadruple flat.

### isQuadrupleAccidental( note )
Returns true if the specified value is with a quadruple accidental.

### isTripleSharp( note )
Returns true if the specified value is with a triple sharp.

### isTripleFlat( note )
Returns true if the specified value is with a triple flat.

### isTripleAccidental( note )
Returns true if the specified value is with a triple accidental.


### isDoubleSharp( note )
Returns true if the specified value is with a double sharp.

### isDoubleFlat( note )
Returns true if the specified value is with a double flat.

### isDoubleAccidental( note )
Returns true if the specified value is with a double accidental.

### isSharp( note )
Returns true if the specified value is with a sharp.

### isFlat( note )
Returns true if the specified value is with a flat.

### isAccidental( note )
Returns true if the specified value is with an accidental.

### isNatural( note )
Returns true if the specified value is natural and without any accidentals.

### isNote( note )
Returns true if the specified value is a note name.

### isIrregularAccidental( note )
Returns true if the specified value is one of 'de', 'ta' , 'ma', 'fe'.

### putTripleAccidentals
This is a lilypond helper function. This function puts a triple accidental tag
before the note name if the specified is with a triple accidental.

### respell
This function converts note names with flat into sharp and vice a versa.

### note2number
Returns an integer value which denotes a specific note. We call the integer
numbers as note index. The note indices start from zero. And the number will
increase one with every half note.

	console.log( c.note2number( "do" ) ); // 0
	console.log( c.note2number( "re" ) ); // 2
	console.log( c.note2number( "do'" ) ); // 12
	console.log( c.note2number( "do," ) ); // -12


### number2note
Returns a note name of the specified note index.

	console.log( c.number2note( 12 ) );  // do'
	console.log( c.number2note( -12 ) ); // do,

### note2alphabet
Returns an alphabetical note name of the specified note name as unicode string.

	console.log( c.note2alphabet( 'rai' ) ); // d𝄫
	console.log( c.note2alphabet( 'di' ) );  // c♯

### note2alphabet_tex
Returns an alphabetical note name of the specified note name as tex command
string.

	console.log( c.note2alphabet_tex( 'rai' ) ); // "d \flatflat"
	console.log( c.note2alphabet_tex( 'di' ) );  // "c \sharp"


### commandInterface
This function implements a simple commandline interface.

	commandInterface( Array.prototype.slice.call( process.argv, 2) );

##  Chromatic Solfege Note Specifier Abstraction Layer

The transposeScript() function can parse and execute a simple macro language
which name is Chromatic Solfege Note Specifier Abstraction Layer. The main
purpose of this small language is dynamically transposing series of note names.
This language also accepts some modifiers which can be specified by tags. 
The output data is designed to be sent to lilypond afterwards in mind.


### Basic

This can transpose multiple notes. Notes should separated by one or more
spaces.

	console.log( c.transposeScript( "do re  mi" ) ); // "do re mi"




## Multilevel Preference Object
TODO


