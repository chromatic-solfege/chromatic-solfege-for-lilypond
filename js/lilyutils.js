
var o = {
	getLilypondCommandLine : function() {
		return require( 'chromadoc/settings' ).__lilypondCommandLine;
	},
	commandInterface : function() {
		console.log( o.getLilypondCommandLine() );
	},
};

module.exports = o;

if ( module.require == module.main ) {
	o.commandInterface();
}
