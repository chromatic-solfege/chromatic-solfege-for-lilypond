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

doublesharpdoublesharp = {
  \once \override Accidental.stencil = #ly:text-interface::print
  \once \override Accidental.text = \markup {
    \concat {
    \musicglyph #"accidentals.doublesharp"
    \hspace #0.1
    \musicglyph #"accidentals.doublesharp"
    }
  }
  \once \override Staff.AccidentalPlacement #'right-padding = #1.25
}

doubleflatdoubleflat = {
  \once \override Accidental.stencil = #ly:text-interface::print
  \once \override Accidental.text = \markup {
    \concat {
    \musicglyph #"accidentals.flatflat"
    \hspace #0.1
    \musicglyph #"accidentals.flatflat"
    }
  }
  \once \override Staff.AccidentalPlacement #'right-padding = #1.25
}


% var NOTE_TRIPLE_FLAT  = triple( [  daws   raws   maws   faws   saws   laws   taws   ] );
% var NOTE_7QTR_FLAT    = triple( [  dawm   rawm   mawm   fawm   sawm   lawm   tawm   ] );
% var NOTE_6QTR_FLAT    = triple( [  dawf   rawf   mawf   fawf   sawf   lawf   tawf   ] );
% var NOTE_5QTR_FLAT    = triple( [  dawn   rawn   mawn   fawn   sawn   lawn   tawn   ] );
% var NOTE_DOUBLE_FLAT  = triple( [  daw    raw    maw    faw    saw    law    taw    ] );
% var NOTE_3QTR_FLAT    = triple( [  dem    ram    mem    fem    sem    lem    tem    ] );
% var NOTE_FLAT         = triple( [  de     ra     me     fe     se     le     te     ] );
% var NOTE_1QTR_FLAT    = triple( [  dew    rew    mew    few    sew    lew    tew    ] );
% var NOTE_NATURAL      = triple( [  do     re     mi     fa     sol    la     ti     ] );
% var NOTE_1QTR_SHARP   = triple( [  dia    ria    mia    fia    sia    lia    tia    ] );
% var NOTE_SHARP        = triple( [  di     ri     ma     fi     si     li     ta     ] );
% var NOTE_3QTR_SHARP   = triple( [  dim    rim    mam    fim    sim    lim    tam    ] );
% var NOTE_DOUBLE_SHARP = triple( [  dai    rai    mai    fai    sai    lai    tai    ] );
% var NOTE_5QTR_SHARP   = triple( [  dain   rain   main   fain   sain   lain   tain   ] );
% var NOTE_6QTR_SHARP   = triple( [  daif   raif   maif   faif   saif   laif   taif   ] );
% var NOTE_7QTR_SHARP   = triple( [  daim   raim   maim   faim   saim   laim   taim   ] );
% var NOTE_TRIPLE_SHARP = triple( [  dais   rais   mais   fais   sais   lais   tais   ] );





