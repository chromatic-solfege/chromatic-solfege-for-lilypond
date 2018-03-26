#!/usr/bin/nodejs

var ch = require( 'chromatic' );

function out( s ) {
	process.stdout.write( s );
}
function format( s, l ) {
	var s = String(s);
	while ( s.length < l ) {
		s = s + ' ';
	}
	return s;
}

function formatAll( arr,l  ) {
	for ( var i=0; i< arr.length; i++ ) {
		arr[i] = format( arr[i] , l ) ;
	}
	return arr;
}

var L = 4;

/////////////////

{
	let a = [
		[ 'daws','raws','maws','faws','saws','laws','taws', ],
		[ 'dawm','rawm','mawm','fawm','sawm','lawm','tawm', ],
		[ 'dawf','rawf','mawf','fawf','sawf','lawf','tawf', ],
		[ 'dawn','rawn','mawn','fawn','sawn','lawn','tawn', ],
		[ 'daw', 'raw', 'maw', 'faw', 'saw', 'law', 'taw',  ],
		[ 'dem', 'ram', 'mem', 'fem', 'sem', 'lem', 'tem',  ],
		[ 'de' , 'ra',  'me',  'fe',  'se',  'le',  'te',   ],
		[ 'dew', 'rew', 'mew', 'few', 'sew', 'lew', 'tew',  ],
		[ 'do' , 're',  'mi',  'fa',  'sol', 'la',  'ti',   ],
		[ 'dia', 'ria', 'mia', 'fia', 'sia', 'lia', 'tia',  ],
		[ 'di' , 'ri',  'ma',  'fi',  'si',  'li',  'ta',   ],
		[ 'dim', 'rim', 'mam', 'fim', 'sim', 'lim', 'tam',  ],
		[ 'dai', 'rai', 'mai', 'fai', 'sai', 'lai', 'tai',  ],
		[ 'dain','rain','main','fain','sain','lain','tain', ],
		[ 'daif','raif','maif','faif','saif','laif','taif', ],
		[ 'daim','raim','maim','faim','saim','laim','taim', ],
		[ 'dais','rais','mais','fais','sais','lais','tais', ],
	];

	var TIN  = '<td>';
	var TOUT = '</td>';
	var TOI  = TOUT + TIN;

	out( '<html><body>\n' );
	out( `\
	<style>
		table { 
			border : 0px none;
			table-layout: fixed;
			width: 320px;
			font-size : 10px;
			background-color : silver;
			float:left;
		}
		td {
			width   : 20px;
			height  : 8px;
			background-color : white;
		}
	</style>
`);

	// Outer Loop
	for ( var i1=0; i1<a.length; i1++ ) {
		for ( var j1=0; j1<a[i1].length; j1++ ) {
			var key = a[i1][j1];

			out( '<table>\n' );
			// Inner Loop
			for ( var i2=0; i2<a.length; i2++ ) {
				out( '<tr>\n' );
				out( TIN + format( key, L ) + TOI + formatAll( ch.transpose( key, a[i2] ), L ) .join( TOI ) + TOUT  + '\n' );
				out( '</tr>\n' );
			}
			out( '</table>\n' );
		}
		out( '<br style="clear:both"/>\n' );
	}
	out( '</body></html>\n' );
}

