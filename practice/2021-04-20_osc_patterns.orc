;; Author: Steven Yi
;; Date: 2021-04-20
;; Description: Oscillator Rhythms 

start("ReverbMixer")

instr S1
  ifreq = p4
  iamp = p5
  
  asig = vco2(1, ifreq)
  asig += vco2(1, ifreq * semitone(oscili:k(random:i(-.1, .1), random:i(.3, .5))))
  asig += vco2(1, ifreq * semitone(oscili:k(random:i(-.1, .1), random:i(.3, .5))))  
  asig += vco2(.5, 2 * ifreq * semitone(oscili:k(random:i(-.1, .1), random:i(.3, .5))))  
  asig += vco2(.5, 2 * ifreq * semitone(oscili:k(random:i(-.1, .1), random:i(.3, .5))))  
  asig += vco2(.5, 2 * ifreq * semitone(oscili:k(random:i(-.1, .1), random:i(.3, .5))))  
  
  asig *= iamp / 4
  
  asig = zdf_ladder(asig, cpsoct(adsr(0.001, .1, .3, .3) * 4.2 + 10), 0)
  
  asig *= linen:a(1, 0, p3, .01)
  
  pan_verb_mix(asig, 0.5, .2)
endin

instr P1
  hexplay("92",
      "S1", p3,
      in_scale(0, xosc(phsb(4), array(8,6,4, 7,6,4))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f334300034003f",
      "S1", p3,
      in_scale(2, xosc(phsb(2) + phsb(3), array(0,1, 4))),
      fade_in(6, 128) * ampdbfs(-15))

  hexplay("2",
      "S1", p3,
      in_scale(2, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("8800",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

endin
