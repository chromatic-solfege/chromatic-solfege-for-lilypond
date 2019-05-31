
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

Although this system is partially written by nodejs, this system does not depend on npm.

## Subsystems

+chromatic
  + js
    + chromatic ( a command program to transpose notes )
  + ly
  + lytex
  + tex

