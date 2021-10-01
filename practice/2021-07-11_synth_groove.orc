start("ReverbMixer")

xchnset("Reverb.fb", 0.85)

instr S1
  
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 2 * random:i(1, 1.01), 4, .42)
  asig += vco2(p5, p4 * random:i(1, 1.01), 12)
  
  kcut = xoscim(8, array(8, 11)) + port(oscil:k(8, array(0,1,2,1)), 0.05)
  kcut += linseg:k(0, .02, 1, .05, 0, p3, 0) * 2
  
  asig = zdf_2pole(asig, cpsoct(kcut), xoscim(8, array(.5, 2)))
  
  asig *= linen:a(.25, 0.01, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.4)
  
endin

instr S2
  
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 2, 10)
  
  kcut = 10 + oscil:k(8, array(0,1,2,1))
  kcut += linseg:k(0, .02, 1, .05, 0, p3, 0) * 2
  
  asig = zdf_2pole(asig, cpsoct(kcut), .5)
  
  asig *= linen:a(.25, 0.1, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.2)
  
endin

instr S3
  
  asig = vco2(p5, p4, 10)
  asig += vco2(p5, p4 * 2)
  
  kcut = 10 + port(oscil:k(8, array(0,1,2,1)), 0.05)
  kcut += linseg:k(0, .02, 1, .05, 0, p3, 0) * 2
  
  asig = zdf_2pole(asig, cpsoct(kcut), .5)
  
  asig *= linen:a(.5, 0.01, p3, .01)
  
  pan_verb_mix(asig, 0.5, 0.1)
  
endin

instr P1
  
  iv = xoscm(4, array(0,0,4,5))
  
  hexplay("f000",
      "S1", p3,
      in_scale(-1, xoscb(1, array(0,4,7,11))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("a",
      "S1", p3,
      in_scale(0, xoscb(2, array(0,2,4,5))),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("6a",
      "S1", p3,
      in_scale(2, 0),
      fade_in(7, 128) * ampdbfs(xoscim(16, array(-20, -12))))

  hexplay("f",
      "S1", p3,
      in_scale(1, xoscb(1, array(0,2,4,7))),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("a",
      "S2", p3,
      in_scale(2, cycle(p4, array(0,4,2,7))),
      fade_in(12, 128) * ampdbfs(-12))
  
  hexplay("f",
      "S2", p3,
      in_scale(2, 4),
      fade_in(13, 128) * ampdbfs(xoscim(16, array(-24, -16))))
  
  hexplay("9000",
      "S3", p3,
      in_scale(-2, 0),
      fade_in(14, 128) * ampdbfs(-13))


endin
