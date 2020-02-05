function template( arr, settings ) {
	var result = "";
	var templateFilename = "chromatic-template.ly";
	var r = String.raw;

	// console.error( 'settings', settings );

	if ( ! settings ) 
		settings = {
			tempo : 130,
		};

	// console.error( 'default settings', settings );
	function js2scm( k ) {
		k = k.replace( /([A-Z][a-z0-9]*)/g, (s0,s1)=>"-" + s1.toLowerCase() );
		k = k.replace( /^-/, '' );
		return k;
	}
	function value_js2scm( value ) {
		var s = '';
		for ( var i in value ) {
			var matched = /^(scm)(.*)$/.exec( i );
			if ( matched ) {
				switch ( typeof value[i] ) {
					case "string" :
					case "number" :
						s += `( ${js2scm(matched[2])} . ${value[i]} )`;
						break;
					case "boolean" :
						s += `( ${js2scm(matched[2])} . ${value[i] ? '#t' : '#f' } )`;
						break;
					// case "object" :
					// 	if ( Array.isArray( value[i] ) ) {
					// 		var arr=  value[i];
					// 		s += "( " ;
					// 		for ( var idx=0 ; idx<arr.length; idx++ ) {
					// 			s += 
					// 		}
					// 		s += ") " ;
					// 	}
					// 	break;
					default:
				}
			}
		}
		return  s;
	}

	function getSetting() {
		// `'(${s})`;
		return "'(" + value_js2scm( settings ) + ")" ;
	}

result += `
\\version "2.18.2"
\\include "aaron.ly"
\\include "${templateFilename}"
\\include "lilypond-book-preamble.ly"
\\language "aaron"

`;

	function createBlock( caption, comment, notes, lyrics ) {
		var result =  "";
		if ( caption ) {
			result +=
(`
\\markup \\bold \\italic {
    ${caption}
}
`);
		}

		if ( comment ) {
			let es = comment.split( /\n/ );
			for ( let i=0; i<es.length; i++ ) {
				result += "    %" + es[i] + "\n";
			}
		}

		switch ( settings.formatType  ) {
			case 'entire-diagram':
				result += ( r`
					#(define override-default ` + getSetting() + r` )
					\markup 
					  {
						#(create-markup-of-entire-scale-diagram #{ ` + notes  + r` #}
							(ly:assoc-get 'root-offset override-default 0 ) override-default )
					  }
					  #` + getSetting() 
					).replace( /^\s{5}/gm, '' );
				break;
			case 'diagram':
				result += ( r`
					#(define override-default ` + getSetting() + r` )
					#(define scale-diagram-def
						(create-markup-of-scale-diagram 
							#{ \absolute { ` + notes  + r` } #}
							(ly:assoc-get 'fret-positions override-default '(6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1) ) 
							(ly:assoc-get 'skip-count     override-default 0 ) 
							(ly:assoc-get 'root-offset    override-default 0 ) 
							override-default ))

					#(put-markup-on-a-note! 
						(cdr (assq 'visible-music scale-diagram-def))
						'first
						(cdr (assq 'markup scale-diagram-def)))

					\makescore
						\absolute {
							#(cdr (assq 'visible-music scale-diagram-def))
						}
						#` + getSetting() + `
					`).replace( /^\s{5}/gm, '' );
				break;

			case 'queryRangeFretDiagram':
			case 'queryFretDiagram':
				result += ( r`
					#(define override-default ` + getSetting() + r` )
					#(define overhang-def
						(lookup-overhang-offset 
							#{ \absolute { ` + notes  + r` } #}
							(ly:assoc-get 'fret-positions override-default '(6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1) ) 
							(ly:assoc-get 'root-offset    override-default 0 ) 
							'()
							(ly:assoc-get 'display-type   override-default 'full )))

					#(define scale-diagram-def
						 (create-markup-of-scale-diagram
							#{ \absolute { ` + notes  + r` } #}
							(ly:assoc-get 'fret-positions override-default '(6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1) )
							(ly:assoc-get 'skip-count     override-default 30 )
							(ly:assoc-get 'root-offset    override-default 0 )
							override-default ))

					#(format #t "{ \"length\" : ~a, \"startPos\" :~a, \"endPos\" : ~a , \"fingeringNotes\" : [ ~a ], \"visibleNotes\" : [ ~a ] }\n"
						 (cdr (assq 'length    overhang-def))
						 (cdr (assq 'start-pos overhang-def))
						 (cdr (assq 'end-pos   overhang-def))
						 (string-json-join 
						   (cdr (assq 'fingering-notes   scale-diagram-def)))
						 (let* ((visible-notes
								 (cdr (assq 'visible-notes  scale-diagram-def)))
								(quoted-notes (map
												 (lambda (v)
													 (string-append
													  "\""
													  (pitch->name v )
													  "\"" ))
												 visible-notes))
								(comma-added-notes
								 (let loop ((es quoted-notes ))
									 (if (null? es )
										 '()
										 (cons
										  (car es)
										  (cons ", " (loop (cdr es))))))
								 )
								(chopped-notes (string-concatenate (reverse (cdr (reverse comma-added-notes ))))))
							 chopped-notes))
					`).replace( /^\s{5}/gm, '' );
				break;

			case 'queryVisibleNotesFretDiagram':
				result += ( r`
					#(define override-default ` + getSetting() + r` )
					#(define scale-diagram-def
						 (create-markup-of-scale-diagram
							#{ \absolute { ` + notes  + r` } #}
							(ly:assoc-get 'fret-positions override-default '(6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1) )
							(ly:assoc-get 'skip-count     override-default 30 )
							(ly:assoc-get 'root-offset    override-default 0 )
							override-default ))
					#(format #t "{ \"fingeringNotes\" : [ ~a ], \"visibleNotes\" : [ ~a ] }\n"
							 (string-json-join 
							   (cdr (assq 'fingering-notes   scale-diagram-def)))
							 (let* ((visible-notes
									  (cdr (assq 'visible-notes  scale-diagram-def)))
									(quoted-notes (map
													  (lambda (v)
														(string-append
														  "\""
														  (pitch->name v )
														  "\"" ))
													  visible-notes))
									(comma-added-notes
									  (let loop ((es quoted-notes ))
										(if (null? es )
										  '()
										  (cons
											(car es)
											(cons ", " (loop (cdr es))))))
									  )
									(chopped-notes (string-concatenate (reverse (cdr (reverse comma-added-notes ))))))
							   chopped-notes))
					`).replace( /^\s{5}/gm, '' );
				break;

			case 'queryFretDiagram-old':
				result += ( r`
					#(define override-default ` + getSetting() + r` )
					#(define scale-diagram-def
						(lookup-overhang-offset 
							#{ \absolute { ` + notes  + r` } #}
							(ly:assoc-get 'fret-positions override-default '(6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1) ) 
							(ly:assoc-get 'root-offset    override-default 0 ) 
							'()
							(ly:assoc-get 'display-type   override-default 'full )))
					#(format #t "~a\n" (cdr (assq 'length scale-diagram-def)))
					`).replace( /^\s{5}/gm, '' );
				break;

			case 'diagram-old':
				result += ( r`
					#(define override-default ` + getSetting() + r` )
					#(define scale-diagram-def
						(create-markup-of-scale-diagram 
							#{ \absolute { ` + notes  + r` } #}
							(ly:assoc-get 'fret-positions override-default '(6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1) ) 
							(ly:assoc-get 'skip-count     override-default 0 ) 
							(ly:assoc-get 'root-offset    override-default 0 ) 
							override-default ))
					\markup {
						#(cdr (assq 'markup scale-diagram-def))
					}
					\makescore
						\absolute {
							#(cdr (assq 'visible-music scale-diagram-def))
						}
						#` + getSetting() + `
					`).replace( /^\s{5}/gm, '' );
				break;
			case 'absolute':
				result += ( r`
					\makescore 
					  {
						` + notes + `
					  }
					  #` + getSetting() + `
					`).replace( /^\s{5}/gm, '' );
				break;
			case 'relative':
			default : 
				result += (r`
					\makescore 
					  \relative do' {
						` + notes + r`
					  }
					  #` + getSetting() + r`
					`).replace( /^\s{5}/gm, '' );
				break;
		}
		return result;
	}

	for ( var i=0; i<arr.length; i++ ) {
		var e= arr[i];
		result += createBlock( e.caption, e.comment, e.notes, e.lyrics );
	}
	return result.trim();
}


	/////////////////////////////////////////////
	//
	//
	//
	/////////////////////////////////////////////

	function applyTemplate( noteArrays, settings ) {
		if ( Array.isArray( noteArrays ) ) {
		} else {
			noteArrays = [ noteArrays ] ;
		}

		var result = [];
		for ( var i=0; i< noteArrays.length; i++ ) {
			result[i] = {
				notes : toNotes(noteArrays[i]),
			};
		}
		return template( result, settings );
	};

if ( module && module.exports ) {
	module.exports.template = template;
	module.exports.applyTemplate = applyTemplate;
} else {
	let content = '';
	process.stdin.resume();
	process.stdin.on('data', function(buf) { content += buf.toString(); });
	process.stdin.on('end', function() {
		console.error( content );
		process.stdout.write( template( new Function( content ).apply() ) );
		process.stdout.write( "\n" );
	});
}

