\version "2.18.2"

#(define aaron-c `(aaron . (
                 (daw . ,(ly:make-pitch -1 0 DOUBLE-FLAT))
                 (de . ,(ly:make-pitch -1 0 FLAT))
                 (do . ,(ly:make-pitch -1 0 NATURAL))
                 (di . ,(ly:make-pitch -1 0 SHARP))
                 (dai . ,(ly:make-pitch -1 0 DOUBLE-SHARP))

                 (raw . ,(ly:make-pitch -1 1 DOUBLE-FLAT))
                 (ra . ,(ly:make-pitch -1 1 FLAT))
                 (re . ,(ly:make-pitch -1 1 NATURAL))
                 (ri . ,(ly:make-pitch -1 1 SHARP))
                 (rai . ,(ly:make-pitch -1 1 DOUBLE-SHARP))

                 (maw . ,(ly:make-pitch -1 2 DOUBLE-FLAT))
                 (me . ,(ly:make-pitch -1 2 FLAT))
                 (mi . ,(ly:make-pitch -1 2 NATURAL))
                 (ma . ,(ly:make-pitch -1 2 SHARP))
                 (mai . ,(ly:make-pitch -1 2 DOUBLE-SHARP))

                 (faw . ,(ly:make-pitch -1 3 DOUBLE-FLAT))
                 (fe . ,(ly:make-pitch -1 3 FLAT))
                 (fa . ,(ly:make-pitch -1 3 NATURAL))
                 (fi . ,(ly:make-pitch -1 3 SHARP))
                 (fai . ,(ly:make-pitch -1 3 DOUBLE-SHARP))

                 (saw . ,(ly:make-pitch -1 4 DOUBLE-FLAT))
                 (se . ,(ly:make-pitch -1 4 FLAT))
                 (sol . ,(ly:make-pitch -1 4 NATURAL))
                 (si . ,(ly:make-pitch -1 4 SHARP))
                 (sai . ,(ly:make-pitch -1 4 DOUBLE-SHARP))

                 (law . ,(ly:make-pitch -1 5 DOUBLE-FLAT))
                 (le . ,(ly:make-pitch -1 5 FLAT))
                 (la . ,(ly:make-pitch -1 5 NATURAL))
                 (li . ,(ly:make-pitch -1 5 SHARP))
                 (lai . ,(ly:make-pitch -1 5 DOUBLE-SHARP))

                 (taw . ,(ly:make-pitch -1 6 DOUBLE-FLAT))
                 (te . ,(ly:make-pitch -1 6 FLAT))
                 (ti . ,(ly:make-pitch -1 6 NATURAL))
                 (ta . ,(ly:make-pitch -1 6 SHARP))
                 (tai . ,(ly:make-pitch -1 6 DOUBLE-SHARP))                 

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
