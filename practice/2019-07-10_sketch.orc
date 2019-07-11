; Author: Steven Yi 
; Description: Sketch: The City 
; Date: 2019-07-10

start("ReverbMixer")

set_tempo(102)

chnset(0.8, "Reverb.fb")
chnset(0.5, "Organ1.rvb")

instr P1

  if( (p4 >> (p4 & 0x7)) & 1 == 1) then
    schedule("Organ1", 0, beats(2), random:i(0.99, 1.01) * in_scale(1, rand(array(2,4,6,8))), ampdbfs(-22))
  endif

  if( (p4 >> (p4 & 0x5)) & 1 == 1) then
    schedule("Organ1", 0, beats(2), random:i(0.99, 1.01) * in_scale(1, rand(array(2,4,6,8))), ampdbfs(-22))
  endif

  if( (p4 >> (p4 & 0x7)) & 2 == 2) then
    schedule("Organ1", 0, beats(2), random:i(0.99, 1.01) * in_scale(0, rand(array(2,4,6,8))), ampdbfs(-21))
  endif

  if( (p4 >> (p4 & 0x5)) & 2 == 2) then
    schedule("Organ1", 0, beats(2), random:i(0.99, 1.01) * in_scale(0, rand(array(2,4,6,8))), ampdbfs(-18))
  endif

  if( (p4 >> (p4 & 11)) & 2 == 2) then
    schedule("Organ1", 0, beats(2), in_scale(-2, rand(array(0,2,4,6,8))), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0xd)) & 1 == 1) then
    chnset(random:i(0.2, 0.8), "Mode1.pan")
    schedule("Mode1", 0, beats(2), in_scale(1, rand(array(0,2,4,6,8))), ampdbfs(-9))
  endif

endin
