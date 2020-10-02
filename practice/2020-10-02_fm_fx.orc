;; Author: Steven Yi
;; Date: 2020.10.02
;; Description: Experimental FM sound effect used in rhythm

start("ReverbMixer")

;; FM FX
instr S1
  
  istart = random(6.5, 10)
  iend = random(6.5, 10)
  
  kfreq = cpsoct(line(istart, p3, iend)) * semitone(lfo(random:i(0.01, 0.3), 4.7))
  iamp = p5
  
  kmodfreq = kfreq * 1.77
  amod = oscili(kmodfreq * int(lfo:a(4, random:i(.2, 3), 4)  * 1 + 4), kmodfreq)
  amod2 = oscili(kfreq * 8 * expon:a(1.5, p3, .001), kfreq * 8)
  acar = oscili(0.25, kfreq + amod + amod2)
  
;  acar *= oscili(1, 42)
  
  acar *= expon:a(p5, p3, .001)
  ipan = random:i(0,1)
  a1, a2 pan2 acar, line:a(ipan, p3, 1 - ipan)
  out(a1, a2)
  
  reverb_mix(a1, a2, ampdbfs(-12))
endin
xchnset("Reverb.fb", 0.7)
xchnset("Reverb.cut", 13000)

schedule("S1", 0, random:i(.15, 1), 500, random:i(0.3, 0.7))

instr SynBD
  p3 = .125
  asig = vco2(1, p4)
  asig = zdf_ladder(asig, cpsoct(linseg:a(11, .2, 6, .105, 4.5)), 22)
  asig += oscili:a(1, p4 * 1.5) * expseg:a(1, .125, .001)
  anoi = random:a(-1, 1)
  anoi = zdf_2pole(anoi, 4000, 10, 3)
  anoi *= expon:a(1, .03, .001)
  asig += anoi
  asig *= linen:a(1, 0.0012, p3, .02)
  asig *= p5 + .2
  pan_verb_mix(asig, 0.5, 0.025)
endin

xchnset("Organ3.rvb", 0.7)

instr P1
  
  hexplay("f",
      "Organ3", p3,
      in_scale(0, cycle(p4 % 37 % 17 % 11 + xoscm(7, array(0,3,1)), array(0,4,7,3,5,4))),
      fade_in(11, 128) * ampdbfs(-19))
  
  hexplay("f",
      "Bass", p3 * 0.78,
      in_scale(-2, xoscm(1, array(0,4,7,4))),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("a4",
      "SynBD", p3,
      in_scale(0, 0),
      ampdbfs(xoscim(8, array(-12, -9))))
  
  hexplay("f822",
      "S1", random:i(.15, 1),
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

endin
