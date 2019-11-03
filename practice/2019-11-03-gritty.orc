; Author: Steven Yi
; Description: Synth writing/dance session with bit of grit
; Date: 2019.11.03

start("ReverbMixer")

set_tempo(124)

xchnset("rvb.default", 0.3)
xchnset("drums.rvb.default", 0.3)

instr RM1
  asig = vco2(p5, p4, 10)
  asig *= oscili(1, 40)
  
  asig = tanh(asig)
  
  asig *= linen:a(0.5, 0.025, p3, 0.025)
  
  pan_verb_mix(asig, 0.5, 0.9)
endin

instr FM1
  asig = vco2(p4 * xchan("FM1.index", 2), p4, 10)
  asig = oscili(p5, p4 + asig)
  
  asig *= linen:a(0.5, 0.01, p3, 0.0125)
  pan_verb_mix(asig, 0.5, 0.3)
endin

instr FM2
  asig = vco2(p4 * xchan("FM2.index", 2), p4, 12)
  asig = oscili(p5, p4 + asig)
  
  asig *= linen:a(0.5, 0.01, p3, 0.0125)
  pan_verb_mix(asig, 0.5, 0.3)
endin

gitab1 = ftgen(0, 0, 65536, 10, 2, 0.5, 0.3, 0.4, 0.7, 0.2, 0.3, 0.1, 0.05, 0.015)
instr WT1
  asig = oscili(p5, p4, gitab1)
  asig *= oscili(1, p4)
  
  asig = zdf_ladder(asig, 8000, 0.5)
  
  asig *= linen:a(1, 0.01, p3, 0.0125)
  pan_verb_mix(asig, xchan("WT1.pan", 0.5), 0.3)
endin

instr P1
  
  xchnset("FM1.index", xoscim(2, array(1, 8)))
  xchnset("FM2.index", xoscim(2, array(1, 2)))
  
  hexplay("ff80",
      "FM2", p3,
      in_scale(-1, p4 % 32),
      fade_in(5, 128) * ampdbfs(-16))
  
  hexplay("a",
      "FM1", p3,
      in_scale(-1, p4 / 2 % 16),
      fade_in(7, 128) * ampdbfs(-18))
  
  xchnset("WT1.pan", xoscim(4, array(0.25, 0.75)))
  
  hexplay("f",
      "WT1", p3,
      in_scale(rand(array(-1,0,0,1,1,2)), 0),
      fade_in(8, 128) * ampdbfs(-10))
  
  hexplay("c00000",
      "RM1", p3,
      in_scale(2, 0),
      fade_in(9, 128) * ampdbfs(-21))
  
  hexplay("c0000",
      "RM1", p3,
      in_scale(1, 4),
      fade_in(9, 128) * ampdbfs(-21))
  
  hexplay("3000",
      "RM1", p3,
      in_scale(0, 7),
      fade_in(10, 128) * ampdbfs(-21))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-6))
  
  hexplay("0808080c",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(14, 128) * ampdbfs(-12))

  hexplay("f",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("92000000",
      "Sub1", p3,
      from_root(1, xoscb(2, array(10,6,3))),
      fade_in(13, 128) * ampdbfs(-12))
  
  hexplay("90",
      "Sub6", p3 * xoscb(1, array(2.5,1)),
      in_scale(-2, 0),
      fade_in(15, 128) * ampdbfs(-12))
  
endin

