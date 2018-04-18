\version "2.18.2"
\include "aaron.ly"

% Common Library
#(define visit (lambda ( es callback )
                   (letrec ((proc (lambda (x)
                                      (if (eq? x '())
                                          #f
                                          (begin
                                           (callback (car x))
                                           (proc (cdr x)))))))
                       (proc es))))

#(define lookup-music-by-name (lambda ( es sym )
                                  (define result '())
                                  (visit es (lambda( e)
                                                (if (eq? (ly:music-property e 'name) sym )
                                                    (set! result
                                                          (cons e result))
                                                    #f)))
                                  result ))
% #(warn (length (lookup-music-by-name (ly:music-property (ly:music-property music 'element ) 'elements ) 'NoteEvent)))
% \void \displayMusic \music


#(define lookup-pitches (lambda(elements)
                            (define result '() )
                            (visit elements
                                (lambda (e)
                                    (if (eq? (ly:music-property e 'name) 'NoteEvent )
                                        (set! result (cons (ly:music-property e 'pitch) result))
                                        #f)))
                            (reverse result)))

#(define lookup-note-events (lambda(elements)
                            (define result '() )
                            (visit elements
                                   (lambda (e)
                                     (cond 
                                       ((eq? (ly:music-property e 'name) 'NoteEvent )
                                        (set! result (cons e result)))
                                       ((eq? (ly:music-property e 'name) 'RestEvent )
                                        (set! result (cons e result)))

                                       ((eq? (ly:music-property e 'name) 'TimeScaledMusic )
                                        (let loop2(( e2 
                                                          (lookup-note-events 
                                                            (ly:music-property 
                                                              (ly:music-property 
                                                                e 
                                                                'element) 
                                                              'elements))))
                                          (if (null? e2)
                                            #f
                                            (begin
                                              (set! result (cons (car e2) result))
                                              (loop2 (cdr e2))))))
                                       (else #f))
                                     ))
                            (reverse result)))

#(define music-to-elements-ver-two(lambda (music)
                               (let ((result '() ))
                                   (if (list? music )
                                       (begin
                                        (set! result music ))
                                       (begin
                                        (set! result (ly:music-property music 'elements '() ))
                                        (if (null? result )
                                            (begin
                                             (set! result (ly:music-property music 'element '()))
                                             (if (null? result)
                                                 (begin
                                                  (set! result music ))
                                                 (begin
                                                  (set! result (ly:music-property result 'elements ))))
                                             )
                                            (begin))
                                        ))
                                   result
                                   )))

#(define music-to-elements-ver-three (lambda(music)
                             ; (write "music-to-elements:" )
                             ; (newline)
                             ; (display-scheme-music music)
                             ; (newline)
                             ; (newline)

                             (if (null? music)
                               (throw 'failed-to-get-music )
                               (if (list? music)
                                 (begin
                                   (let* (( music-car (car music ) )
                                          ( music-car-element (ly:music-property music-car 'element '())))
                                     (if (null? music-car-element )
                                       music
                                       (begin
                                         ;(write "class" )
                                         ;(write (ly:music-property music-car-element 'name ))
                                         (newline)
                                         (if (eq? (ly:music-property music-car-element 'name ) 'PropertySet )
                                           music
                                           (music-to-elements music-car-element )))

                                       )))
                                 (let (( result (ly:music-property music 'element '()) ))
                                         ;(write 'class )
                                         ;(write (ly:music-property music 'class ))
                                   (if (null? result)
                                     ; In this case result should be 'elements
                                     (music-to-elements
                                       (ly:music-property music 'elements '()))

                                     ; In this case music should be 'elements
                                     (music-to-elements
                                       result)))))))

#(define music-to-elements (lambda(music)
                             (letrec
                               ((proc-list (lambda ( elements )
                                             (apply append (let loop ((elements elements ))
                                                           (if (null? elements )
                                                             '()
                                                             (cons (proc-elem (car elements )) (loop (cdr elements ))))))))
                                (proc-elem (lambda( e )
                                             (let ((name (ly:music-property e 'name))) 
                                               (cond
                                                 ((eq? name 'SequentialMusic )
                                                  (proc-list (ly:music-property e 'elements )))
                                                 ((eq? name 'RelativeOctaveMusic )
                                                  (proc-elem (ly:music-property e 'element )))
                                                 ((eq? name 'TransposedMusic )
                                                  (proc-elem (ly:music-property e 'element )))
                                                 ((eq? name 'TimeScaledMusic )
                                                  (proc-elem (ly:music-property e 'element )))


                                                 ((eq? name 'UnfoldedRepeatedMusic )
                                                  (apply append (let loop2 (( count (ly:music-property e 'repeat-count )))
                                                                (if (< 0 count )
                                                                  (cons
                                                                    (proc-elem (ly:music-deep-copy (ly:music-property e 'element ))) 
                                                                    (loop2 (- count 1 )))
                                                                  '()))))
                                                 ((eq? name 'NoteEvent )
                                                  (list e))
                                                 ((eq? name 'RestEvent )
                                                  (list e))
                                                 (else '()))))))
                               (proc-elem music ))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creating guitar strings to note number
%

%{
                            (make-music
                              'RelativeOctaveMusic
                              'element
                              (make-music
                                'SequentialMusic
                                'elements
                                (list (make-music
                                        'NoteEvent
                                        'pitch
                                        (ly:make-pitch -1 2 0)
                                        'duration
                                        (ly:make-duration 2 0 1))
                                      (make-music
                                        'NoteEvent
                                        'pitch
                                        (ly:make-pitch -1 5 0)
                                        'duration
                                        (ly:make-duration 2 0 1))
                                      (make-music
                                        'NoteEvent
                                        'pitch
                                        (ly:make-pitch 0 1 0)
                                        'duration
                                        (ly:make-duration 2 0 1))
                                      (make-music
                                        'NoteEvent
                                        'pitch
                                        (ly:make-pitch 0 4 0)
                                        'duration
                                        (ly:make-duration 2 0 1))
                                      (make-music
                                        'NoteEvent
                                        'pitch
                                        (ly:make-pitch 0 6 0)
                                        'duration
                                        (ly:make-duration 2 0 1))
                                      (make-music
                                        'NoteEvent
                                        'pitch
                                        (ly:make-pitch 1 2 0)
                                        'duration
                                        (ly:make-duration 2 0 1)))))
  %}

#(define mi-la-re-sol-ti-mi 
   (list (make-music
           'NoteEvent
           'pitch
           (ly:make-pitch -1 2 0)
           'duration
           (ly:make-duration 2 0 1))
         (make-music
           'NoteEvent
           'pitch
           (ly:make-pitch -1 5 0)
           'duration
           (ly:make-duration 2 0 1))
         (make-music
           'NoteEvent
           'pitch
           (ly:make-pitch 0 1 0)
           'duration
           (ly:make-duration 2 0 1))
         (make-music
           'NoteEvent
           'pitch
           (ly:make-pitch 0 4 0)
           'duration
           (ly:make-duration 2 0 1))
         (make-music
           'NoteEvent
           'pitch
           (ly:make-pitch 0 6 0)
           'duration
           (ly:make-duration 2 0 1))
         (make-music
           'NoteEvent
           'pitch
           (ly:make-pitch 1 2 0)
           'duration
           (ly:make-duration 2 0 1))))

#(define fretdiagram:guitar-string-offset-map
     ((lambda ()
          (define result '())
          (visit
           ; (ly:music-property (ly:music-property mi-la-re-sol-ti-mi 'element ) 'elements )
           mi-la-re-sol-ti-mi
           (lambda(e)
               (set! result
                     (cons
                      (+  (ly:pitch-semitones (ly:music-property e 'pitch ) )  12 )
                      result))
               ;(write (+  (ly:pitch-semitones (ly:music-property e 'pitch ))  12 )  )
               ;(write (ly:pitch-semitones (ly:music-property e 'pitch ) ))
               ))
          (append '(null)  result ))))
%#(warn fretdiagram:guitar-string-offset-map)

#(define set-string-number-to-note-event
     (lambda ( e num )
         ;(warn (ly:grob-array? (ly:music-property e 'articulations)))
         (set! (ly:music-property e 'articulations)
               (cons
                (make-music
                 'StringNumberEvent
                 'string-number
                 num)
                (ly:music-property e 'articulations)))))

#(define fretdiagram:default-def (lambda()
                                   (list
                                     '(capo -2 )
                                    )))
#(define fretdiagram:flg-expand-all-string #f)
#(define fretdiagram:def (fretdiagram:default-def) )
#(define fretdiagram:init (lambda() (set! fretdiagram:def (fretdiagram:default-def) )))
#(define fretdiagram:get (lambda() fretdiagram:def ))
#(define fretdiagram:valid-position
     (lambda ( string-num fret-num  )
         (and
          (< 0 string-num ) ; string-num == 0 indicates hiding the fret dot. 7 Apr 2018
          (<= 0 fret-num )
          (< fret-num 26 ))))

#(define fretdiagram:add
     (lambda (string-num fret-num fret-mark inverted )
	   ; (write 'inverted: )(write inverted)(newline)

         (if  (fretdiagram:valid-position string-num fret-num )
              (begin
               (set! fretdiagram:def
                     (cons
                      (list
                       'place-fret
                       string-num
                       fret-num
                       (markup
                        #:line
                        (#:override
                         (cons (quote font-family) (quote serif))
                         (#:italic
                          fret-mark )))
                       (if inverted
                           'inverted
                           #f)
                      )
                      fretdiagram:def ))
               #t)
              #f)

         ; (warn fretdiagram:def)
         ))

#(define fretdiagram:add-by-pitch-offset
     (lambda* ( string-num pitch-offset pitch-name inverted )
         (define string-offset (list-ref fretdiagram:guitar-string-offset-map string-num))
         (fretdiagram:add string-num (- pitch-offset string-offset) pitch-name inverted )))

#(define note-event-to-string-num
     (lambda (e)
         (define sne (car (reverse (lookup-music-by-name (ly:music-property e 'articulations ) 'StringNumberEvent ))))
         (if (null? sne )
             '()
             (ly:music-property sne 'string-number))))


#(define fretdiagram:add-by-pitch
     (lambda* ( string-num pitch pitch-shift inverted )
#!
         (write "***********************")(newline)
         (write string-num )(newline)
         (write pitch )(newline)
         (write  pitch-shift )(newline)
         (write inverted)(newline)
         (newline)
!#
         (if fretdiagram:flg-expand-all-string
             (letrec
              (( pitch-offset (+  (ly:pitch-semitones pitch ) 12 pitch-shift ) )
               ( pitch-name   (lookup-aaron-by-pitch pitch))
               (loop_x
                (lambda (x)
                    ;(write x)(newline)
                    ; (write pitch-offset)(newline)
                    (fretdiagram:add-by-pitch-offset x pitch-offset pitch-name inverted )
                    (if (< 1 x )
                        (loop_x (- x 1 ))
                        #f))))
              (loop_x  6))

             (let*
              (( pitch-offset (+ (ly:pitch-semitones pitch ) 12 pitch-shift ))
               ( pitch-name   (lookup-aaron-by-pitch pitch)))
              (fretdiagram:add-by-pitch-offset string-num pitch-offset pitch-name inverted )))))


#(define fretdiagram:add-note-event
     (lambda* (e)
         (let*
          (( pitch        (ly:music-property e 'pitch))
           ( string-num   (note-event-to-string-num e)))
          ;(write "pitch-offset=" )(write pitch-offset)
          ;(write "string-offset=" )(write string-offset)
          ;(newline)
          (fretdiagram:add-by-pitch string-num pitch 0 #f )
          )))

#(define fretdiagram:trim (lambda ()
                              (letrec (( proc (lambda( in out )

                                                  )
                                           ))

                                  )
                              ))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define put-string-number-on-music!
     (lambda (music string-number-map)
         (visit
          (ly:music-property (ly:music-property music 'element ) 'elements )
          ((lambda()
               (define counter 0)
               (lambda (e)
                   (if (eq? (ly:music-property e 'name) 'NoteEvent )
                       (begin
                        (set-string-number-to-note-event e (list-ref string-number-map counter ))
                        (set! counter (+ counter 1)) )
                       #f)))))
         music ))


#(define create-fretdiagram-definition
     (lambda (music)
         (fretdiagram:init)

         (visit
          ;(ly:music-property (ly:music-property music 'element ) 'elements )
          (music-to-elements music)
          (lambda (e)
              (if (eq? (ly:music-property e 'name) 'NoteEvent )
                  (begin
                   (fretdiagram:add-note-event e)))))
         (fretdiagram:get)))


#(define create-simple-fretdiagram-definition
   ;lowest-note highest-note skip-note-count string-number-list
   (lambda (music string-number-list skip-count root-offset )
     (set! music (music-to-elements music))
     (fretdiagram:init)

     (let* ((pitches (lookup-pitches music ))
           (pitch-shift 0 )
           (root-pitch (if (<= 0 root-offset )
                         (list-ref pitches root-offset )
                         (root-offset #f)))
           )

       (let loop-1 ((pitches pitches)
                    (counter (- -1 skip-count))
                    (pitch-shift pitch-shift))
         (if (null? pitches)
           #f
           (let ((pitch (car pitches)))
             ; (write counter)(newline)
             (if (and
                   (<= 0 counter )
                   (< counter (length string-number-list )))
               (let ( (current-string-number (list-ref string-number-list counter ) ))

                 (fretdiagram:add-by-pitch
                   (if (pair? current-string-number)
                     (car current-string-number)
                     current-string-number )
                   pitch
                   pitch-shift

                   (or
                     (if (pair? current-string-number)
                       (cdr current-string-number)
                       #f )
                      (and root-pitch (pitch-equals root-pitch pitch)))

                   ))

               #f)
             (loop-1 (cdr pitches) (+ counter 1 ) pitch-shift )
             )))

       ; (loop-1 pitches (- -1 skip-count ) 0 )
       ; (loop-1 pitches 12)
       ; (loop-1 pitches 24)
       ; (loop-1 pitches 36)
       ; (loop-1 pitches 48)
       )

     (fretdiagram:get))
   )

#(define pitch-equals (lambda (p1 p2)
                       (and
                         (= (ly:pitch-alteration p1)(ly:pitch-alteration p2))
                         (= (ly:pitch-notename   p1)(ly:pitch-notename   p2)))))

#(define create-entire-fretdiagram-definition
   ;lowest-note highest-note skip-note-count string-number-list
   (lambda (music root-offset )
     (define string-number-list (list 6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1 ) )
     (define skip-count 2 )
     (set! music (music-to-elements music))

     (fretdiagram:init)
     (let* ((pitches
             (lookup-pitches music ))
           (root-pitch (if (<= 0 root-offset )
                         (list-ref pitches root-offset )
                         (root-offset #f))))

       (let loop-1 ((pitches pitches)
                    (pitch-shift 0))
         (if (null? pitches)
           #f
           (let ((pitch (car pitches)))
             (let loop-2 ((string-number 6 ))
               (if (< 0 string-number )
                 (begin
                   ; (write string-number)(newline)
                   (fretdiagram:add-by-pitch
                     string-number
                     pitch
                     pitch-shift
                     (and root-pitch (pitch-equals root-pitch pitch)))
                   (loop-2 (- string-number 1)))
                 #f))
             (loop-1 (cdr pitches) pitch-shift ))))

;       (letrec (
;                (loop-1 ))
;         (loop-1 pitches 0)
;         ; (loop-1 pitches 12)
;         ; (loop-1 pitches 24)
;         ; (loop-1 pitches 36)
;         ; (loop-1 pitches 48)
;         )

       )
     (fretdiagram:get))
   )

%#(module-define! (resolve-module '(guile-user))
%                 'lilypond-module (current-module))

% #(use-modules (ice-9 debugging trace) )
% #(use-modules (ice-9 debug ) )
% #(use-modules (scm guile-debugger))
% #(define tc (set-trace-subtree! create-simple-fretdiagram-definition))
% #(write '**************************************************)

% #(begin
%      ;(set-trace-layout "|~3@a: ~a\n" trace/stack-real-depth trace/info)
%      (set-trace-layout "| ~25a ~3@a: ~a ~a\n"
%          trace/source
%          trace/stack-depth
%          trace/type
% .         trace/info))



% #(display-scheme-music fretdiagram:def)
#(define put-fretdiagram-on-music!
     (lambda (music fretdiagram-definition )
         ;(define obj1 (last (lookup-music-by-name (ly:music-property (ly:music-property music 'element ) 'elements ) 'NoteEvent)))
         (define obj1 (last (lookup-music-by-name (music-to-elements music) 'NoteEvent)))
         (set!
          (ly:music-property obj1 'articulations )
          (cons
           ; (make-music 'TextScriptEvent
           ; 'text (markup #:bold (markup #:abs-fontsize 32 (markup "I HATE SCHEME!!!" ) ) (markup #:beam 5 1 2) ))
           (make-music 'TextScriptEvent
               'direction 1
               'text
               (markup #:override '(font-family . serif )
                   (markup #:translate '(8 . 0)
                       (markup
                        #:line
                        (#:override
                         (cons (quote size) 2.0)
                         (#:override
                          (list 'fret-diagram-details
                              (cons (quote dot-color) 'white)
                              (cons (quote finger-code) (quote in-dot))
                              (cons (quote number-type) (quote arabic))
                              (cons (quote fret-label-font-mag) 0.5)
                              (cons (quote dot-label-font-mag) 0.6)
                              (cons (quote string-label-font-mag) 0.6 )
                              (cons 'dot-radius 0.40 )
                              (cons (quote label-dir) 1)
                              (cons (quote mute-string) "M")
                              (cons (quote orientation) (quote landscape))
                              (cons (quote barre-type) (quote curved))
                              (cons 'top-fret-thickness  2)
                              (cons 'capo-thickness  0.0)

                              (cons (quote xo-font-magnification) 0.4)
                              (cons (quote xo-padding) 0.3))
                          (#:fret-diagram-verbose  fretdiagram-definition  )))))))
           (ly:music-property obj1 'articulations )))))


#(define fret-diagram-details-default (list 'fret-diagram-details
                                            (cons (quote dot-color) 'white)
                                            (cons (quote number-type) 'arabic)
                                            (cons (quote orientation) (quote landscape))
                                            (cons (quote minimum-fret) 5)
                                            (cons (quote finger-code) (quote in-dot))
                                            (cons (quote number-type) (quote arabic))
                                            (cons (quote fret-label-font-mag) 0.5)
                                            (cons (quote dot-label-font-mag) 0.6)
                                            (cons (quote string-label-font-mag) 0.6 )
                                            (cons 'dot-radius 0.40 )
                                            (cons (quote label-dir) 1)
                                            (cons (quote mute-string) "M")
                                            (cons (quote barre-type) (quote curved))
                                            (cons 'top-fret-thickness  4)
                                            (cons 'capo-thickness  0.0)

                                            (cons (quote xo-font-magnification) 0.4)
                                            (cons (quote xo-padding) 0.3)))


#(define-markup-command (scale-diagram layout props cmusic fret-positions skip-count root-offset) (ly:music? list? integer? integer? )
   (interpret-markup layout props
       (markup #:override '(font-family . serif )
           (markup #:translate '(4 . 0)
               (markup
                #:line
                (#:override
                 (cons (quote size) 2.0)
                 (#:override
                  fret-diagram-details-default
                  (#:fret-diagram-verbose

                   (create-simple-fretdiagram-definition
                    cmusic
                    fret-positions
                    skip-count
                    root-offset)))))))))


#(define-markup-command (entire-scale-diagram layout props cmusic root-offset ) (ly:music? integer?)
   (interpret-markup layout props
       (markup #:override '(font-family . serif )
           (markup #:translate '(4 . 0)
               (markup
                #:line
                (#:override
                 (cons (quote size) 2.0)
                 (#:override
                  fret-diagram-details-default

                  (#:fret-diagram-verbose

                   (create-entire-fretdiagram-definition
                    cmusic
                    root-offset)))))))))







%#(write put-scale-chart!)
%#(newline)

% #(warn (length (lookup-music-by-name (ly:music-property (ly:music-property music 'element ) 'elements ) 'NoteEvent)))
% vim: lisp sw=1 ts=1 sts=1 et

%{
inputmusic = { do' re mi }
#(create-simple-fretdiagram-definition
  inputmusic
  (list
   6 6 6 5 5 5 4 4 4 3 3 3 2 2 2 1 1 1
   1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 )
  0)
%}
#(write   'hello)



#(define aaron-to-pronunciation (lambda (note ) 
                                  (cond 
                                    ((string=? note "do" )  "doh"  )
                                    ((string=? note "di" )  "dee"  )
                                    ((string=? note "ra" )  "rah"  )
                                    ((string=? note "re" )  "ray"  )
                                    ((string=? note "ri" )  "ree"  )
                                    ((string=? note "me" )  "meh"  )
                                    ((string=? note "mi" )  "mee"  )
                                    ((string=? note "fa" )  "faah"  )
                                    ((string=? note "fi" )  "fee"  )
                                    ((string=? note "se" )  "saeh"  )
                                    ((string=? note "sol")  "sew"  )
                                    ((string=? note "si" )  "see"  )
                                    ((string=? note "le" )  "laeh"  )
                                    ((string=? note "la" )  "lah"  )
                                    ((string=? note "li" )  "lee"  )
                                    ((string=? note "te" )  "taeh"  )
                                    ((string=? note "ti" )  "tee"  )

                                    ((string=? note "daw" )  "daw"  )
                                    ((string=? note "raw" )  "raw"  )
                                    ((string=? note "maw" )  "maw"  )
                                    ((string=? note "faw" )  "faw"  )
                                    ((string=? note "saw" )  "saw"  )
                                    ((string=? note "law" )  "law"  )
                                    ((string=? note "taw" )  "taw"  )

                                    ((string=? note "dai" )  "dai"  )
                                    ((string=? note "rai" )  "rai"  )
                                    ((string=? note "mai" )  "mai"  )
                                    ((string=? note "fai" )  "fai"  )
                                    ((string=? note "sai" )  "sai"  )
                                    ((string=? note "lai" )  "lai"  )
                                    ((string=? note "tai" )  "tai"  )

                                    (else "ugh"))))

#(define aaron-to-octave-offset (lambda (note ) 
                                  (cond 
                                    ((string=? note "daw" )  -1  )
                                    ((string=? note "tai" )  1  )
                                    (else 0 ))))

#(define aaron-to-eng (lambda (note ) 
                                  (cond 
                                    ((string=? note "do" )  "C"   )
                                    ((string=? note "di" )  "C#"  )
                                    ((string=? note "ra" )  "Db"  )
                                    ((string=? note "re" )  "D"   )
                                    ((string=? note "ri" )  "D#"  )
                                    ((string=? note "me" )  "Eb"  )
                                    ((string=? note "mi" )  "E"   )
                                    ((string=? note "fa" )  "F"   )
                                    ((string=? note "fi" )  "F#"  )
                                    ((string=? note "se" )  "Gb"  )
                                    ((string=? note "sol")  "G"   )
                                    ((string=? note "si" )  "G#"  )
                                    ((string=? note "le" )  "Ab"  )
                                    ((string=? note "la" )  "A"   )
                                    ((string=? note "li" )  "A#"  )
                                    ((string=? note "te" )  "Bb"  )
                                    ((string=? note "ti" )  "B"   )

                                    ((string=? note "daw" )  "Bb"  )
                                    ((string=? note "raw" )  "C"  )
                                    ((string=? note "maw" )  "D"  )
                                    ((string=? note "faw" )  "Eb"  )
                                    ((string=? note "saw" )  "F"  )
                                    ((string=? note "law" )  "G"  )
                                    ((string=? note "taw" )  "A"  )

                                    ((string=? note "dai" )  "D"  )
                                    ((string=? note "rai" )  "E"  )
                                    ((string=? note "mai" )  "F#"  )
                                    ((string=? note "fai" )  "G"  )
                                    ((string=? note "sai" )  "A"  )
                                    ((string=? note "lai" )  "B"  )
                                    ((string=? note "tai" )  "C#"  )
                                    (else "ugh"))))


%%%%%%%%%%%%%%%%%%%%%%%%%%%55

#(define new-test-festival-formatter (lambda (file-name)
                                  (let ((output-port (open-file "my.txt" "a" )))
                                    (lambda ( event-type note note-pronunciation ) 
                                      (cond
                                        ((eq? event-type 'begin  ) 
                                         (display event-type output-port ) 
                                         (newline output-port)
                                         )
                                        ((eq? event-type 'note-event   )
                                         (display event-type output-port)
                                         (display " " output-port)
                                         (display note output-port)
                                         (display "=" output-port)
                                         (display note-pronunciation output-port)
                                         (newline output-port)
                                         )

                                        ((eq? event-type 'end    )
                                         (display event-type output-port) 
                                         (newline output-port)
                                         (force-output output-port)
                                         (close output-port)
                                         )
                                        (else  #f))))))




#(define new-festival-formatter (lambda (file-name tempo )
                                  (let ((output-port (open-file file-name "w" )))
                                    (lambda ( event-type note-event ) 
                                      (cond
                                        ((eq? event-type 'begin  ) 
                                         (display "<?xml version=\"1.0\"?>\n" output-port)
                                         (display "<!DOCTYPE SINGING PUBLIC \"-//SINGING//DTD SINGING mark up//EN\" \"Singing.v0_1.dtd\" []>\n" output-port)
                                         (display (string-append "<SINGING BPM=\""  (object->string tempo ) "\">\n") output-port) 
                                         )

                                        ((or (eq? event-type 'rest-event )
                                             (eq? event-type 'skip-event ))
                                         (display (string-append 
                                                    "<REST BEATS=\"" 
                                                    (object->string 
                                                      (exact->inexact
                                                        (* 4
                                                           (ly:moment-main (ly:duration-length (ly:music-property note-event 'duration ))))))
                                                    "\">"
                                                    "</REST>\n" ) output-port ))
                                        ((eq? event-type 'note-event )
                                         (let ((pitch (ly:music-property note-event 'pitch )))
                                           ;; (display (ly:moment-main (ly:duration-length (ly:music-property note-event 'duration ))) )
                                           ;; (newline)
                                           (display (string-append 
                                                      "<PITCH NOTE=\""
                                                      (aaron-to-eng (lookup-aaron-by-pitch pitch))
                                                      (object->string (+ 4
                                                                         (ly:pitch-octave pitch ) 
                                                                         (aaron-to-octave-offset (lookup-aaron-by-pitch pitch))))
                                                      "\"><DURATION BEATS=\"" 
                                                      (object->string 
                                                        (exact->inexact
                                                          (* 4
                                                            (ly:moment-main (ly:duration-length (ly:music-property note-event 'duration ))))))
                                                      "\">"
                                                      (aaron-to-pronunciation (lookup-aaron-by-pitch pitch))
                                                      "</DURATION></PITCH>\n" ) output-port )))

                                        ((eq? event-type 'end )
                                         (display "</SINGING>\n" output-port)
                                         (force-output output-port)
                                         (close output-port))
                                        (else  #f))))))

#(define new-music-to-aaron (lambda ()
                              (define result '() )
                              (lambda ( event-type note-event ) 
                                (cond
                                  ((eq? event-type 'begin ))
                                  ((eq? event-type 'note-event )
                                   (set! result 
                                     (cons
                                       (make-music
                                         'LyricEvent
                                         'text
                                         (lookup-aaron-by-pitch (ly:music-property note-event 'pitch ))
                                         'duration
                                         (ly:music-deep-copy (ly:music-property note-event 'duration )))
                                       result )))
                                  ((or (eq? event-type 'rest-event )
                                       (eq? event-type 'skip-event )))
                                  ((eq? event-type 'end )
                                    (reverse result ))

                                  (else  #f))))) 


#(define visit-music (lambda ( music event-handler )
                             (set! music (music-to-elements music))
                             (let ((note-events music )
                                   (note-events-comment-out "(lookup-note-events music )"))
                               (event-handler 'begin '() )

                               (let loop (( note-events note-events )) 
                                 (if ( null? note-events )
                                   #f 
                                   (let* (( note-event (car note-events ))
                                          ( note-event-name (ly:music-property note-event 'name )))
                                     (cond 
                                       ((eq? note-event-name 'NoteEvent )
                                        (event-handler 'note-event note-event  ))
                                       ((eq? note-event-name 'RestEvent )
                                        (event-handler 'rest-event note-event  ))
                                       ((eq? note-event-name 'SkipEvent )
                                        (event-handler 'skip-event note-event  ))
                                       (else (display "****************************************************"))
                                       )
                                     (loop (cdr note-events ))))))
                               (event-handler 'end '() )))



#(define compile-festival (lambda (input-file output-file voice )
                            (set! input-file (if (null? input-file ) "default.xml" input-file ))
                            (set! output-file (if (null? output-file ) "default.wav" output-file ))
                            (set! voice (if (null? voice ) "voice_us1_mbrola" (string-append "voice_" voice ) ))
                            (system 
                              (string-append "text2wave -eval \"("
                                             voice
                                             ")\" -mode singing " 
                                             input-file
                                             " > "
                                             output-file ))))

#(define read-aloud-music (lambda ( music output-file tempo voice) 
                             (visit-music music (new-festival-formatter output-file tempo ) )
                             (compile-festival output-file  (string-append output-file ".wav" )  voice )
                             ; (system "gnome-open my.wav" )
                             ))

music-to-festival = #(define-void-function (parser location music output-file tempo voice )(ly:music? string? number? string? )
    (read-aloud-music music output-file tempo (if (string=? voice "" ) '() voice ) )
)

music-to-aaron = #(define-music-function (parser location music)(ly:music?)
    (make-music 'SequentialMusic 'elements
     (visit-music music (new-music-to-aaron))))





% kate: font-size 16; indent-pasted-text true; indent-width 16 ; auto-brackets ;
% vim: expandtab :
