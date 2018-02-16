set_tempo(120)
set_scale("min")

instr P1 
  ibeat = p4

  chnset(xcos(bphs(ibeat, 32)) * 8000 + 12000,
        "Sub2.cut")

  hexplay("a222222aa222222b", 
      "Sub2", p3, 
      in_scale(-1, 3 + int(xlin(bphs(ibeat, 32), 0, 3))),
      fade_in(2, 128) * ampdbfs(xosci(bphs(ibeat, 64), array(-12, -6))))

  hexplay("820008808200088a",
      "Sub1", p3,
      in_scale(1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("9090909f", 
      "FM1", p3, 
      in_scale(-2, 0),
      fade_in(2, 128) * ampdbfs(-12))

  hexplay("0f0e0f0f",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("ff80ff8a", 
      "SD", p3, 
      0,
      fade_in(3, 128) * ampdbfs(-9 + xlin(bphs(ibeat, 8), 0, 3)))

  hexplay("8", 
      "BD", p3, 
      0,
      fade_in(4, 128) * ampdbfs(-3))

endin

