
if ( module && module.exports ) {
	var __chromatic = require( './chromatic.js' );

	Object.defineProperties( __chromatic, {
		globalSettings : {
			value : 
				function( __settings ) {
					require( 'chromadoc/formatter' ).globalSettings( __settings );
					require( 'chromadoc/lilyutils' ).globalSettings( __settings );
				},
		},
	});

	module.exports = __chromatic;
}

if ( module.require == module.main ) {
	require( './chromatic.js' ).commandInterface( Array.prototype.slice.call( process.argv, 2) );
}
