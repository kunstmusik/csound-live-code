
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
      inScale(48, 5+ int(xosci(beatphase(ibeat, 32), fillarray(0,4,0,5,0,3,0,7)))),
      fadeIn(1, 128) * ampdbfs(xosci(beatphase(ibeat, 64), fillarray(-12, -6))))

  hexplay("fade", ibeat, 
      "S1", p3, 
      inScale(48, 3+ int(xosci(beatphase(ibeat, 32), fillarray(0,4,0,5,0,3,0,7)))),
      fadeIn(2, 128) * ampdbfs(xosci(beatphase(ibeat, 64), fillarray(-12, -6))))

  hexplay("0808080d", ibeat, 
      "Clap", p3, 
      0,
      fadeIn(3, 128) * ampdbfs(-3))

  hexplay("8", ibeat, 
      "Clap", p3, 
      0,
      fadeIn(4, 128) * ampdbfs(-3))

endin

