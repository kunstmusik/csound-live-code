; Author: Steven Yi
; Description: Grains
; Date: 2019-07-12

start("ReverbMixer")

set_tempo(85)

instr S1
  asig = oscili(p5, p4)
  asig *= 0.5
  asig = declick(asig)
  pan_verb_mix(asig, random:i(0.3, 0.7), 0.1)
endin

instr Grain
  
  if((p5 >> (p5 & rand(array(0xc, 0x7, 0x5, 0x3, 0xb)))) & 1 == 1) then
    schedule("S1", 0, p3, p4, ampdbfs(-15))  
  endif

  if(p5 < 50) then
    schedule(p1, p3, p3, p4, p5 + 1)
  endif
endin

instr P1

  hexplay("8000", "Grain", ticks(0.5), in_scale(1, 0), 1)
  hexplay("8000", "Grain", ticks(0.5), in_scale(0, 0), 1)
  hexplay("f0", "Grain", ticks(0.5), in_scale(0, rand(array(0,2,4,6))), 1)
  hexplay("f0", "Grain", ticks(0.5), in_scale(0, rand(array(0,2,4,6))), 1)
  hexplay("bcbdbcb", "Grain", ticks(0.5), in_scale(1, rand(array(0,2,4,6))), 1)
  hexplay("c0d3d0c", "Grain", ticks(0.5), in_scale(0, rand(array(1,3,5))), 1)

  hexplay("80000000", 
      "Sine", p3,
      in_scale(2, 0),
      fade_in(11, 128) * ampdbfs(-12))

endin
