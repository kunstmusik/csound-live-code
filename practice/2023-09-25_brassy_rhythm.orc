
;; Author: Steven Yi
;; Date: 2023-09-25
;; Description: brassy rhythm 

start("ReverbMixer")
xchnset("Reverb.fb", 0.75)

gi_sine = ftgen(0, 0, 16384, 10, 1)

instr Brassy
  asig = buzz(p5 * 2, p4, sr / 2 / p4, gi_sine) 
  asig += vco2(p5 * .5, p4)
  asig += vco2(p5 * .25, p4 * 2, 2, 0.45)

  asig *= 0.9
 
  ioct = octcps(p4)
  aenv = transegr(0, .0125, 4.2, 1, .25, -4.2, 0.5, .25, -4.2, 0)
  aenv = limit(cpsoct(ioct - 1 + aenv * 6), 20, 18000)

  asig = zdf_2pole(asig, aenv, 0.5)

  pan_verb_mix(asig, 0.5, 0.3)
endin


instr P1

  hexplay("f",
      "Brassy", p3 * 2,
      in_scale(-2, cycle(p4 % 32, array(0,4,2,3,7))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a",
      "Brassy", p3 * 1.5,
      in_scale(1, 1),
      fade_in(5, 128) * ampdbfs(xlin(phsm(8), -14, -36)))

  hexplay("c",
      "Brassy", p3 * 1.5,
      in_scale(1, 3),
      fade_in(5, 128) * ampdbfs(xlin(phsm(6), -16, -36)))

  hexplay("d",
      "Brassy", p3 * 1.5,
      in_scale(1, 6),
      fade_in(5, 128) * ampdbfs(xlin(phsm(12), -16, -36)))
  
  hexplay("f",
      "Brassy", p3 * 2,
      in_scale(-1, 4 + cycle(p4 % 117 % 71 % 64 % 37, array(0,4,2,3,7))),
      fade_in(5, 128) * ampdbfs(-12))

endin