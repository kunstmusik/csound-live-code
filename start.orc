;; reset_clock()
set_tempo(85)
set_scale("min")

instr P1 

  hexplay("c0020000c002000a", 
     "FM1", p3,
      in_scale(-2, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("0c06", 
      "Sub2", p3,
      in_scale(-1, 4),
      fade_in(10, 128) * ampdbfs(-12))


  hexplay("8200", 
      "Sub2", p3,
      in_scale(-1, 2),
      fade_in(9, 128) * ampdbfs(-12))


  hexplay("dbbd", 
      "Sub2", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("90", 
      "Sub5", p3,
      in_scale(-2, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("ab56", 
      "Sub4", p3,
      in_scale(1, 1),
      fade_in(12, 128) * ampdbfs(-17))

  hexplay("c000", 
      "Plk", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("faaf", 
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("08", 
      "SD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      ampdbfs(-3))

endin
