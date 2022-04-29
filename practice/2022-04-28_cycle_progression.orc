;; Author: Steven Yi
;; Date: 2022-04-28
;; Description: Cycle Progression
start("ReverbMixer")

instr X1
  asig = vco2(p5, p4)
  asig += vco2(p5 * ampdbfs(-12), p4 * 2)  
  
  asig = zdf_ladder(asig, cpsoct(line(13, p3, 7)), 0.25)
  
  asig *= linen:a(.5,0,p3, .01)
  
  pan_verb_mix(asig, 0.5, .4)
  
endin

instr X2
  asig = vco2(p5, p4, 10)
  asig += vco2(p5 * ampdbfs(-12), p4 * 2)  
  
  asig = zdf_ladder(asig, cpsoct(line(13, p3, 5)), 3)
  
  asig *= linen:a(.5,0,p3, .01)
  
  pan_verb_mix(asig, 0.5, .4)
  
endin

instr P1
  
  ih = cycle(p4 / 4 % 64 % 17, array(0,1,2,3))
  ih *= cycle(p4 % 128 % 41, array(1,1,1,0,0,2,1,0,1))
  
  hexplay("d000",
      "X1", p3,
      in_scale(-1, ih),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("b034810c",
      "X1", p3,
      in_scale(1, ih),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("f",
      "X1", p3,
      in_scale(0, ih + cycle(p4 % 64 % 17 % 7, array(0,2,4,7,11))),
      fade_in(8, 128) * ampdbfs(-14))
  
  hexplay("92",
      "X1", p3 * 2,
      in_scale(-2, ih),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("8222",
      "X2", p3,
      in_scale(1, ih + cycle(p4 % 128 % 47 % 31 % 11, array(0,4,2,3,1,4))),
      fade_in(9, 128) * ampdbfs(xoscim(8, array(-18, -12))))
  
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("08",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))
  
  hexplay("f",
      "CHH", p3,
      in_scale(-1, 0),
      fade_out(12, 128) * ampdbfs(-12))

  
endin