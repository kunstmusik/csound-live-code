;; reset_clock()
set_tempo(120)
set_scale("min")

instr P1 

  hexplay("a222", 
      "Sub4", p3,
      in_scale(-2, xosc(phsb(2), array(3,2))),
      fade_in(22, 128) * ampdbfs(-12))

  hexplay("aa000000", 
      "Sub1", p3,
      in_scale(-2, 0),
      fade_in(22, 128) * ampdbfs(-12))

  hexplay("82082082", 
      "Sub2", p3,
      in_scale(1, 0),
      fade_in(25, 128) * ampdbfs(-12))

  if(p4 % 64 == 1) then
    schedule("Sub3", 0, beats(8),
      in_scale(-2, 0),
      ampdbfs(-12))
  endif

  hexplay("f", 
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(23, 128) * ampdbfs(-12))

  hexplay("08", 
      "SD", p3,
      in_scale(-1, 0),
      fade_in(24, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      ampdbfs(-3))

endin
