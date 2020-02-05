
JavaScript Module `chromatic`
===============================

## Overview 

This JavaScript module contains the core process of Chromatic-Solfege
Documentation System. This module can be executed nodejs version 7.10.1 or
later.  This module contains various modules to handle Chromatic-Solfege
specific problems.

- [chromatic.js](./chromatic.md)
	A subsystem to transpose notes based on the chromatic solfege.

- chromatic-formatter.js
	A module to output tex script that simplifies writing documents
	which consist both lilypond scripts and tex scripts.

- chromatic-template.js
	A templating system for writing Lilypond scripts.

- lilyutils.js
	This keeps a command line string to execute Lilypond.

- settings.js
	This keeps various setting of the system.

- formatter.js
	A stub to call "chromatic-formatter.js".

- template.js
	A stub to call "chromatic-template.js".

- index.js
	This is the default script file for the chromatic package and a
	stub to "chromatic.js"


## About Chromatic-Solfege

Chromatic-Solfege is an extended version of the traditional Solfege which you
may know it as "Do Re Mi ..." .  There are twelve musical notes in the modern
music notation system. Only seven out of twelve are named properly and others
are not; when you want to call one of notes which are not properly named, you
have to ask to the notes next to the note you want. For example, there is a
note between "Do" and "Re" which is not named; you have to call it as
"Do-sharp" or "Re-flat" which I believe are too fussy.

Chromatic-Solfege is approaching this issue by directly naming these unnamed
notes.

	----------------------------------
	| SHARP       | | FLAT           |
	==================================
	| Do   |  Do  | |   Do    |  Do  |
	| Do#  |  Di  | |   Re b  |  Ra  |
	| Re   |  Re  | |   Re    |  Re  |
	| Re#  |  Ri  | |   Mi b  |  Me  |
	| Mi   |  Mi  | |   Mi    |  Mi  |
	| Fa   |  Fa  | |   Fa    |  Fa  |
	| Fa#  |  Fi  | |   Sol b |  Se  |
	| Sol  |  Sol | |   Sol   |  Sol |
	| Sol# |  Si  | |   La b  |  Le  |
	| La   |  La  | |   La    |  La  |
	| La#  |  Li  | |   Ti b  |  Te  |
	| Ti   |  Ti  | |   Ti    |  Ti  |
	| Do   |  Do  | |   Do    |  Do  |
	----------------------------------

The basic idea is :

- When it is sharp, the vowel part of the name is replaced with 'i'.
  In case the vowel is already 'i', 'a' is applied.
- When it is flat, the vowel part of the name is replaced with 'e'.
  In case the vowel is already 'e', 'a' is applied.

In this system, other accidentals such as double-sharp, double-flat,
triple-sharp and triple-flat are also defined in the same way. For further
information, please refer the book Understanding Chromatic-Solfege.

	---------------------------------------------------------------------
	| Quadruple Flat  |  daes | raes | maes | faes | saes | laes | taes |  
	| Triple Flat     |  dae  | rae  | mae  | fae  | sae  | lae  | tae  |  
	| Double Flat     |  daw  | raw  | maw  | faw  | saw  | law  | taw  |  
	| Flat            |  de   | ra   | me   | fe   | se   | le   | te   |  
	| Natural         |  do   | re   | mi   | fa   | sol  | la   | ti   |  
	| Sharp           |  di   | ri   | ma   | fi   | si   | li   | ta   |  
	| Double Sharp    |  dai  | rai  | mai  | fai  | sai  | lai  | tai  |  
	| Triple Sharp    |  dao  | rao  | mao  | fao  | sao  | lao  | tao  |  
	| Quadruple Sharp |  daos | raos | maos | faos | saos | laos | taos |  
	---------------------------------------------------------------------

This module is mainly designed to process transposing on this notation system.
The transposed note data are passed to Tex, Lilypond and Festival for further
processing.


