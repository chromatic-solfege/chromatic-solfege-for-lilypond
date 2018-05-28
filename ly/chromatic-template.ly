\version "2.18.2"
\include "lilypond-book-preamble.ly"
\include "guitar-scale-diagram.ly"
\include "aaron.ly"

\layout {
    \context {
        \Score
        \override TextSpanner.style = #'line
        \override TextSpanner.thickness = #5
        \override TextSpanner.bound-details.right.padding = #-1
        \override TextSpanner.bound-details.left.padding = #0
        \override TextSpanner.color = #red
      }
}

textSpanColorA = {
  \once \override TextSpanner.style = #'line
  \once \override TextSpanner.thickness = #5
  \once \override TextSpanner.bound-details.right.padding = #-1
  \once \override TextSpanner.bound-details.left.padding = #0
  \once \override TextSpanner.color = #red
}
textSpanColorB = {
  \once \override TextSpanner.style = #'trill
  \once \override TextSpanner.thickness = #5
  \once \override TextSpanner.bound-details.right.padding = #-1
  \once \override TextSpanner.bound-details.left.padding = #0
  \once \override TextSpanner.color = #red
}
textSpanColorC = {
  \once \override TextSpanner.style = #'zigzag
  \once \override TextSpanner.thickness = #4
  \once \override TextSpanner.bound-details.right.padding = #-1
  \once \override TextSpanner.bound-details.left.padding = #0
  \once \override TextSpanner.color = #red
}
uin = \startTextSpan
uout = \stopTextSpan

