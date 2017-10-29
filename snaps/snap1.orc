;; Select this code and press ctrl-e to evaluate

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
  ibeat = p4
  
  hexplay("2892", ibeat,
      "S1", p3,
      inScale(48, 0),
      fadeIn(10, 128) * ampdbfs(-12))
  
  hexplay("88a2222a", ibeat,
      "S2", p3 * 2,
      inScale(36, xosci(bphs(ibeat, 16), array(0,7))),
      fadeIn(9, 128) * ampdbfs(-12))
  
  hexplay("08", ibeat,
      "Clap", p3,
      inScale(48, 0),
      fadeIn(12, 128) * ampdbfs(-12))

  hexplay("8", ibeat, 
      "BD", p3, 
      0,
      fadeIn(4, 128) * ampdbfs(-3))

  hexplay("0008000a0008000d", ibeat,
      "S1", p3 * 0.5,
      inScale(84, 0),
      fadeIn(13, 128) * ampdbfs(-15))

  if(ibeat % 64 == 0) then
    schedule("S3", 0, 1, 0, ampdbfs(-3))
  endif

endin

