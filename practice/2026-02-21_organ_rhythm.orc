;; Author: Steven Yi
;; Date: 2026-02-21
;; Description: Organ Rhythm

start("ReverbMixer")
set_tempo(120)
set_scale("min")

instr P1

  hexplay("a",
      "Organ3", p3,
      in_scale(-1, cycle(p4 % 129 % 117 % 37 % 11 / 2, [0,4,2,3])),
      fade_in(5, 128) * ampdbfs(-14))

  hexplay("f",
      "Organ3", p3,
      in_scale(0, cycle(p4 % 129 % 117 % 37 % 11, [0,4,2,3])),
      fade_in(6, 128) * ampdbfs(-15))

  hexplay("e",
       "Organ3", p3,
      in_scale(0, cycle(p4 % 129 % 117 % 37 % 11, [0,4,2,3]) + 4),
      fade_in(7, 128) * ampdbfs(-15))

  hexplay("f",
      "Organ3", p3 * .8,
      in_scale(-2, xoscm(8, [0,4,2,3])),
      fade_in(8, 128) * ampdbfs(-12) * xoscim(2, [0.5,1]))

  hexplay("f",
      "Organ3", p3 * .8,
      in_scale(-1, xoscm(8, [0,4,2,3])),
      fade_in(8, 128) * ampdbfs(-12) * xoscim(3.7, [0.5,1]))

  hexplay("f",
      "Organ3", p3 * .8,
      in_scale(1, xoscm(8, [0,4,2,3])),
      fade_in(8, 128) * ampdbfs(-12) * xlin(phsm(4), 0.15, .5))

  
endin