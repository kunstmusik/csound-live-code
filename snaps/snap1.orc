;; Select this code and press ctrl-e to evaluate
set_tempo(120)
set_scale("min")

instr S1
  asig = vco2(ampdbfs(-12), p4) 
  asig += vco2(ampdbfs(-12), p4 * 1.01, 10) 
  asig += vco2(ampdbfs(-12), p4 * 2, 10) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
	outc(asig, asig)
endin

instr S2
  asig = foscili(p5, p4, 1, 1, linseg(4, 0.1, 1, 0.1, 1))
  asig = declick(asig)
  outc(asig, asig)
endin

instr S3
  p3 = 4
  asig = pinker() * p5
  asig = diode_ladder(asig, expon(6000, p3, 200), 8)
  outc(asig, asig)
endin

instr P1 
  itick = p4
  
  hexplay("2892",
      "S1", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("88a2222a",
      "S2", p3 * 2,
      in_scale(-2, xosci(phs(16), array(0,7))),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("08",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("8", 
      "BD", p3, 
      0,
      fade_in(4, 128) * ampdbfs(-3))

  hexplay("0008000a0008000d",
      "S1", p3 * 0.5,
      in_scale(2, 0),
      fade_in(13, 128) * ampdbfs(-15))

  if(itick % 64 == 0) then
    schedule("S3", 0, 1, 0, ampdbfs(-3))
  endif

endin

