\version "2.18.2"

#(define-public aaron-alteration-glyph-name-alist
  '(
    ;; ordered for optimal performance.
    (0 . "accidentals.natural")
    (-1/2 . "accidentals.flat")
    (1/2 . "accidentals.sharp")

    (1 . "accidentals.doublesharp")
    (3/2 . "accidentals.doublesharp")
    (4/2 . "accidentals.doublesharp")
    (-4/2 . "accidentals.flatflat")
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
  \once \override Staff.AccidentalPlacement #'right-padding = #1.5
}


% var NOTE_TRIPLE_FLAT  = triple( [  dae    rae    mae    fae    sae    lae    tae    ] );
% var NOTE_7QTR_FLAT    = triple( [  daem   raem   maem   faem   saem   laem   taem   ] );
% var NOTE_8QTR_FLAT    = triple( [  daes   raes   maes   faes   saes   laes   taes   ] );
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
% var NOTE_8QTR_SHARP   = triple( [  daos   raos   maos   faos   saos   laos   taos   ] );
% var NOTE_7QTR_SHARP   = triple( [  daom   raom   maom   faom   saom   laom   taom   ] );
% var NOTE_TRIPLE_SHARP = triple( [  dao    rao    mao    fao    sao    lao    tao    ] );

process-triple-accidentals = 
#(define-scheme-function (parser location music) (ly:music?)
                         (letrec ((proc-e (lambda(music-e)
                                            ; (display-scheme-music music-e)

                                            (or
                                              ; ``or''
                                              ; If the return value is :
                                              ;               #t         then 'break'
                                              ;               #f         then 'continue'
                                              ;               (list xxx) then 'break' and replace the 
                                              ;                                current element with the 
                                              ;                                returned value
                                              ; ... that's it.

                                              (if (eq? (ly:music-property music-e 'name) 'NoteEvent ) 
                                                (let* ((pitch-e (ly:music-property music-e 'pitch))
                                                       (pitch-alteration (ly:pitch-alteration pitch-e )))

                                                  (cond
                                                    ((< pitch-alteration -3/2 )
                                                     (list
                                                       #{ \doubleflatdoubleflat #}
                                                       music-e))
                                                    ((< pitch-alteration -1 )
                                                     (list
                                                       #{ \flatdoubleflat #}
                                                       music-e))
                                                    ((< 3/2  pitch-alteration  )
                                                     (list
                                                       #{ \doublesharpdoublesharp #}
                                                       music-e))
                                                    ((< 1  pitch-alteration  )
                                                     (list
                                                       #{ \sharpdoublesharp #}
                                                       music-e))
                                                    (else #t)))
                                                #f)
                                              (let ((e (ly:music-property music-e 'element  )))
                                                (if (null? e) #f (begin (proc-e e) #t )))
                                              (let ((e (ly:music-property  music-e 'elements)))
                                                (if (null? e) #f (begin (proc-l e) #t ))))
                                            ))
                                  (proc-l (lambda(music-l) 
                                            (let loop ((in-music music-l))
                                              (let ((next-music           (cdr in-music))
                                                    (result-music (proc-e (car in-music))))

                                                (if (list? result-music)
                                                  (let ((new-list (append result-music next-music )))
                                                    (set-car! in-music (car new-list))
                                                    (set-cdr! in-music (cdr new-list))
                                                    )
                                                  #f)
                                                (or (null? next-music) 
                                                    (loop next-music)))
                                              )
                                            #t)
                                          ))
                           (proc-e music))
                         music) 

process-marking-irregular-accidentals-bak = 
#(define-scheme-function (parser location music) (ly:music?)
                         (letrec ((proc-e (lambda(music-e back-music )
                                            ;(display-scheme-music music-e)
                                            (or
                                              (if (eq? (ly:music-property music-e 'name) 'NoteEvent )
                                                (let ((pitch (ly:music-property music-e 'pitch ) ))
                                                  (if (<= 1 (abs (ly:pitch-alteration pitch )))
                                                    (begin
                                                      ; (display-scheme-music pitch)
                                                      (ly:music-set-property! music-e 'articulations (list #{ \uout #}) )
                                                      (let ((found (find (lambda(v)
                                                                           (eq? 
                                                                             (ly:music-property (car v) 'name)
                                                                             'NoteEvent ))
                                                                         back-music)))
                                                        (if (not (null? found))
                                                          (begin
                                                            (ly:music-set-property! 
                                                              (car found )
                                                              'articulations 
                                                              (list #{ \uin #})))))))

                                                  #t);break;
                                                #f);continue;
                                              (let ((e (ly:music-property music-e 'element  )))
                                                (if (null? e) #f (begin (proc-e e '() ) #t )))
                                              (let ((e (ly:music-property  music-e 'elements)))
                                                (if (null? e) #f (begin (proc-l e) #t ))))))

                                  (proc-l (lambda(music-l) 
                                            (let loop ((in-music music-l)(back-music '()))
                                              (let ((next-music           (cdr in-music))
                                                    (result-music (proc-e (car in-music) back-music )))

                                                (if (list? result-music)
                                                  (let ((new-list (append result-music next-music )))
                                                    (set-car! in-music (car new-list))
                                                    (set-cdr! in-music (cdr new-list))
                                                    )
                                                  #f)
                                                (or (null? next-music) 
                                                    (loop next-music (cons in-music back-music)))))
                                            #t)))

                           (proc-e music '()))
                         music)




#(define aaron-c `(aaron . (
                              (daes   . ,(ly:make-pitch -1 0  -8/4 ))
                              (daem   . ,(ly:make-pitch -1 0  -7/4 ))
                              (dae    . ,(ly:make-pitch -1 0  -6/4 ))
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
                              (dao    . ,(ly:make-pitch -1 0   6/4 ))
                              (daom   . ,(ly:make-pitch -1 0   7/4 ))
                              (daos   . ,(ly:make-pitch -1 0   8/4 ))

                              (raes   . ,(ly:make-pitch -1 1  -8/4 ))
                              (raem   . ,(ly:make-pitch -1 1  -7/4 ))
                              (rae    . ,(ly:make-pitch -1 1  -6/4 ))
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
                              (rao    . ,(ly:make-pitch -1 1   6/4 ))
                              (raom   . ,(ly:make-pitch -1 1   7/4 ))
                              (raos   . ,(ly:make-pitch -1 1   8/4 ))

                              (maes   . ,(ly:make-pitch -1 2  -8/4 ))
                              (maem   . ,(ly:make-pitch -1 2  -7/4 ))
                              (mae    . ,(ly:make-pitch -1 2  -6/4 ))
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
                              (mao    . ,(ly:make-pitch -1 2   6/4 ))
                              (maom   . ,(ly:make-pitch -1 2   7/4 ))
                              (maos   . ,(ly:make-pitch -1 2   8/4 ))

                              (faes   . ,(ly:make-pitch -1 3  -8/4 ))
                              (faem   . ,(ly:make-pitch -1 3  -7/4 ))
                              (fae    . ,(ly:make-pitch -1 3  -6/4 ))
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
                              (fao    . ,(ly:make-pitch -1 3   6/4 ))
                              (faom   . ,(ly:make-pitch -1 3   7/4 ))
                              (faos   . ,(ly:make-pitch -1 3   8/4 ))

                              (saes   . ,(ly:make-pitch -1 4  -8/4 ))
                              (saem   . ,(ly:make-pitch -1 4  -7/4 ))
                              (sae    . ,(ly:make-pitch -1 4  -6/4 ))
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
                              (sao    . ,(ly:make-pitch -1 4   6/4 ))
                              (saom   . ,(ly:make-pitch -1 4   7/4 ))
                              (saos   . ,(ly:make-pitch -1 4   8/4 ))

                              (laes   . ,(ly:make-pitch -1 5  -8/4 ))
                              (laem   . ,(ly:make-pitch -1 5  -7/4 ))
                              (lae    . ,(ly:make-pitch -1 5  -6/4 ))
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
                              (lao    . ,(ly:make-pitch -1 5   6/4 ))
                              (laom   . ,(ly:make-pitch -1 5   7/4 ))
                              (laos   . ,(ly:make-pitch -1 5   8/4 ))

                              (taes   . ,(ly:make-pitch -1 6  -8/4 ))
                              (taem   . ,(ly:make-pitch -1 6  -7/4 ))
                              (tae    . ,(ly:make-pitch -1 6  -6/4 ))
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
                              (tao    . ,(ly:make-pitch -1 6   6/4 ))
                              (taom   . ,(ly:make-pitch -1 6   7/4 ))
                              (taos   . ,(ly:make-pitch -1 6   8/4 ))



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

#(define pitch-equal?
     (lambda (p1 p2)
         ;(write (ly:pitch-alteration p1))(newline)
         ;(write (ly:pitch-alteration p2))(newline)
         ;(write (ly:pitch-notename p1))(newline)
         ;(write (ly:pitch-notename p2))(newline)
         ;(write (equal? (ly:pitch-alteration p1)(ly:pitch-alteration p2)))(newline)
         ;(write (equal? (ly:pitch-notename p1)(ly:pitch-notename p2)))(newline)
         (and
          (equal? (ly:pitch-alteration p1)(ly:pitch-alteration p2))
          (equal? (ly:pitch-notename p1)(ly:pitch-notename p2)))
         ))

#(define pitch-equal-by-num?
     (lambda (p pitch-algeration pitch-notename)
         (and
          (equal? (ly:pitch-alteration p) pitch-alteration )
          (equal? (ly:pitch-notename   p) pitch-notename   )
          )))

#(define lookup-aaron-by-pitch
    (lambda (p)
        (define lookup
            (lambda ( es p )
                ;(write (length es))
                ;(newline)
                (if (null? es)
                    ""
                    (let* ((p2 (cdr (car es))))
                        (if (pitch-equal? p p2 )
                            (symbol->string (car (car es)))
                            (lookup (cdr es) p ))))))

        (lookup (cdr aaron-c ) p )))



#(define lookup-aaron-by-num
    (lambda ( pitch-algeration pitch-notename )
        (define lookup
            (lambda ( es )
                ;(write (length es))
                ;(newline)
                (if (null? es)
                    ""
                    (let* ((p2 (cdr (car es))))
                        (if (pitch-equal-by-num? p2 pitch-algeration pitch-notename )
                            (symbol->string (car (car es)))
                            (lookup (cdr es) ))))))

        (lookup (cdr aaron-c ) )))


#(define note-to-pitch
     (lambda (lang-name note-name octave-offset)
         (let* ((lang (assoc-get lang-name language-pitch-names ) )
                (note (assoc-get note-name lang )))
             (ly:make-pitch
              (+ (ly:pitch-octave note) octave-offset )
              (ly:pitch-notename note )
              (ly:pitch-alteration note )))))

#(define /times 
   (lambda (times proc)
     (if (not (procedure? proc))
       (set! proc 
         ((lambda (value) 
            (lambda() value ))
          proc)))
     (let loop-of-/times ((times times))
       (if (< 0 times )
         (cons 
           (proc)
           (loop-of-/times (- times 1)))
         '()))))

#(define name->pitch
   (lambda (note-name octave-offset)
     ; pitchnames = global variable from scm/define-note-names.scm
     (if (string? note-name)(set! note-name (string->symbol note-name )))
     (let* ((note (cdr (or (assoc note-name pitchnames )(error "Invalid Note Name" note-name )))))
       (ly:make-pitch
         (+ (ly:pitch-octave note) octave-offset )
         (ly:pitch-notename note )
         (ly:pitch-alteration note )))))

#(define add-octave-specifier-to-pitchname
   (lambda( pitchname octave ) 
     (cond 
       ((< 0 octave) (string-append pitchname (string-concatenate (/times      octave  "'" ))))
       ((> 0 octave) (string-append pitchname (string-concatenate (/times (abs octave) "," ))))
       (else pitchname ))))

#(define pitch->name
    (lambda (pitch)
      (let lookup ((es pitchnames))
        (if (null? es)
          #f
          (let ((current-pitch (cdr (car es))))
            (if (pitch-equal? pitch current-pitch )
              (add-octave-specifier-to-pitchname
                (symbol->string (car (car es)))  
                (ly:pitch-octave pitch))
              (lookup (cdr es))))))))

#(define string-json-join 
   ; start
   (lambda( list-of-strings )
     (let* ((list-of-quoted-strings 
              ; quote all the elements
              (map
                (lambda (v)
                  (string-append
                    "\""
                    (pitch->name v )
                    "\"" ))
                list-of-strings))
            (list-of-comma-added-strings
              ; append commans
              (let loop ((es list-of-quoted-strings ))
                (if (null? es )
                  '()
                  (cons
                    (car es)
                    (cons ", " (loop (cdr es)))))))
            (chopped-list 
              ; chop the list.
              (string-concatenate (reverse (cdr (reverse list-of-comma-added-strings ))))))
       chopped-list)))




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRANSPOSE (Mon, 14 May 2018 03:21:16 +0900)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (newline)
% (write 'notename:)
% (write  notename)
% (newline)
% (write 'octave:)
% (write octave)
% (newline)
% (write 'alter:)
% (write  alter)
% (newline)
#(define ch:pitch-semitones-proc 
   (lambda( octave notename alter )

     (let ((octave-in-chromatic 12)
           (diatonic-count 7)
           (diatonic-to-chromatic '((0 .  0)
                                    (1 .  2)
                                    (2 .  4)
                                    (3 .  5)
                                    (4 .  7)
                                    (5 .  9)
                                    (6 . 11))
                                  ))
       (+
         (*         (quotient  notename diatonic-count) octave-in-chromatic   )
         (cdr (assv (remainder notename diatonic-count) diatonic-to-chromatic ))
         (*                    octave                   octave-in-chromatic   )
         (*                    alter  2)))))

#(define ch:pitch-semitones 
   (lambda (n) 
     (ch:pitch-semitones-proc
       (ly:pitch-octave     n)
       (ly:pitch-notename   n)
       (ly:pitch-alteration n)
       )))


#(define ch:pitch-transpose
   (lambda ( p delta ) 
     (or (ly:pitch? p)     (error "Wrong argument error : the passed argument should be a music object." ))
     (or (ly:pitch? delta) (error "Wrong argument error : the passed argument should be a music object." ))

     (let* ((    p-semitones (ch:pitch-semitones p          ))
            (delta-semitones (ch:pitch-semitones delta      ))
            (  new-semitones (+ p-semitones delta-semitones ))
            (  tmp           (ly:make-pitch
                               (+ (ly:pitch-octave     p) (ly:pitch-octave     delta))
                               (+ (ly:pitch-notename   p) (ly:pitch-notename   delta))
                               (+ (ly:pitch-alteration p) (ly:pitch-alteration delta))))
            (  tmp-semitones (ch:pitch-semitones tmp ))
            (  difference    (- new-semitones tmp-semitones )) 
            (  result        (ly:make-pitch 
                               (ly:pitch-octave     tmp) 
                               (ly:pitch-notename   tmp) 
                               (+ (ly:pitch-alteration tmp) (/ difference 2) )
                               )))

       ; (primitive-eval ch:pitch-transpose-test )
       result)))


#(define ch:pitch-transpose-test '(begin
                                    (write 'p:)
                                    (write  p)
                                    (newline)
                                    (write 'delta:)
                                    (write  delta)
                                    (newline)
                                    (write 'p-semitones:)
                                    (write  p-semitones)
                                    (newline)
                                    (write 'delta-semitones:)
                                    (write  delta-semitones)
                                    (newline)
                                    (write 'new-semitones:)
                                    (write  new-semitones)
                                    (newline)
                                    (write 'tmp:)
                                    (write  tmp)
                                    (newline)
                                    (write 'tmp-semitones:)
                                    (write  tmp-semitones)
                                    (newline)
                                    (write 'differenece:)
                                    (write  difference )
                                    (newline)
                                    (write 'result:)
                                    (write  result )
                                    (newline)
                                    ))


#(define ch:music-transpose (lambda ( music delta )
                              (letrec ((proc-e (lambda(music-e)
                                                 (or
                                                   (if (eq? (ly:music-property music-e 'name) 'NoteEvent ) 
                                                     (let* ((pitch            (ly:music-property music-e 'pitch ))
                                                            (pitch-transposed (ch:pitch-transpose pitch delta  )))
                                                       (ly:music-set-property! music-e 'pitch pitch-transposed )
                                                       #t)
                                                     #f)
                                                   (let ((e (ly:music-property music-e 'element  )))
                                                     (if (null? e) #f (begin (proc-e e) #t )))
                                                   (let ((e (ly:music-property  music-e 'elements)))
                                                     (if (null? e) #f (begin (proc-l e) #t ))))
                                                 ))
                                       (proc-l (lambda(music-l) 
                                                 (let loop ((in-music music-l))
                                                     (proc-e (car in-music))
                                                     (or (null? (cdr in-music)) 
                                                         (loop (cdr in-music))))
                                                 #t)
                                               ))
                                (proc-e music))
                              music))

transpose-ch = 
#(define-scheme-function (parser location from to music )(ly:pitch? ly:pitch? ly:music?) 
                         (ch:music-transpose 
                           music
                           (ch:pitch-transpose to (ly:pitch-negate from))))

% #(write (pitch-equal? (ly:make-pitch -1 1  -2/4 ) (ly:make-pitch -1 1  -2/4 )) )


% #(display-scheme-music (equal? (ly:make-pitch -1 0  -8/4 ) (ly:make-pitch -1 0  -8/4 )))
% #(display-scheme-music (lookup-aaron-by-pitch (ly:make-pitch -1 1  -2/4 ) ))


% \language "aaron"
