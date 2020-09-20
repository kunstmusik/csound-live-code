;; Author: Steven Yi
;; Date: 2020.09.20
;; Description: Groove

start("ReverbMixer")

instr B1
  ifreq = p4
  iamp = p5
  
  asig = vco2(1, ifreq, 2, 0.4)
  asig += vco2(.5, ifreq * 2, 2, 0.15)
  
  ioct = octcps(ifreq)
  print  ioct
  asig = zdf_ladder(asig, cpsoct(min(14, linseg(ioct + 6, .1, ioct + 2, p3 - .2, ioct))), .5)
  
  asig *= linen:a(p5, .01, p3, .05)
    
  pan_verb_mix(asig, 0.5, 0.2)
endin

instr B2
  ifreq = p4
  iamp = p5
  
  asig = vco2(1, ifreq)
  asig += vco2(.5, ifreq * 0.999234234)  
  asig += vco2(.5, ifreq * 2, 2, 0.3)
  
  ioct = octcps(ifreq)
  
  asig = zdf_ladder(asig, cpsoct(min(14, linseg(ioct + 5.5, .1, ioct + 2, p3 - .2, ioct))), .5)
  
  asig *= linen:a(p5 * 0.5, .01, p3, .05)
    
  pan_verb_mix(asig, 0.5, 0.1)
endin
  
cause("B1", 0, 2, cpspch(6.00), ampdbfs(-12))

instr P1
  hexplay("800f",
      "B1", p3,
      in_scale(-2, xoscb(1, array(0,1))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("2",
      "B1", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-18))
  
  hexplay("2aaa2222",
      "B2", p3,
      in_scale(-1, xoscm(1, array(2,3))),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("a0000000",
      "Sub2", p3,
      in_scale(0, 2),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-6))
  
  hexplay("0008",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("08",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("2",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-12))
  
endin
