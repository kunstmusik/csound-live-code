
instr S1
  asig = vco2(ampdbfs(-12), p4) 
  asig += vco2(ampdbfs(-12), p4 * 1.01, 10) 
  asig += vco2(ampdbfs(-12), p4 * 2, 10) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
	outc(asig, asig)
endin

instr S2
  asig = pinker() * p5
  asig = zdf_ladder(asig, expon(8000, p3, 200), 5)
  outc(asig, asig)
endin

instr P1 
  ibeat = p4

  hexplay("88a2228a", ibeat, 
      "S1", p3,
      in_scale(2, xlin(bphs(ibeat, 16), 0, 1)),
      fade_in(5, 128) * ampdbfs(xosci(bphs(ibeat, 64), array(-12, -6))))
  
  hexplay("ffe0", ibeat, 
      "S1", p3,
      in_scale(-2, 5 + int(xosc(bphs(ibeat, 8), array(0,0,0,0)))),
      fade_in(5, 128) * ampdbfs(xosci(bphs(ibeat, 64), array(-12, -6))))

  hexplay("f8aeea8f", ibeat, 
      "S1", p3,
      in_scale(0, 5 + int(xlin(bphs(ibeat, 16), 0, 4) + xosc(bphs(ibeat, 4), array(0,3)))),
      fade_in(7, 128) * ampdbfs(xosci(bphs(ibeat, 64), array(-12, -6))))

  hexplay("8000000000000000", ibeat, 
      "S2", p3 * 16,
      0,
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("0808080d", ibeat, 
      "Clap", p3, 
      0,
      fade_in(3, 128) * ampdbfs(-3))

  hexplay("8", ibeat, 
      "BD", p3, 
      0,
      fade_in(4, 128) * ampdbfs(-3))

endin

