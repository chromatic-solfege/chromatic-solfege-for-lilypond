
if ( module && module.exports ) {
	module.exports = require( './chromadoc-formatter.js' );
}

if ( module.require == module.main ) {
	require( './chromadoc-formatter.js' ).commandInterface();
}
