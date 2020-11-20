;; Author: Steven Yi
;; Date: 2020.11.19
;; Description: Interlocking Rhythm, FM+Filter+Resonator

start("ReverbMixer")

instr Syn1
  iamp = p5
  ifreq = p4 * random:i(0.999, 1.001)

  asig = foscili(p5, p4, 1, 1, expseg(2, .25, 0.01, 1, 0.01))
  asig += foscili(p5 * ampdbfs(-15) * expon(1, 1, 0.001), p4 * 2, 2, 1, expseg(3, 1, 0.01, 1, 0.01))    
  asig += foscili(p5 * ampdbfs(-24) * expon(1, .5, 0.001), p4 * 4, 2, 1, expseg(3, 1, 0.01, 1, 0.01))  
  
  asig *= expseg(0.01, 0.03, 1, p3, 0.001)
  
  ioct = octcps(ifreq)
  asig = K35_lpf(asig, cpsoct(expon(min(14, ioct + 4), p3, ioct)), 2, 1.5)
  asig = K35_hpf(asig, ifreq, 0.5)      
  
  ain = asig * ampdbfs(-60)
  
  a1 = mode(ain, 400, 10)
  a1 += mode(ain, 700, 6)  
  a1 += mode(ain, 1400, 4)    
  
  asig += a1
  
  asig *= linen:a(1, 0, p3, 0.001)
  pan_verb_mix(asig, 0.5, ampdbfs(-12))
endin

instr Syn2
  iamp = p5
  ifreq = p4 * random:i(0.999, 1.001)

  asig = foscili(p5, p4, 1, 1, expseg(2, 1, 0.1, 1, 0.001))
  asig += foscili(p5 * ampdbfs(-18) * expon(1, 1, 0.001), p4 * 4, 1, 1, expseg(2, 1, 0.01, 1, 0.01))    
  asig += foscili(p5 * ampdbfs(-30) * expon(1, .5, 0.001), p4 * 8, 1, 1, expseg(1, 1, 0.01, 1, 0.01))  
  
  asig *= expseg(0.01, 0.02, 1, .03, 0.5, p3 - .34, .4, 0.29, 0.001)
  
  ioct = octcps(ifreq)
  asig = K35_lpf(asig, cpsoct(expseg(min(14, ioct + 5), 1, ioct, 1, ioct)), 1, 1.5)  
  asig = K35_hpf(asig, ifreq, 0.5)    
  
  ain = asig * ampdbfs(-60)
  
  a1 = mode(ain, 500, 20)
  a1 += mode(ain, 900, 10)  
  a1 += mode(ain, 1700, 6)    
  
  asig += a1
  
  asig *= linen:a(1, 0, p3, 0.001)
  pan_verb_mix(asig, 0.5, ampdbfs(-14))
endin

; schedule("Syn2", 0, 1, in_scale(0, 0), ampdbfs(-12))

set_tempo(60)

instr P1
  hexplay("f",
      "Syn1", p3 * 4,
      in_scale(0, cycle(p4, array(0,2,4,7,6,3,4,2))),
      fade_in(5, 128) * ampdbfs(xoscim(8, array(-7, -5))))
  
  hexplay("a2",
      "Syn1", p3 * 4,
      in_scale(0, cycle(p4 / 2 % 17 % 11, array(0,2,4,7,6,3,4,2))),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("94280000",
      "Syn1", p3 * 3,
      in_scale(1, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("f",
      "Syn2", p3 * 2,
      in_scale(0, cycle(p4 % 37 % 11, array(0,7,11,6,5,4))),
      fade_in(8, 128) * ampdbfs(-14))

  hexplay("b",
      "Syn2", p3 * 2,
      in_scale(1, cycle(p4 % 64 % 31, array(0,2,3,4,7,5,3,4))),
      fade_in(9, 128) * ampdbfs(xoscim(8, array(-16, -14))))

endin
