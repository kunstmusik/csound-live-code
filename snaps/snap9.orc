;; reset_clock()
set_tempo(124)
set_scale("min")

instr P1 

  hexplay("9000", 
      "Sub2", p3,
      in_scale(-2, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("20", 
      "Sub4", p3,
      in_scale(-2, 0),
      fade_in(5, 128) * ampdbfs(-18))

  hexplay("c0000000", 
      "Noi", p3,
      in_scale(2, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("a280", 
      "Plk", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("82082082", 
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("2", 
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("08", 
      "SD", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      ampdbfs(-3))

endin
