module.exports = {
	// ScaleGenerator
	festivalFilter : (type,s)=>{
		var filtered = require( 'chromadoc/formatter' ).defaultFestivalFilter( type, s );

		filtered.festival = filtered.festival.
			replace( /è/g, 'e' ).
			replace( /”/g, '"' ).
			replace( /“/g, '"' ).
			replace( /\btextit\b/g,'' );

		return filtered;
	},

	// ScaleGenerator
	/*
	 * XXX This value is also referred by "compile2".
	 */
	// scmFestivalVoice : "voice_us2_mbrola",
	scmFestivalVoice : "voice_us1_mbrola",

	// scmDoCompile : true,
	scmDoCompile : true,
	scmDoPlay  : false,

	// ch-xxx
	texGraphicWidth : 1.0,
	lyTextAfter : [8,3],

	// lilyutils.js
	__lilypondCommandLine : "lilypond -I " + process.env.LILYPOND_INCLUDE_DIR,
	// __lilypondCommandLine : "lilypond -I /home/ats/Documents/works/all/chromadoc/lib/ly/",
	// __lilypondCommandLine : "lilypond -I /home/ats/Documents/works/all/chromadoc/lib/ly/ -I /home/ats/Documents/lilypond/include/",
};
