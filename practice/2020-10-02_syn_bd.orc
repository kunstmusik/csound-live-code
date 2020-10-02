;; Author: Steven Yi
;; Date: 2020.10.02
;; Description: Practice with synth bass drum design

start("ReverbMixer")

instr SynBD
  p3 = .125
  asig = vco2(1, 100)
  asig = zdf_ladder(asig, cpsoct(linseg:a(10, .02, 7, .105, 4.5)), 22)

  asig += oscili:a(1, 60) * expseg:a(1, .125, .001)
  
;   anoi = random:a(-1, 1)
;   anoi = zdf_2pole(anoi, 4000, 10, 3)
;   anoi *= expon:a(1, .03, .001)

;   asig += anoi
  
  asig *= linen:a(1, 0.0012, p3, .02)
  
  asig *= p5 + .2
  
  pan_verb_mix(asig, 0.5, 0.025)
endin

xchnset("Sub2.cut", 1000)

xchnset("Sub1.rvb", 0.5)
xchnset("Sub2.rvb", 0.5)

instr P1
  
  xchnset("Sub2.cut", 8000 + xsin(phsm(8), 2000, 5000))
  
  hexplay("f0ec",
      "Sub2", p3,
      in_scale(0, ((p4 <<2) >> (p4 & 0x3))  %  17 % 7),
      fade_in(8, 128) * ampdbfs(-15))
  
  hexplay("c000cc00",
      "Sub1", p3 * .7,
      in_scale(3, 0),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("80809280",
      "SynBD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-9))

endin
