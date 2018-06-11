;; reset_clock()
set_tempo(132)
set_scale("min")

instr P1 

  hexplay("f",
      "Sub2", p3,
      in_scale(1, 0),
      fade_in(19, 128) * ampdbfs(-30 + 12 * xosci(phsm(8), array(0,1))))

  hexplay("90",
      "Sub1", p3,
      in_scale(0, 2),
      fade_in(21, 128) * ampdbfs(-30 + 12 * xosci(phsm(7), array(0,1))))

  hexplay("da",
      "Sub4", p3,
      in_scale(-1, 4),
      fade_in(22, 128) * ampdbfs(-30 + 12 * xosci(phsm(6), array(0,1))))

  hexplay("f",
      "Sub5", p3,
      in_scale(-2, xosc(phsb(1), array(0,2,4,7))),
      fade_in(23, 128) * ampdbfs(-18))

endin
