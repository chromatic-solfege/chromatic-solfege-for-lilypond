\version "2.18.2"
\include "chromatic-solfege-gen.ly"
\include "guitar-scale-diagram.ly"

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
