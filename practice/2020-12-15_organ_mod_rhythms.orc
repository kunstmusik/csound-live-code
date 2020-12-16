;; Author: Steven Yi
;; Date: 2020.12.15
;; Description: Organ Rhythms using Schillinger-inspired modulus patterns

start("ReverbMixer")
xchnset("Organ3.rvb", 0.4)

instr P1
  
  iv = p4 % 128
  
  if(iv % 7 == 0) then
    schedule("Organ3", 0, p3, in_scale(0, 0), ampdbfs(-15))
  endif
  
  
  if(iv % 5 == 0) then
    schedule("Organ3", 0, p3, in_scale(0, 1), ampdbfs(-15))
  endif
  
  if(iv % 4 == 0 && iv % 3 == 0) then
    schedule("Organ1", 0, p3 * 10, in_scale(1, 4), ampdbfs(-18))
  endif
  
  if(iv % 4 # iv % 3 == 0) then
    schedule("Organ3", 0, p3, in_scale(1, 2 + xsin(phsb(4), 0, 4)), ampdbfs(-20))
  endif
  
  if(iv % 4 == 0 || iv % 3 == 0) then
    schedule("Organ3", 0, p3, in_scale(-1, 4), ampdbfs(-15))
  endif
  
  if(p4 % 9 == 0 || iv % 7 == 0) then
    schedule("Organ3", 0, p3, in_scale(0, 4), ampdbfs(-15))
  endif
  
  iv = p4 % 128 % 7 % 2
  if(iv == 0) then
    schedule("Organ3", 0, p3, in_scale(0, xlin(phsb(2), 0, 17)), ampdbfs(-15))
  endif
  
endin

