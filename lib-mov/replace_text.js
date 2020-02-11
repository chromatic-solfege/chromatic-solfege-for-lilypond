#!/usr/bin/nodejs

var fs = require('fs');

var inputFile = process.argv[2];
var searchString = process.argv[3];
var replacementFile = process.argv[4];

if ( ! inputFile || ! searchString || ! replacementFile  ) {
    console.error( "[USAGE] replace-text [input-file] [search-string] [replacement-file]" );
    return;
}

var inputString  = fs.readFileSync(inputFile, 'utf8');

/*
var inputFileName = require( 'path' ).basename( inputFile );
var isHeader = false;
console.error( 'inputFileName', inputFileName );
console.error( 'inputFileName.search( /[0-9]+-Header/)'   , inputFileName.search( /[0-9]+-Header/   ) );
console.error( 'inputFileName.search( /[0-9]+-Abstract/ )', inputFileName.search( /[0-9]+-Abstract/ ));
if ( 0<= inputFileName.search( /[0-9]+-Header/   ) ||
     0<= inputFileName.search( /[0-9]+-Abstract/ )) {
    isHeader = true;
}
if ( isHeader ) {
    replacementString = replacementString.replace( /\.*\s*$/gm, "" ).trim();
}
*/


var replacementString  = fs.readFileSync(replacementFile, 'utf8');

var outputString = inputString.replace( new RegExp( searchString, "gm" ), replacementString );

process.stdout.write( outputString );

