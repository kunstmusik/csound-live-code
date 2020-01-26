;; Author: Steven Yi
;; Description: Bitshift Audio, sine source
;; Date: 2020-01-26

instr S1
  asig = oscili(128, p4)
  asig = int(asig)
  asig += 128
  
  asig = (asig # (asig << (asig & 0xc))) & (asig # (asig << (asig & 0xe)) )
  
  asig = asig % 256
  
  asig -= 128
  
  asig /= 128
  
  asig = zdf_ladder(asig, cpsoct(linsegr(12, p3, 6, 0.01, 4)), .5)
  asig = zdf_2pole(asig, p4, 0.5, 1)
  
  asig *= linsegr(p5, p3, 1, 0.1, 0)
  
  out(asig, asig)
endin
;schedule("S1", 0, 2, in_scale(0, 0))
; start("S1")e
; kill("S1")

instr P1
  
  schedule("S1", 0, 2, in_scale(1, cycle(p4, array(0,2,4,6))), ampdbfs(-12))

endin
