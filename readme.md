
Chromatic-Solfege Documentation Toolkit
=======================================

## Introduction

This toolkit contains a set of programs for writing documentation with a 
new musical notation which is named *Chromatic-Solfege*.

Chromatic-Solfege is an extension of traditional solfege system which is
generally known as *"do re mi"*. The traditional solfege is using name system
which is based on the diatonic scale. On the other hand, Chromatic-Solfege is
based on the twelve-tone chromatic scale. Every tone in the Chromatic-Solfege
are independently named as *"do di re ri me mi fa ..."*.

This toolkit helps to write documents which contains this new solfege notation.
With this toolkit, the notation which is written by the Chromatic-Solfege is
embeddable to a document. The notations which are embedded to the document are
automatically compiled to sheets of music. The compiler also automatically
generates singing voice of every embedded notations and can be used for other
purposes.

This system contains programs to perform following tasks : 

- Automatically generating TeX file.
- Transposing chromatic note names.
- Creating scores from chromatic note names.
- Creating singing voice data from chromatic note names.
- Automatically generating mechanical scale practice patterns.
- Enumerating all possible fingering pattern for guitar from chromatic note
  names and generating fingerboard charts.

## System Requirement

This system is built on following systems :

- bash
- nodejs 
- xelatex
- Lilypond
- Scheme
- Festival Speech Synthesis System

Although this system is partially written by nodejs, this system does not depend on NPM.

## The Directory Structure

+ chromatic
	- readme.md
		The file which you are now reading. In case you did not notice that
		what you are reading is actually this file, please reconfirm it now.

	- source-this-to-get-started
		A bash script file that initializes this system to start. Currently
		this script just adds ./lib/ directory to your PATH environment
		variable and set the include directory for Lilypond to the environment variable
		`LILYPOND_INCLUDE_DIR`.

	+ lib
		A directory for placing script files.

		- `chromatic` 
			A commandline interface of a subsystem to transpose notes based on the
			chromatic solfege.  [documentation](./lib/chromatic.md)

		- `test_chromatic.js`
			A simple test program for `chromatic` module.

		- `test_chromatic_html.js`
			A simple test program for `chromatic` module.

		- `makech`
			This automates compilation of Chromatic-Solfege documents. This
			executes the specified ch-scripts and then compiles all files that
			the ch-scripts created.

		- `lilypond_cmd`
			A commandline program which outputs a commandline string to execute
			Lilypond.

		- `music2mp3`
			A bash script file to convert all wave files in the 'out' directory
			into mp3.
		- `openwav`
			This scirpt opens all wave files by calling `gnome-open` command.

		- `scale-generator`
			An old unused file. This could be deleted.

		+ `node_modules`
			A directory which includes libraries for node.js 

			+ `chromatic `
				This is a node module to implement Chromatic-Solfege. This module
				contains various modules to handle Chromatic-Solfege specific
				problems.

				- `chromatic-formatter.js`
					A module to output tex script that simplifies writing documents
					which consist both lilypond scripts and tex scripts.
					  
				- `chromatic.js`
					A subsystem to transpose notes based on the chromatic solfege.

				- `chromatic-template.js`
					A templating system for writing Lilypond scripts.

				- `lilyutils.js`
					This keeps a command line string to execute Lilypond.

				- `settings.js`
					This keeps various setting of the system.

				- `formatter.js`
					A stub to call "chromatic-formatter.js".
				- `template.js`
					A stub to call "chromatic-template.js".

				- `index.js`
					This is the default script file for the chromatic package and a
					stub to "chromatic.js"

	+ `lib-ly `
		A directory to keep utilities which are written by Lilypond or Scheme.

		- `aaron.ly`
			A library that defines note names which are based on the chromatic
			solfege.

		- `chromatic-festival.scm`
			A library which enables Festival to read the note names which are based
			on the chromatic solfege correctly.

		- `chromatic-template.ly`
			This defines a Scheme function which outputs a music staff and other
			utilities.

		- `guitar-scale-diagram.ly`
			This defines Scheme functions to implement displaying fingerboard-chart
			of guitar.
		
		- `include-scm.ly`
			An utility to include Scheme scripts from Lilypond scripts. This is
			currently not used.


## Usage

At first, open your terminal with bash as its shell and go to the root
directory of the Chromatic-Solfege documentation system and source a shell
script file which name is "source-this-to-get-started".

	. source-this-and-get-started

This will set up a number of environment variables. 

The main task of using this system is writing JavaScript programs upon
`chromatic.js` and `chromatic-formatter.js`.

	#!/usr/bin/nodejs

	var Chromatic = require('chromatic');
	var ChromaticFormatter = require('chromatic/formatter');

ChromaticFormatter is a class which capsulates a session to output tex and
lilypond scripts; it has to be instantiated on the top of the script file.

	var cf = new ChromaticFormatter( "./output/" );

The only argument of the constructor is to specify a path to a directory where
every output file goes.

    c.t_abstract`
		This document presents how to use the Chromatic-Solfege Documentation
		System. Brab rab rabra ...
	`;

	c.t_header0`Introduction`;
	c.t_textBody`
		This system is so-and-so and such-and-such.
	`;

    c.writeNewPage();
	// Ouput Table of Contents
    c.writeTOC();
    c.writeNewPage();

    c.writeScore( 'example01', `@do do4 re mi `, {} );
	
    c.close();

Note that this system heavily depends on JavaScript's new feature "template
string" that enables users to use JavaScript as documentation tool.

After writing the script file, save it as "ch-000-example".

The file you wrote can be simply executed; it outputs a number of tex scripts
and lilypond scripts. But you usually have to properly compile these files
before you use them in your tex document.  In order to simplify the compilation
process, use `makech`.

	> makech ch-000-example

`makech` clears the output directory and then executes the specified
JavaScript file and invokes Lilypond and Festival Speech System to the created
files.

## Further Information

For further information, please refer the documents of the respective
modules/commands.




[modeline]: # ( vim: set noexpandtab fenc=utf-8 spell spl=en: )
