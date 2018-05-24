; See /usr/share/festival/radio_phones.scm
; See /usr/share/festival/voices/english/us1_mbrola/usradio 
; Available pronunciations are :
; aa ae ah ao aw ax axr ay b ch d dh dx eh el em en er ey f g hh hv ih iy jh k
; l m n nx ng ow oy p r s sh t th uh uw v w y z zh pau h# brth

; (voice_us1_mbrola)(SayText "hello" )
; (voice_us1_mbrola)(SayText "hello" )

; **** Defining "aw" ****
(lex.add.entry '( "daw" nil  (((d ao ) 0.1 )           )))
(lex.add.entry '( "raw" nil  (((r ao ) 0.1 )           )))
(lex.add.entry '( "maw" nil  (((m ao ) 0.1 )           )))
(lex.add.entry '( "faw" nil  (((f ao ) 0.1 )           )))
(lex.add.entry '( "saw" nil  (((s ao ) 0.1 )           )))
(lex.add.entry '( "law" nil  (((l ao ) 0.1 )           )))
(lex.add.entry '( "taw" nil  (((t ao ) 0.1 )           )))

; (SayText "daw raw maw faw saw law taw daw" )

; **** Defining "ae" ****

(lex.add.entry '( "dae" nil  (((d ae ) 0.1 )           )))
(lex.add.entry '( "rae" nil  (((r ae ) 0.1 )           )))
(lex.add.entry '( "mae" nil  (((m ae ) 0.1 )           )))
(lex.add.entry '( "fae" nil  (((f ae ) 0.1 )           )))
(lex.add.entry '( "sae" nil  (((s ae ) 0.1 )           )))
(lex.add.entry '( "lae" nil  (((l ae ) 0.1 )           )))
(lex.add.entry '( "tae" nil  (((t ae ) 0.1 )           )))

; (SayText "dae rae mae fae sae lae tae dae" )





; (lex.add.entry '( "daiu" nil  (((d ey ) 0.1 )           )))
; (lex.add.entry '( "raiu" nil  (((r ey ) 0.1 )           )))
; (lex.add.entry '( "maiu" nil  (((m ey ) 0.1 )           )))
; (lex.add.entry '( "faiu" nil  (((f ey ) 0.1 )           )))
; (lex.add.entry '( "saiu" nil  (((s ey ) 0.1 )           )))
; (lex.add.entry '( "laiu" nil  (((l ey ) 0.1 )           )))
; (lex.add.entry '( "taiu" nil  (((t ey ) 0.1 )           )))
; 
;(lex.add.entry
;  '("grave" n (
;			   (
;				(g r ei v) 
;				1))
;	((pos "Kj%"))
;
;	))

; (lex.add.entry '( "daw" nil  ((( d ao ) 0.1))))
; (lex.add.entry '( "raw" nil  ((( r ao ) 0.8))))
; (lex.add.entry '( "maw" nil  ((( m ao ) 0.4))))
; (lex.add.entry '( "faw" nil  ((( f ao ) 0.8))))
; (lex.add.entry '( "saw" nil  ((( s ao ) 0.8))))
; (lex.add.entry '( "law" nil  ((( l ao ) 0.8))))
; (lex.add.entry '( "taw" nil  ((( t ao ) 0.8))))
 
; (SayText "dey rey mey fey seiy leiy tey dey" )
; (SayText "daiu raiu maiu faiu  saiu laiu taiu daiu" )
; (SayText "daw raw maw faw saw law taw daw" )
; (SayText "daw taw law saw faw maw raw daw" )
