\version "2.18.2"
\include "chromatic-solfege.ly"
\include "lilypond-book-preamble.ly"
\language "chromatic-solfege"

\score {
  \relative do' {
    \clef treble
    \time 4/4
    \key do \major
    do 4 di re ri
    mi fa fi sol
    si la li ti
    do 2 r2
  }
}
