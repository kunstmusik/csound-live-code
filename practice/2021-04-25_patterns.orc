;; Author: Steven Yi
;; Date: 2021-04-25
;; Description: Oscillator Rhythms 

start("ReverbMixer")

xchnset("Organ3.rvb", 0.7)

instr S1
  asig = vco2(p5, p4)
  
  kcut = xchan("cut", 4000)
  kcut = min(18000, cpsoct(adsr(.5, 1, .25, 0.1) * 4 + octcps(p4)))
  
  asig = zdf_2pole(asig, kcut, 3)
  
  asig *= linen:a(1, 0, p3, .001)
  
  pan_verb_mix(asig, 0.3, 0.3)
endin

instr S2
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 2 * semitone(random:i(-.1, .1)))  
  
  kcut = xchan("cut", 4000)
  kcut = min(18000, cpsoct(adsr(.01, 1, .25, 0.1) * 4 + octcps(p4)))
  
  asig = zdf_2pole(asig, kcut, 3)
  
  asig *= linen:a(.5, 0, p3, .001)
  
  pan_verb_mix(asig, 0.5, 0.3)
endin

instr S3
  asig = vco2(p5, p4, 10)
  
  kcut = min(18000, cpsoct(adsr(.01, .3, .25, 0.1) * 6 + octcps(p4)) )
  
  asig = zdf_2pole(asig, kcut, 5)
  
  asig *= linen:a(1, 0, p3, .001)
  
  pan_verb_mix(asig, 0.5, 0.5)
endin

instr P1
  
  hexplay("f",
      "S3", p3,
      in_scale(1, cycle(p4 % 128 % 63 % 31 % 17, array(0,2,4,7))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("92",
      "S3", p3 * 2,
      in_scale(-2, 0),
      fade_in(5, 128) * ampdbfs(xoscim(8, array(-14, -7))))

  hexplay("faaa",
      "S2", p3 * .9,
      in_scale(0, xosc(phsb(4) + phsb(1.5), array(0,4,3,1))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("a",
      "S2", p3,
      in_scale(1, xosc(phsb(4) * phsb(1.1) + phsb(2.7), array(0,0,0,1))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("a222",
      "S2", p3,
      in_scale(2, xosc(phsb(1), array(0,4,2,3,2,5,3,4))),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("f",
      "S2", p3,
      in_scale(-1, xosc(phsb(2), array(0,4,7,11,7,4))),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ3", p3,
      in_scale(2, cycle(p4, array(0,4,7,4))),
      fade_in(7, 128) * ampdbfs(-12))


endin
