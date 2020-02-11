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

if ( true ) {
    var examiningFileName = require( 'path' ).basename( replacementFile );
    var isHeader = false;
    console.error( 'examiningFileName', examiningFileName );
    console.error( 'examiningFileName.search( /[0-9]+-Header/)'   , examiningFileName.search( /[0-9]+-Header/   ) );
    console.error( 'examiningFileName.search( /[0-9]+-Abstract/ )', examiningFileName.search( /[0-9]+-Abstract/ ));

    if ( 0<= examiningFileName.search( /[0-9]+-Header/   ) ||
         0<= examiningFileName.search( /[0-9]+-Abstract/ )) 
    {
        isHeader = true;
    }

    if ( isHeader ) {
        replacementString = replacementString.replace( /\.*\s*$/gm, "" ).trim();
    }
}

var outputString = inputString.replace( new RegExp( searchString, "gm" ), replacementString );

process.stdout.write( outputString );

