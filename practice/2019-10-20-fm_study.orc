;; Author: Steven Yi
;; Description: Small FM synth study
;; Date 2019.10.20

start("ReverbMixer")

xchnset("Reverb.fb", 0.85)

instr Quark
  a1 = foscili(p5, p4, 1, 2, 64) * expseg(0.125, 0.1, 0.001, p3, 0.1)
  a1 += foscili(p5, p4, 1,1, expon(8, p3, 4)) * expon(1, p3, 0.001)
  
  a1 *= oscili(1, p5 * 8) + 0.5
  
  a1 *= linen:a(1, 0.01, p3, 0.01)
  
  pan_verb_mix(a1, 0.5, 0.5)
endin

; schedule("Quark", 0, 2, in_scale(0, 0), ampdbfs(-12))

instr P1
  hexplay("8888aaaa",
      "Quark", p3 * 4,
      in_scale(-1, (p4 << (p4 & 0x7)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("ff0000",
      "Quark", p3 * 4,
      in_scale(0, (p4 << (p4 & 0x7)) % 11),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f0000",
      "Quark", p3 * 4,
      in_scale(0, 2 + (p4 << (p4 & 0x7)) % 11),
      fade_in(6, 128) * ampdbfs(-12))


endin
