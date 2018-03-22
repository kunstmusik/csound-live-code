;; reset_clock()
set_tempo(108)
set_scale("min")

instr P1 

  hexplay("a222", 
      "Sub2", p3,
      in_scale(-1, xosc(phsm(4), array(4, 2, 1, 2))),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("e360", 
      "Sub2", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("c0020000c002000a", 
      "FM1", p3,
      in_scale(-2, 0),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("0006", 
      "Plk", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("8808", 
      "Sub4", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("2", 
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("08", 
      "SD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      ampdbfs(-3))

endin
