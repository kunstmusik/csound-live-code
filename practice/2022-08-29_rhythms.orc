;; Author: Steven Yi
;; Date: 2022-08-29
;; Description: Synth Rhythm 

start("ReverbMixer")

instr SynBass2
  asig = vco2(p5, p4, 2, .377)
  asig += vco2(p5, p4 * 2, 2, .412)
  
  ioct = octcps(p4)
  acut_env = transegr:a(0, .002, 0, 1, .2, -4.2, .3, .25, -4.2, 0) * 5.5
  
  acut_env = limit:a(cpsoct(acut_env - 2 + ioct), 20, 20000)
  asig = zdf_2pole(asig, acut_env, .5)
  
  asig *= transegr:a(1, .1, 0, 1, .125, -4.2, 0, .015, -4.2, 0)
  
  pan_verb_mix(asig, 0.5, 0.2)
  
endin

instr P1
  hexplay("a",
      "SynBass2", p3,
      in_scale(-2 + p4 /2 % 2, xoscm(1, array(0,2,3,4))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f",
      "SynBass2", p3,
      in_scale(0, cycle(p4, array(0,4,2,7,11,9, 11))),
      fade_in(6, 128) * ampdbfs(-21))
  
  hexplay("f",
      "SynBass2", p3,
      in_scale(1, cycle(p4, array(0,4,2,7,11,9, 11))),
      fade_in(6, 128) * ampdbfs(-21) * cycle(p4 % 117 % 37, array(0,1,0,0,1,0)))

  
  hexplay("f",
      "SynBass2", p3,
      in_scale(0, 2 + cycle(p4 % 17 % 11, array(0,4,2,7))),
      fade_in(6, 128) * ampdbfs(-21))
  
  hexplay("f",
      "SynBass2", p3,
      in_scale(1, 4 + cycle(p4 % 37 % 17 % 11, array(0,4,2,7))),
      fade_in(6, 128) * ampdbfs(-24))
  
  hexplay("f",
      "SynBass2", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(xoscb(7, array(1,0,1,1,0)) * 3 + xlin(phsm(8), -12, -22)))

endin