set_tempo(112) 
set_scale("maj")

instr S1
  asig = vco2(ampdbfs(-12), p4) 
  asig += vco2(ampdbfs(-12), p4 * 1.01, 10) 
  asig += vco2(ampdbfs(-12), p4 * 2, 10) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
	outc(asig, asig)
endin

instr S2
  asig = foscili(p5, p4, 1, 1, expon(1, p3, 0.25))
  asig = declick(asig) * expsegr(1, p3, 1, 0.1, 0.001) * 0.35
 outc(asig, asig)
endin

instr P1 
  ibeat = p4

  if(hexbeat("888a888f", ibeat) == 1) then
    ipch = xosci(phs(32), array(0, 5, 0, 4, 0, 7, 0, 11))
    ipch += xosc(phs(64), array(0, 0, 2, 3))
    ipch += xosc(phs(128), array(0, 0, 0, 2))
    
    schedule("S2", 0, p3, 
      in_scale(-1, ipch),
      fade_in(6, 128) * ampdbfs(-18))
    schedule("S2", 0, p3, 
      in_scale(-1, ipch + 2),
      fade_in(6, 128) * ampdbfs(-18))
    schedule("S2", 0, p3, 
      in_scale(-1, ipch + 4),
      fade_in(6, 128) * ampdbfs(-18))
    schedule("S2", 0, p3, 
      in_scale(-1, ipch + 6),
      fade_in(6, 128) * ampdbfs(-18))
    schedule("S2", 0, p3, 
      in_scale(-1, ipch + 8),
      fade_in(6, 128) * ampdbfs(-18))
  endif
  
  hexplay("0808080a",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-9)) 

endin

