\version "2.18.2"


#(define-public aaron-alteration-glyph-name-alist
  '(
    ;; ordered for optimal performance.
    (0 . "accidentals.natural")
    (-1/2 . "accidentals.flat")
    (1/2 . "accidentals.sharp")

    (1 . "accidentals.doublesharp")
    (3/2 . "accidentals.doublesharp")
    (-3/2 . "accidentals.flatflat")
    (-1 . "accidentals.flatflat")

    (3/4 . "accidentals.sharp.slashslash.stemstemstem")
    (1/4 . "accidentals.sharp.slashslash.stem")
    (-1/4 . "accidentals.mirroredflat")
    (-3/4 . "accidentals.mirroredflat.flat")))


\layout {
  \override Staff.Accidental.glyph-name-alist = #aaron-alteration-glyph-name-alist
}

#(define-public TRIPLE-FLAT -3/2)
#(define-public TRIPLE-SHARP 3/2)


sharpdoublesharp = {
  \once \override Accidental.stencil = #ly:text-interface::print
  \once \override Accidental.text = \markup {
    \concat {
    \musicglyph #"accidentals.sharp"
    \hspace #0.1
    \musicglyph #"accidentals.doublesharp"
    }
  }
  \once \override Staff.AccidentalPlacement #'right-padding = #1.25
}

flatdoubleflat = {
  \once \override Accidental.stencil = #ly:text-interface::print
  \once \override Accidental.text = \markup {
    \concat {
    \musicglyph #"accidentals.flat"
    \hspace #0.1
    \musicglyph #"accidentals.flatflat"
    }
  }
  \once \override Staff.AccidentalPlacement #'right-padding = #1.25
}


