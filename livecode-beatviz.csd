;; Live Coding with Csound 
;; Steven Yi <stevenyi@gmail.com>
;; 
;; Run this file using:
;;
;; csound livecode.csd 
;; 
;; to start Csound in UDP server, ready for live coding. 
;; The session will be pre-loaded and initialized with
;; code from livecode.orc.

<CsoundSynthesizer>
<CsOptions>
--port=10000 -o dac -m0 
</CsOptions>
<CsInstruments>

sr	= 48000	
ksmps	=	64
nchnls	=	2
0dbfs	=	1

;; Override Perform instrument definition to send beat value
;; via UDP to port 9228. Works with BeatViz program.
;; http://github.com/kunstmusik/BeatViz

instr Perform
  ibeat = p4

  schedule("P1", 0, p3, ibeat) 
  socksend(sprintf("%d", ibeat), "127.0.0.1", 9228, 1024)
endin

#include "livecode.orc"




</CsInstruments>
</CsoundSynthesizer>