#(define aaron-c `(aaron . (
                              (daws   . ,(ly:make-pitch -1 0  -8/4 ))
                              (dawm   . ,(ly:make-pitch -1 0  -7/4 ))
                              (dawf   . ,(ly:make-pitch -1 0  -6/4 ))
                              (dawn   . ,(ly:make-pitch -1 0  -5/4 ))
                              (daw    . ,(ly:make-pitch -1 0  -4/4 ))
                              (dem    . ,(ly:make-pitch -1 0  -3/4 ))
                              (de     . ,(ly:make-pitch -1 0  -2/4 ))
                              (dew    . ,(ly:make-pitch -1 0  -1/4 ))
                              (do     . ,(ly:make-pitch -1 0   0/4 ))
                              (dia    . ,(ly:make-pitch -1 0   1/4 ))
                              (di     . ,(ly:make-pitch -1 0   2/4 ))
                              (dim    . ,(ly:make-pitch -1 0   3/4 ))
                              (dai    . ,(ly:make-pitch -1 0   4/4 ))
                              (dain   . ,(ly:make-pitch -1 0   5/4 ))
                              (daif   . ,(ly:make-pitch -1 0   6/4 ))
                              (daim   . ,(ly:make-pitch -1 0   7/4 ))
                              (dais   . ,(ly:make-pitch -1 0   8/4 ))

                              (raws   . ,(ly:make-pitch -1 1  -8/4 ))
                              (rawm   . ,(ly:make-pitch -1 1  -7/4 ))
                              (rawf   . ,(ly:make-pitch -1 1  -6/4 ))
                              (rawn   . ,(ly:make-pitch -1 1  -5/4 ))
                              (raw    . ,(ly:make-pitch -1 1  -4/4 ))
                              (ram    . ,(ly:make-pitch -1 1  -3/4 ))
                              (ra     . ,(ly:make-pitch -1 1  -2/4 ))
                              (rew    . ,(ly:make-pitch -1 1  -1/4 ))
                              (re     . ,(ly:make-pitch -1 1   0/4 ))
                              (ria    . ,(ly:make-pitch -1 1   1/4 ))
                              (ri     . ,(ly:make-pitch -1 1   2/4 ))
                              (rim    . ,(ly:make-pitch -1 1   3/4 ))
                              (rai    . ,(ly:make-pitch -1 1   4/4 ))
                              (rain   . ,(ly:make-pitch -1 1   5/4 ))
                              (raif   . ,(ly:make-pitch -1 1   6/4 ))
                              (raim   . ,(ly:make-pitch -1 1   7/4 ))
                              (rais   . ,(ly:make-pitch -1 1   8/4 ))

                              (maws   . ,(ly:make-pitch -1 2  -8/4 ))
                              (mawm   . ,(ly:make-pitch -1 2  -7/4 ))
                              (mawf   . ,(ly:make-pitch -1 2  -6/4 ))
                              (mawn   . ,(ly:make-pitch -1 2  -5/4 ))
                              (maw    . ,(ly:make-pitch -1 2  -4/4 ))
                              (mem    . ,(ly:make-pitch -1 2  -3/4 ))
                              (me     . ,(ly:make-pitch -1 2  -2/4 ))
                              (mew    . ,(ly:make-pitch -1 2  -1/4 ))
                              (mi     . ,(ly:make-pitch -1 2   0/4 ))
                              (mia    . ,(ly:make-pitch -1 2   1/4 ))
                              (ma     . ,(ly:make-pitch -1 2   2/4 ))
                              (mam    . ,(ly:make-pitch -1 2   3/4 ))
                              (mai    . ,(ly:make-pitch -1 2   4/4 ))
                              (main   . ,(ly:make-pitch -1 2   5/4 ))
                              (maif   . ,(ly:make-pitch -1 2   6/4 ))
                              (maim   . ,(ly:make-pitch -1 2   7/4 ))
                              (mais   . ,(ly:make-pitch -1 2   8/4 ))

                              (faws   . ,(ly:make-pitch -1 3  -8/4 ))
                              (fawm   . ,(ly:make-pitch -1 3  -7/4 ))
                              (fawf   . ,(ly:make-pitch -1 3  -6/4 ))
                              (fawn   . ,(ly:make-pitch -1 3  -5/4 ))
                              (faw    . ,(ly:make-pitch -1 3  -4/4 ))
                              (fem    . ,(ly:make-pitch -1 3  -3/4 ))
                              (fe     . ,(ly:make-pitch -1 3  -2/4 ))
                              (few    . ,(ly:make-pitch -1 3  -1/4 ))
                              (fa     . ,(ly:make-pitch -1 3   0/4 ))
                              (fia    . ,(ly:make-pitch -1 3   1/4 ))
                              (fi     . ,(ly:make-pitch -1 3   2/4 ))
                              (fim    . ,(ly:make-pitch -1 3   3/4 ))
                              (fai    . ,(ly:make-pitch -1 3   4/4 ))
                              (fain   . ,(ly:make-pitch -1 3   5/4 ))
                              (faif   . ,(ly:make-pitch -1 3   6/4 ))
                              (faim   . ,(ly:make-pitch -1 3   7/4 ))
                              (fais   . ,(ly:make-pitch -1 3   8/4 ))

                              (saws   . ,(ly:make-pitch -1 4  -8/4 ))
                              (sawm   . ,(ly:make-pitch -1 4  -7/4 ))
                              (sawf   . ,(ly:make-pitch -1 4  -6/4 ))
                              (sawn   . ,(ly:make-pitch -1 4  -5/4 ))
                              (saw    . ,(ly:make-pitch -1 4  -4/4 ))
                              (sem    . ,(ly:make-pitch -1 4  -3/4 ))
                              (se     . ,(ly:make-pitch -1 4  -2/4 ))
                              (sew    . ,(ly:make-pitch -1 4  -1/4 ))
                              (sol    . ,(ly:make-pitch -1 4   0/4 ))
                              (sia    . ,(ly:make-pitch -1 4   1/4 ))
                              (si     . ,(ly:make-pitch -1 4   2/4 ))
                              (sim    . ,(ly:make-pitch -1 4   3/4 ))
                              (sai    . ,(ly:make-pitch -1 4   4/4 ))
                              (sain   . ,(ly:make-pitch -1 4   5/4 ))
                              (saif   . ,(ly:make-pitch -1 4   6/4 ))
                              (saim   . ,(ly:make-pitch -1 4   7/4 ))
                              (sais   . ,(ly:make-pitch -1 4   8/4 ))

                              (laws   . ,(ly:make-pitch -1 5  -8/4 ))
                              (lawm   . ,(ly:make-pitch -1 5  -7/4 ))
                              (lawf   . ,(ly:make-pitch -1 5  -6/4 ))
                              (lawn   . ,(ly:make-pitch -1 5  -5/4 ))
                              (law    . ,(ly:make-pitch -1 5  -4/4 ))
                              (lem    . ,(ly:make-pitch -1 5  -3/4 ))
                              (le     . ,(ly:make-pitch -1 5  -2/4 ))
                              (lew    . ,(ly:make-pitch -1 5  -1/4 ))
                              (la     . ,(ly:make-pitch -1 5   0/4 ))
                              (lia    . ,(ly:make-pitch -1 5   1/4 ))
                              (li     . ,(ly:make-pitch -1 5   2/4 ))
                              (lim    . ,(ly:make-pitch -1 5   3/4 ))
                              (lai    . ,(ly:make-pitch -1 5   4/4 ))
                              (lain   . ,(ly:make-pitch -1 5   5/4 ))
                              (laif   . ,(ly:make-pitch -1 5   6/4 ))
                              (laim   . ,(ly:make-pitch -1 5   7/4 ))
                              (lais   . ,(ly:make-pitch -1 5   8/4 ))

                              (taws   . ,(ly:make-pitch -1 6  -8/4 ))
                              (tawm   . ,(ly:make-pitch -1 6  -7/4 ))
                              (tawf   . ,(ly:make-pitch -1 6  -6/4 ))
                              (tawn   . ,(ly:make-pitch -1 6  -5/4 ))
                              (taw    . ,(ly:make-pitch -1 6  -4/4 ))
                              (tem    . ,(ly:make-pitch -1 6  -3/4 ))
                              (te     . ,(ly:make-pitch -1 6  -2/4 ))
                              (tew    . ,(ly:make-pitch -1 6  -1/4 ))
                              (ti     . ,(ly:make-pitch -1 6   0/4 ))
                              (tia    . ,(ly:make-pitch -1 6   1/4 ))
                              (ta     . ,(ly:make-pitch -1 6   2/4 ))
                              (tam    . ,(ly:make-pitch -1 6   3/4 ))
                              (tai    . ,(ly:make-pitch -1 6   4/4 ))
                              (tain   . ,(ly:make-pitch -1 6   5/4 ))
                              (taif   . ,(ly:make-pitch -1 6   6/4 ))
                              (taim   . ,(ly:make-pitch -1 6   7/4 ))
                              (tais   . ,(ly:make-pitch -1 6   8/4 ))



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
