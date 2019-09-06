start("ReverbMixer")

instr S1
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 0.99997)
  asig += vco2(p5 * 0.25, p4 * 2.0003, 10)
  
  asig = zdf_ladder(asig, expon(xoscim(8, array(1000, 10000)), p3, 200), 2)
  
  asig *= expon(1, p3, 0.1)
  asig = declick(asig)
  
  pan_verb_mix(asig, 0.5, 0.6)
endin

instr P1
  hexplay("fe00",
      "S1", p3,
      in_scale(-1, p4 % 4 * 2),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f",
      "S1", p3,
      in_scale(-1, xoscim(8, array(4, 4, 3, 2)) + p4 % 4 * 2),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f",
      "S1", p3,
      in_scale(0, p4  % 6 * 2),
      fade_in(7, 128) * ampdbfs(-12))

endin
