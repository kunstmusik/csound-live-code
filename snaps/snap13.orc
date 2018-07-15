;; reset_clock()
set_tempo(94)
set_scale("min")

instr P1 

  hexplay("f0",
      "Sub5", p3,
      in_scale(-1, xosc(phsb(1), array(4,4,4,3))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a2a",
      "Sub5", p3,
      in_scale(0, 4),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("90",
      "Sub1", p3,
      in_scale(-2, 0),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub2", p3,
      in_scale(-1, xosci(phsb(2), array(0,10))),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("2a",
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("08",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))
  
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-3))

endin

