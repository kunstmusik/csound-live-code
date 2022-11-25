set_tempo(108)

instr S1
  asig = vco2(p5, p4, 2, .5 + lfo(.1, 2))
  asig += vco2(p5, p4 * 2, 2, .4 + lfo(.1, 4))
  
  asig *= 0.7
  
  ioct = octcps(p4)
  kcut = limit(ioct + transegr:k(0, 0.005, 0, 6, .5, -4.2, 0, .25, -4.2, 0) - 1, 4, 14)
  asig = zdf_ladder(asig, cpsoct(kcut), 0.5)
  
  pan_verb_mix(asig, 0.5, 0.3)
endin

instr M1
  ioct = ((p4 % 37 % 7) >> ((p4 / 3) % 2)) % 2 * 12
  
  iv = (p4 % 17 % 11) >> ((p4 / 4) % 2)
  if(iv > 0) then
    schedule("S1", 0, rand(array(.25, .5)), cpsmidinn(ioct + 60 + iv), 0.25)
  endif
  iv = (p4 % 19 % 13) >> ((p4 / 2) % 3)
  if(iv > 0) then
    schedule("S1", 0, rand(array(.25, .5)), cpsmidinn(ioct + 48 + iv), 0.25)
  endif
  schedule(p1, next_beat(.25), 0, p4 + 1)
endin
schedule("M1", 0, 0)