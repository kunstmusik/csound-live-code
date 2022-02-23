;; Author: Steven Yi
;; Date: 2022-02-22
;; Description: Wandering...

start("ReverbMixer")

xchnset("SynHarp.rvb", 0.5)
xchnset("Organ3.rvb", 0.9)
xchnset("Sub7.rvb", 0.5)

instr P1

  hexplay("a",
      "Organ3", p3 * xoscim(11, array(1.5, 1.7)),
      in_scale(2, 0),
      fade_in(10, 128) * ampdbfs(-29 + xoscim(7.7, array(0,10))))

  hexplay("f",
      "Bass", p3,
      in_scale(-2, xoscm(4, array(0,3,4,5)) + cycle(p4 % 137 % 77 % 37 % 23, array(4,3,1,2,0,1))),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("0988",
      "Sub7", p3,
      in_scale(1, 4),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("aa2a88a8",
      "SynHarp", p3 * .8,
      in_scale(1, 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f80000000",
      "SynHarp", p3 * .8,
      in_scale(2, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("2",
      "SynHarp", p3,
      in_scale(0, cycle(p4 / 2 % 9 % 5, array(0,1,3,5))),
      fade_in(7, 128) * ampdbfs(-15 + xoscim(8, array(0, 3))))

  hexplay("8",
      "SynHarp", p3,
      in_scale(1, cycle(p4 / 2 % 11 % 5, array(0,1,3,5))),
      fade_in(8, 128) * ampdbfs(-14 + xoscim(7, array(0, 3))))

endin
