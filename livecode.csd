;; Live Coding with Csound 
;; Steven Yi <stevenyi@gmail.com>
;; 
;; Run this file using:
;;
;; csound livecode.csd --port=10000 -o dac
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

#include "livecode.orc"


</CsInstruments>
</CsoundSynthesizer>

