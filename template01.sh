#!/bin/bash
HELLO='HELLO WORLD'

cat <<-EOF

\version "2.18.2"
\include "oka-solfege-scale.ly"

\markup \bold \italic {
    Major 2nd with Diminished 3rd
}
\makescore 
  \relative do'{
    do re  s  di ri  s   re mi   s  ri\stau fa\stou  s    mi fi   s  fa sol   s  fi si   s  sol la   s  si li  s  la ti  s  li\stau do\stou   s  ti di  s  do re s do
  }
  
  \lyricmode {
    do re     di ri     re mi     ri  fa    mi fi     fa sol     fi si     sol la     si li     la ti     li do     ti di     do re     do
  }
  
\markup \bold \italic {
    Major 2nd Major 2nd with fa → ma / do → ta
}
\makescore 
  \relative do'{
    do re  s  di ri  s   re mi   s  ri\stau ma\stou  s    mi fi   s  fa sol   s  fi si   s  sol la   s  si li  s  la ti  s  li\stau te\stou   s  ti di  s  do re s do
  }
  
  \lyricmode {
    do re     di ri     re mi     ri  ma    mi fi     fa sol     fi si     sol la     si li     la ti     li te     ti di     do re     do
  }

\markup \bold \italic {
    Major 2nd Major 2nd with di → me / te → li
}
\makescore 
  \relative do'{
    do re  s  di ri  s   re mi   s  me\stau fa\stou  s    mi fi   s  fa sol   s  fi si   s  sol la   s  si li  s  la ti  s  te\stau do\stou   s  ti di  s  do re s do
  }
  
  \lyricmode {
    do re     di ri     re mi     me  fa    mi fi     fa sol     fi si     sol la     si li     la ti     te do     ti di     do re     do
  }

% vim: lisp sw=1 ts=1 sts=1 et
EOF