#(define 
   process-mark-irregular-accidentals
   (lambda (music) 
     (letrec ((proc-e (lambda ( music-e back-music )
                        ;(display-scheme-music music-e)
                        (or
                          (if (eq? (ly:music-property music-e 'name) 'NoteEvent )
                            ;then
                            (let* ((pitch    (ly:music-property music-e 'pitch ) )
                                   (notename (ly:pitch-notename pitch ) )
                                   (alt      (ly:pitch-alteration pitch )))
                              (if (or 
                                    (<= 1 (abs alt))
                                    (and (= -0.5 alt) 
                                         (= 0  notename ))
                                    (and (= -0.5 alt) 
                                         (= 3  notename ))
                                    (and (= 0.5  alt) 
                                         (= 6  notename ))
                                    (and (= 0.5 alt) 
                                         (= 2  notename )))
                                ;then
                                (begin
                                  ; (display-scheme-music pitch)
                                  (ly:music-set-property! music-e 'articulations (list #{ \uout #}) )
                                  (let ((found (find-tail (lambda(v)
                                                            (eq? 
                                                              (ly:music-property v 'name)
                                                              'NoteEvent ))
                                                          back-music)))
                                    (if found
                                      (begin 
                                        (ly:music-set-property! 
                                          (car found )
                                          'articulations 
                                          (list #{ \uin #}))

                                        (let ((new-element
                                                (let ((alt (abs alt)))
                                                  (cond
                                                    ((< alt  1) #{ \textSpanColorA #} )
                                                    ((= 1 alt ) #{ \textSpanColorB #} )
                                                    (else       #{ \textSpanColorC #} ))))
                                              (next (cdr found)))
                                          ;(display-scheme-music next)

                                          ; Create new cell and add it to the end of the list
                                          (if (null? next )
                                            ;then
                                            (begin 
                                              (set! next  (cons new-element '() ))
                                              (set-cdr! found next))
                                            ;else
                                            (begin
                                              ; clone the cons cell and set it as cdr
                                              (set-cdr!
                                                next
                                                (cons
                                                  (car next)
                                                  (cdr next)))

                                              ; set-car! the new element on the cons cell.
                                              (set-car!  next new-element )))))))
                                  ;
                                  (list music-e))
                                ;else
                                (list music-e )))
                            ;else
                            #f)
                          (let ((e (ly:music-property music-e 'element  )))
                            (if (null? e) #f (begin (proc-e e '() ) #t )))
                          (let ((e (ly:music-property  music-e 'elements)))
                            (if (null? e) #f (let ((proc-l-result (proc-l e)))
                                               ; (write '**********************************)
                                               ; (newline)
                                               ; (display-scheme-music proc-l-result)
                                               ; (write '**********************************)
                                               ; (newline)
                                               (ly:music-set-property! music-e 'elements proc-l-result )
                                               #t ))))))

              (proc-l (lambda(music-l) 
                        (let loop ((in-music music-l)(back-music '()))
                          (let ((next-music           (cdr in-music))
                                (result-music (proc-e (car in-music) back-music )))

                            ; (write '******************** )
                            ; (newline) 
                            ; (display-scheme-music result-music)
                            (if (list? result-music)
                              (begin (set! back-music (append (reverse result-music) back-music ))
                                     ; (write '***************' )
                                     ; (newline)
                                     ; (display-scheme-music back-music )
                                     )
                              (begin (set! back-music (append (list (car in-music)) back-music ))))
                            (if (null? next-music) 
                              (reverse back-music)
                              (loop next-music back-music)))
                          ))))

       (proc-e music '()))
     ;return
     ; (display-scheme-music music)
	 music
	 
	 ))

mark-irregular-accidentals = 
#(define-scheme-function (parser location music) (ly:music?)
                         (process-mark-irregular-accidentals music))





\layout {
      indent = #0
      ragged-right = ##f
      \context {
        \Score
        \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/2)
      }
}
\paper  {
    #(set! paper-alist (cons '("a4inside" . (cons (* 8 in) (* 3 in))) paper-alist))
    #(set-paper-size "a4inside")
    #(define fonts
     (make-pango-font-tree "Times New Roman"
                           "Nimbus Sans"
                           "Luxi Mono"
                           (/ staff-height pt 20)))
}

% >>> Added (Fri, 30 Mar 2018 15:29:33 +0900)
  #(use-modules (ice-9 popen))
  #(use-modules (ice-9 readline))
  #(use-modules (ice-9 rdelim))
  #(use-modules (ice-9 regex))
  #(define (ch:transpose str )
      (let* (
               (port (open-input-pipe
                        (string-append
                                       "solfege "
                                       "\""
                                       str
                                       "\""
                        )
                     )
               )
               (str  (read-line port))
            )
          (close-pipe port)
          str
      ))
% <<< Added (Fri, 30 Mar 2018 15:29:33 +0900)

%#(warn (regexp-substitute/global #f "\\|" "abcde|abcde" 'pre "\\\\|" 'post ))
%#(warn (ch:transpose "se do re mi | do re mi | < do mi sol >" ))
%asc=#(ch:transpose "se do re mi \\| do ti la" )
%#(warn asc)

makescore = #(define-scheme-function (parser location notes settings ) ( ly:music? list? )
   (define source-filename (car (ly:input-both-locations location) ) )
   ; (write 'makescore )
   ; (newline)
   ; (write source-filename )
   ; (newline)
   ; (write 'setting )
   ; (newline)
   ; (write score-settings )

   (let ((v (assq 'mark-irregular-accidentals settings )))
    (if (and v (cdr v))
     (set! notes (process-mark-irregular-accidentals notes))))

     #{
    \score {
      <<


        \music-to-festival #notes #(string-append source-filename ".xml" ) #settings
        \new Staff \relative do' {
          \clef "G"
          %\time 16/4
          \omit Score.TimeSignature
          \omit Score.BarNumber
          % \omit Score.BarLine
          \stemUp
          \new Voice = "myRhythm" {
              \accidentalStyle neo-modern
              %\override Beam.breakable = ##t
              %\set Timing.beatStructure  = #'( 1 1 1 1 1 1 1 1 1 1 1 1 1 1  )
              %\hide Stem
              \textSpannerDown
              \cadenzaOn
              \process-triple-accidentals #notes
          }
        }
        \new Lyrics {
          \lyricsto "myRhythm" {
            \override Lyrics.LyricText.font-shape = #'italic
            \override Lyrics.LyricText.font-series = #'bold
            \music-to-aaron #notes
          }
        }

      >>
      \midi { \tempo 4 = 180 }
	  \layout {
		\context {
		  \Score
		  \override NonMusicalPaperColumn.line-break-permission = ##f
		  \override NonMusicalPaperColumn.page-break-permission = ##f
		}
	  }
    }
  #}
)


% (Mon, 23 Apr 2018 21:30:23 +0900)
% function makescore-for-guitar
% Moved from "chromatic-solfage-for-guitar.ly" . This is implementation is not
% completed yet.
makescore-for-guitar =
#(define-scheme-function (parser location noteValues noteNames fingeringPattern ) (ly:music? ly:music? list?)
     (put-fretdiagram-on-music! noteValues
         (create-fretdiagram-definition
             (put-string-number-on-music! noteValues fingeringPattern)))
     #{ 
       
         \score {
             <<
                 \new Staff \relative do' {
                     \clef "G_8" 
                     %\time 16/4
                     \omit Score.TimeSignature
                     \omit Score.BarNumber
                     % \omit Score.BarLine
                     \stemUp
                     \new Voice = "myRhythm" {
                         \accidentalStyle neo-modern
                         %\override Beam.breakable = ##t
                         %\set Timing.beatStructure  = #'( 1 1 1 1 1 1 1 1 1 1 1 1 1 1  )
                         %\hide Stem
                         \textSpannerDown        
                         \cadenzaOn
                         #noteValues
                     }
                 }
                 \new Lyrics {
                     \lyricsto "myRhythm" {
                         \override Lyrics.LyricText.font-shape = #'italic
                         \override Lyrics.LyricText.font-series = #'bold
                         #noteNames
                     }
                 }
                 \new TabStaff {
                     #noteValues
                 }
             >>
         \layout {
             \context {
                 \Score {
                     \override TextScript.fret-diagram-details.finger-code = #'in-dot
                     \override TextScript.fret-diagram-details.dot-color   = #'white
                     \override TextScript.fret-diagram-details.number-type = #'arabic
                     \override TextScript.fret-diagram-details.orientation = #'landscape
                     \omit Voice.StringNumber
                     \set TabStaff.minimumFret = #6
                     \set TabStaff.restrainOpenStrings = ##t
                 }
             }
         }
             
         }
     #}
     )

