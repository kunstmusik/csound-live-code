
;; File to start in editor 

instr S1
  asig = vco2(ampdbfs(-12), p4) 
  asig = zdf_ladder(asig, expon(10000, p3, 400), 5)
  asig = declick(asig) * p5
	outc(asig, asig)
endin


instr P1 
  ibeat = p4
  
  hexplay("a8ad", ibeat, 
      "S1", p3, 
      inScale(48, 
        xosc(beatphase(ibeat, 16), fillarray(0,0,-3,-1))),
      ampdbfs(-10))

  hexplay("0808080b", ibeat, 
      "Clap", p3, 
      0, 
      ampdbfs(-3))


  ;;hexplay("f", ibeat, 
  ;;    "S1", p3, 
  ;;    inScale(48, int(xosci(beatphase(ibeat, 4), fillarray(0,7)))),
  ;;    ampdbfs(xosci(beatphase(ibeat, 64), fillarray(-12, -6))))

  euclidplay(17, 32, ibeat,
      "S1", p3, 
      inScale(72,xosc(beatphase(ibeat, 8), array(0,2,3,4))),
      0.5)

  euclidplay(13, 32, ibeat,
      "S1", p3, 
      inScale(72,xosc(beatphase(ibeat, 8), array(-2,-1,0,2))),
      0.5)

endin