#(define aaron-c `(aaron . (
                 (dew . ,(ly:make-pitch -1 0 TRIPLE-FLAT))
                 (daw . ,(ly:make-pitch -1 0 DOUBLE-FLAT))
                 (de . ,(ly:make-pitch -1 0 FLAT))
                 (do . ,(ly:make-pitch -1 0 NATURAL))
                 (di . ,(ly:make-pitch -1 0 SHARP))
                 (dai . ,(ly:make-pitch -1 0 DOUBLE-SHARP))
                 (dier . ,(ly:make-pitch -1 0 TRIPLE-SHARP))

                 (rew . ,(ly:make-pitch -1 1 TRIPLE-FLAT))
                 (raw . ,(ly:make-pitch -1 1 DOUBLE-FLAT))
                 (ra . ,(ly:make-pitch -1 1 FLAT))
                 (re . ,(ly:make-pitch -1 1 NATURAL))
                 (ri . ,(ly:make-pitch -1 1 SHARP))
                 (rai . ,(ly:make-pitch -1 1 DOUBLE-SHARP))
                 (rier . ,(ly:make-pitch -1 1 TRIPLE-SHARP))

                 (mew . ,(ly:make-pitch -1 2 TRIPLE-FLAT))
                 (maw . ,(ly:make-pitch -1 2 DOUBLE-FLAT))
                 (me . ,(ly:make-pitch -1 2 FLAT))
                 (mi . ,(ly:make-pitch -1 2 NATURAL))
                 (ma . ,(ly:make-pitch -1 2 SHARP))
                 (mai . ,(ly:make-pitch -1 2 DOUBLE-SHARP))
                 (mier . ,(ly:make-pitch -1 2 TRIPLE-SHARP))

                 (few . ,(ly:make-pitch -1 3 TRIPLE-FLAT))
                 (faw . ,(ly:make-pitch -1 3 DOUBLE-FLAT))
                 (fe . ,(ly:make-pitch -1 3 FLAT))
                 (fa . ,(ly:make-pitch -1 3 NATURAL))
                 (fi . ,(ly:make-pitch -1 3 SHARP))
                 (fai . ,(ly:make-pitch -1 3 DOUBLE-SHARP))
                 (fier . ,(ly:make-pitch -1 3 TRIPLE-SHARP))

                 (sew . ,(ly:make-pitch -1 4 TRIPLE-FLAT))
                 (saw . ,(ly:make-pitch -1 4 DOUBLE-FLAT))
                 (se . ,(ly:make-pitch -1 4 FLAT))
                 (sol . ,(ly:make-pitch -1 4 NATURAL))
                 (si . ,(ly:make-pitch -1 4 SHARP))
                 (sai . ,(ly:make-pitch -1 4 DOUBLE-SHARP))
                 (sier . ,(ly:make-pitch -1 4 TRIPLE-SHARP))

                 (lew . ,(ly:make-pitch -1 5 TRIPLE-FLAT))
                 (law . ,(ly:make-pitch -1 5 DOUBLE-FLAT))
                 (le . ,(ly:make-pitch -1 5 FLAT))
                 (la . ,(ly:make-pitch -1 5 NATURAL))
                 (li . ,(ly:make-pitch -1 5 SHARP))
                 (lai . ,(ly:make-pitch -1 5 DOUBLE-SHARP))
                 (lier . ,(ly:make-pitch -1 5 TRIPLE-SHARP))

                 (tew . ,(ly:make-pitch -1 6 TRIPLE-FLAT))
                 (taw . ,(ly:make-pitch -1 6 DOUBLE-FLAT))
                 (te . ,(ly:make-pitch -1 6 FLAT))
                 (ti . ,(ly:make-pitch -1 6 NATURAL))
                 (ta . ,(ly:make-pitch -1 6 SHARP))
                 (tai . ,(ly:make-pitch -1 6 DOUBLE-SHARP))                 
                 (tier . ,(ly:make-pitch -1 6 TRIPLE-SHARP))                 

                 (だう . ,(ly:make-pitch -1 0 DOUBLE-FLAT))
                 (で . ,(ly:make-pitch -1 0 FLAT))
                 (ど . ,(ly:make-pitch -1 0 NATURAL))
                 (ぢ . ,(ly:make-pitch -1 0 SHARP))
                 (だい . ,(ly:make-pitch -1 0 DOUBLE-SHARP))

                 (はう . ,(ly:make-pitch -1 1 DOUBLE-FLAT))
                 (は . ,(ly:make-pitch -1 1 FLAT))
                 (へ . ,(ly:make-pitch -1 1 NATURAL))
                 (ひ . ,(ly:make-pitch -1 1 SHARP))
                 (はい . ,(ly:make-pitch -1 1 DOUBLE-SHARP))

                 (まう . ,(ly:make-pitch -1 2 DOUBLE-FLAT))
                 (め . ,(ly:make-pitch -1 2 FLAT))
                 (み . ,(ly:make-pitch -1 2 NATURAL))
                 (ま . ,(ly:make-pitch -1 2 SHARP))
                 (まい . ,(ly:make-pitch -1 2 DOUBLE-SHARP))

                 (ふぁう . ,(ly:make-pitch -1 3 DOUBLE-FLAT))
                 (ふぇ . ,(ly:make-pitch -1 3 FLAT))
                 (ふぁ . ,(ly:make-pitch -1 3 NATURAL))
                 (ふぃ . ,(ly:make-pitch -1 3 SHARP))
                 (ふぁい . ,(ly:make-pitch -1 3 DOUBLE-SHARP))

                 (さう . ,(ly:make-pitch -1 4 DOUBLE-FLAT))
                 (せ . ,(ly:make-pitch -1 4 FLAT))
                 (そ . ,(ly:make-pitch -1 4 NATURAL))
                 (し . ,(ly:make-pitch -1 4 SHARP))
                 (さい . ,(ly:make-pitch -1 4 DOUBLE-SHARP))

                 (らお . ,(ly:make-pitch -1 5 DOUBLE-FLAT))
                 (れ . ,(ly:make-pitch -1 5 FLAT))
                 (ら . ,(ly:make-pitch -1 5 NATURAL))
                 (り . ,(ly:make-pitch -1 5 SHARP))
                 (らい . ,(ly:make-pitch -1 5 DOUBLE-SHARP))

                 (たう . ,(ly:make-pitch -1 6 DOUBLE-FLAT))
                 (て . ,(ly:make-pitch -1 6 FLAT))
                 (ち . ,(ly:make-pitch -1 6 NATURAL))
                 (た . ,(ly:make-pitch -1 6 SHARP))
                 (たい . ,(ly:make-pitch -1 6 DOUBLE-SHARP))
                 ))
   )

#(define (add! mylist myelem)
  (if (null? mylist)
      #f
      (if (null? (cdr mylist))
          (set-cdr! mylist (cons myelem '()))
          (add! (cdr mylist) myelem ))))

#(add! language-pitch-names aaron-c)
\language "aaron"
