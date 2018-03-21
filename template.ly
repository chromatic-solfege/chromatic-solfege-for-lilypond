\version "2.18.2"
\include "aaron.ly"
\include "../chromatic-solfege-gen.ly"

% ${COMMENT}
\markup \bold \italic {
    ${CAPTION_01}
}
\makescore 
  \relative do'{
    ${NOTES_01}
  }
  \lyricmode {
    ${LYRICS_01}
  }
  
\markup \bold \italic {
    ${CAPTION_02}
}
\makescore 
  \relative do'{
    ${NOTES_02}
  } 
  \lyricmode {
    ${LYRICS_02}
  }

\markup \bold \italic {
    ${CAPTION_03}
}
\makescore 
  \relative do'{
    ${NOTES_03}
  }
  \lyricmode {
    ${LYRICS_03}
  }

% vim: filetype=lilypond sw=1 ts=1 sts=1 et
