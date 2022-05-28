;; Author: Steven Yi
;; Date: 2022-05-28
;; Description: Synth Rhythm 

start("ReverbMixer")

instr M3
  
  kfreq = p4 * semitone(lfo(.35, .35))
  
  asig = vco2(p5, kfreq)
  asig += vco2(p5, kfreq * 2, 12)
  asig += vco2(p5 * .25, kfreq * 1.5, 4, .37)
  asig *= .7
  
  asig = zdf_ladder(asig, cpsoct(linseg:a(8, .02, 13.5, .5, 5, p3, 5)), 0.5)
  
  asig *= linen:a(1, 0, p3, .01)
;   asig *= oscili(.5, kfreq) + .5
  
  pan_verb_mix(asig, 0.5, 0.2)
  
endin


instr P1
  hexplay("8c3faaaa",
      "M3", p3 * 2,
      in_scale(-1, cycle(p4, array(0,3,4,5,1))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("8ac3afaa",
      "M3", p3 * 2,
      in_scale(1, cycle(p4, array(0,3,4,5,1))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("800000000000",
      "M3", p3 * 4,
      in_scale(2, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("a20",
      "M3", p3,
      in_scale(1, 6),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("c00d0000",
      "M3", p3,
      in_scale(1, 4),
      fade_in(7, 128) * ampdbfs(-12))

  
endin