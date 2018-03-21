\version "2.18.2"
\include "lilypond-book-preamble.ly"
\include "aaron.ly"

\layout {
    \context {
        \Score
        \override TextSpanner.style = #'line
        \override TextSpanner.thickness = #4
        \override TextSpanner.bound-details.right.padding = #-1
        \override TextSpanner.bound-details.left.padding = #0
        \override TextSpanner.color = #red
      }
}
stau = \startTextSpan
stou = \stopTextSpan
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

makescore = #(define-scheme-function (parser location noteValues noteNames) (ly:music? ly:music? )
  #{ 
    \score {
      <<
        \new Staff \relative do' {
          \clef "G" 
          %\time 16/4
          \omit Score.TimeSignature
          \omit Score.BarNumber
          \omit Score.BarLine
          \stemUp
          \new Voice = "myRhythm" {
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
      >>
    }
  #}
)
