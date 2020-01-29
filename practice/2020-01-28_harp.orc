;; Author: Steven Yi
;; Description: Synth Harp exploration
;; Date: 2020.01.28

start("ReverbMixer")

xchnset("Reverb.fb", 0.82)
set_tempo(72)

instr Harp
  
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 0.9993423423)
  asig += vco2(p5, p4 * 1.00093029423048) 
  
  ioct = octcps(p4)
  
  asig = zdf_ladder(asig, cpsoct(linseg:a(limit(ioct + 4, 0, 14), 0.015, ioct + 2, 0.2, ioct)), 0.5)
  asig = zdf_2pole(asig, p4 * 0.5, 0.5, 1)    
  
  asig *= linen:a(1, 0.01, p3, 0.01)
  
  pan_verb_mix(asig, 0.5, 0.3)
  
endin


instr P1
  hexplay("8088800000000000",
      "Harp", p3 * 1.7,
      in_scale(0, (p4 # (p4 << 1)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("8088800000000",
      "Harp", p3 * 1.7,
      in_scale(0, 2 + (p4 # (p4 << 1)) % 11),
      fade_in(5, 128) * ampdbfs(-12))

   hexplay("a80000000000",
      "Harp", p3 * 1.7,
      in_scale(0, 4 + (p4 # (p4 << 1)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
   hexplay("fc0000000",
      "Harp", p3 * 1.7,
      in_scale(0, -1 + (p4 # (p4 << 1)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
   hexplay("03000000",
      "Harp", p3 * 1.7,
      in_scale(1, 3 + (p4 | (p4 << 2)) % 11),
      fade_in(5, 128) * ampdbfs(-12))

   hexplay("f000",
      "Harp", p3 * 1.7,
      in_scale(-1, 0 + (p4 # (p4 << 2)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
endin
