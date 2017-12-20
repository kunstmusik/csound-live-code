set_tempo(85)

instr P1 
  ibeat = p4
  
  hexplay("ffe00000", ibeat,
      "FM1", p3,
      in_scale(-2, 0),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("8208820a", ibeat,
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))
  
  hexplay("0000000b", ibeat,
      "Rimshot", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))
  
  hexplay("8000", ibeat,
      "OHH", p3,
      in_scale(-1, 0),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("7fff3fff", ibeat,
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("0808080c", ibeat,
      "SD", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("8", ibeat, 
      "BD", p3, 
      0,
      fade_in(4, 128) * ampdbfs(-3))

endin


