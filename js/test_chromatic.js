#!/usr/bin/nodejs

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

var ch = require( 'chromatic' );

{
	let  a = [
		'do','di','re','ri','mi','fa','fi','sol','si','la','li','ti','do',
		'do','ti','te','la','le','sol','se','fa','mi','me','re','ra','do',
		'de','ta','fe','ma',
	];
	for ( var i=0; i<a.length; i++ ) {
		out( formatAll( ch.transpose( a[i], a ) ,L  ) .join( ' ' )  + '\n' );
	}
}

out( '\n' );

{
	let a = [
		[ 'daes','raes','maes','faes','saes','laes','taes', ],
		[ 'dawm','rawm','mawm','fawm','sawm','lawm','tawm', ],
		[ 'dae', 'rae', 'mae', 'fae', 'sae', 'lae', 'tae',  ],
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
		[ 'dao', 'rao', 'mao', 'fao', 'sao', 'lao', 'tao',  ],
		[ 'daim','raim','maim','faim','saim','laim','taim', ],
		[ 'daos','raos','maos','faos','saos','laos','taos', ],
	];

	// Outer Loop
	for ( var i1=0; i1<a.length; i1++ ) {
		for ( var j1=0; j1<a[i1].length; j1++ ) {
			var key = a[i1][j1];
			out( '========= ' + key + '=========\n' );
			// Inner Loop
			for ( var i2=0; i2<a.length; i2++ ) {
				out( format( key, L ) + ' ' + formatAll( ch.transpose( key, a[i2] ), L ) .join( ' ' )  + '\n' );
			}
			out( '\n' );
		}
	}
}

