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
var replacementString  = fs.readFileSync(replacementFile, 'utf8');
var outputString = inputString.replace( new RegExp( searchString, "gm" ), replacementString );

process.stdout.write( outputString );

