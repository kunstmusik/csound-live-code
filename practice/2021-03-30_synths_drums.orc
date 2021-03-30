;; Author: Steven Yi
;; Date: 2021-03-30
;; Description: Synths/Drums

start("ReverbMixer")

instr S1
  
  asig = vco2(p5, p4 * expon(1.05, p3, 1), 12)
  asig += vco2(p5, p4, 10)
  
  asig = zdf_ladder(asig, cpsoct(linseg:a(13, .5, 3.5, p3, 3)), 10)
  
  asig *= linen:a(3, .015, p3, .08)  
  asig = clip(asig, 0, .95)
  asig *= 0.3
  pan_verb_mix(asig, 0.5, 0.05)
endin

instr S2
  
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 2)
  
  ioct = octcps(p4)
  
  asig = zdf_ladder(asig, cpsoct(linseg:a(ioct + .01, .03, min(14.2, ioct + 4), .5, ioct /2 , p3, ioct/2)), 12)
  
  asig *= linen:a(3, .015, p3, .08)  
  asig = clip(asig, 0, .95)
  asig *= 0.3
  pan_verb_mix(asig, 0.5, 0.3)
endin

set_tempo(128)

instr P1
  
  hexplay("c0",
      "S1", p3 * 2,
      in_scale(2, 4),
      fade_in(6, 128) * ampdbfs(xlin(phsm(8), -12, -30)))

  hexplay("ffc000",
      "S1", p3,
      in_scale(1, cycle(p4 % 128 %77 % 61 % 37 % 11 % 5, array(0,4,2,3,1))),
      fade_in(5, 128) * ampdbfs(xoscim(8, array(-20, -14))))
  
  hexplay("3fec0000",
      "S1", p3,
      in_scale(1, cycle(4 + p4 % 128 % 83 % 61 % 37 % 11 % 5, array(0,4,2,3,1))),
      fade_in(5, 128) * ampdbfs(xoscim(8, array(-20, -14))))
  
  hexplay("fffe",
      "S1", p3,
      in_scale(cycle(p4 % 77 % 17 % 11, array(-2,1,0)), ((p4 >> 2 # p4 & 7) % 11) + xoscb(2, array(0,4,2)) + xoscb(3.5, array(0, 2,1))),
      fade_in(5, 128) * ampdbfs(xoscim(8, array(-18, -12))))
  
  hexplay("a22222222",
      "S2", p3,
      in_scale(0, ((p4 >> 2 # p4 & 7) % 11) + xoscb(2, array(0,4,2)) + xoscb(3.5, array(0, 2,1))),
      fade_in(7, 128) * ampdbfs(-16))

  hexplay("92",
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("08",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("2",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))


endin
