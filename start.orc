
instr S1
  asig = vco2(ampdbfs(-12), p4) 
  asig += vco2(ampdbfs(-12), p4 * 1.01, 10) 
  asig += vco2(ampdbfs(-12), p4 * 2, 10) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
	outc(asig, asig)
endin

instr P1 
  ibeat = p4

  hexplay("fade", ibeat, 
      "S1", p3,
      in_scale(-1, 5 + int(xosci(bphs(ibeat, 32), array(0,4,0,5,0,3,0,7)))),
      fade_in(1, 128) * ampdbfs(xosci(bphs(ibeat, 64), array(-12, -6))))

  hexplay("fade", ibeat, 
      "S1", p3, 
      in_scale(-1, 3 + int(xosci(bphs(ibeat, 32), array(0,4,0,5,0,3,0,7)))),
      fade_in(2, 128) * ampdbfs(xosci(bphs(ibeat, 64), array(-12, -6))))

  hexplay("0808080d", ibeat, 
      "Clap", p3, 
      0,
      fade_in(3, 128) * ampdbfs(-3))

  hexplay("8", ibeat, 
      "BD", p3, 
      0,
      fade_in(4, 128) * ampdbfs(-3))

endin

