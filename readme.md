
Chromatic Solfege Documenting Toolkit
=======================================

## Introduction

This toolkit contains some programs for writing documentation about chromatic
solfege. Chromatic solfege is an extension of traditional solfege system which
is generally known as *"do re mi"*. Solfege is using name system which is based
on the diatonic scale while chromatic solfege is based on the twelve note
chromatic scale. Note names of chromatic solfege go as *"do di re ri mi ..."*

This system is designed for describing this new solfege system. This system
contains programs to perform following tasks : 

- Automatically generating TeX file.
- Transposing chromatic note names.
- Creating scores from chromatic note names.
- Creating singing voice data from chromatic note names.
- Automatically generating mechanical scale practice patterns.
- Enumerating all possible fingering pattern for guitar from chromatic note
  names and generating fingerboard charts.

## System Requirement

This system is built on following systems :
	- Lilypond
	- Scheme
	- notejs 
	- bash
	- xelatex
	- Festival Speech Synthesis System

Although this system is partially written by nodejs, this system does not depend on npm.

## Directories

+ chromatic
	+ js 
		A directory for subsystems which are written by JavaScirpt.

		- chromatic 
			A commandline interface of a subsystem to transpose notes based on the
			chromatic solfege.

		- test_chromatic.js
			A simple test program for "chromatic" module.

		- test_chromatic_html.js
			A simple test program for "chromatic" module.

		+ node_modules
			+ chromatic 
				This is a node module to implement Chromatic Solfege. This module
				contains various modules to handle Chromatic Solfege specific
				problems.

				- chromatic-formatter.js
					A module to output tex script that simplifies writing documents
					which consist both lilypond scripts and tex scripts.
					  
				- chromatic.js
					A subsystem to transpose notes based on the chromatic solfege.

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

	+ ly 
		A directory to keep utilities which are written by Lilypond or Scheme.

		- aaron.ly
			A library that defines note names which are based on the chromatic
			solfege.

		- chromatic-festival.scm
			A library which enables Festival to read the note names which are based
			on the chromatic solfege correctly.

		- chromatic-template.ly
			This defines a Scheme function which outputs a music staff and other
			utilities.

		- guitar-scale-diagram.ly
			This defines Scheme functions to implement displaying fingerboard-chart
			of guitar.
		
		- include-scm.ly
			An utility to include Scheme scripts from Lilypond scripts. This is
			currently not used.

	+ lytex
		- out
			The directory where all output files go. 

		- ch-???-\*
			We call these files as ``ch-scripts''. A ch-scripts contains document
			data and creates tex, lilypond, festival and other scripts.

		- ch-000-chromatic-solfege
			A ch-script to output the data for the book of "Chromatic Solfege"

		- ch-001-chromatic-solfege-for-guitarists-01
		- ch-002-chromatic-solfege-for-guitarists-02
			A ch-script to output the data for the book of "Chromatic Solfege for
			Guitarists". The script file was very large that it took hours to compile;
			it divided into two files. the file-01 consists the description and file-02
			consists fretboard-charts.

		- compile2
			This automates all compilation process. This executes the specified
			ch-scripts and then compiles all files that the ch-scripts created.

		- lilypond_cmd
			A commandline program which outputs a commandline string to execute
			Lilypond.

		- music2mp3
			A bash script file to convert all wave files in the 'out' directory
			into mp3.
		- openwav
			This scirpt opens all wave files by calling ``gnome-open'' command.

		- node_modules
			- chromatic
				A symbolic link to a node module directory 'chromatic/js/chromatic'.
			- local
				- settings.js
					This overrides the setting of "chromatic" node module.
			
		- query-fretdiagram-systems-\*
			Temporary files that the node module "chromatic" creates. These file
			can safely be deleted.

		- scale-generator
			An old unused file. This could be deleted.

	+ tex
		- chromatic-solfege.tex
			The main file for the book "Chromatic Solfege".

		- chromatic-solfege-for-guitarists.tex
			The main file for the book "Chromatic Solfege for Guitarists".
		
		- ly-generated
			A symbolic link to "chromatic/lytex/out/" where the all automatically
			generated files go.

		- ly-manual
			All Lilypond scripts for both "chromatic-solfege.tex" and
			"chromatic-solfege-for-guitarists.tex"


## How to Use the System

