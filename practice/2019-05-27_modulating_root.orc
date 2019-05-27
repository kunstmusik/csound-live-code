set_tempo(108)
start("ReverbMixer")
instr P1

  set_root(int(p4 / 4) % 8 * 2 + 60)

  hexplay("f", 
      "Mode1", p3,
      in_scale(-1, xoscb(2, array(0,2,4,7,7,4,2,0))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("9200d200", 
      "ms20_bass", p3 * 3,
      in_scale(-2, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub1", p3,
      in_scale(-1, xoscb(1, array(0,4,7,11))),
      fade_out(7, 128) * ampdbfs(-12))
 
  hexplay("f", 
      "Sub5", p3,
      in_scale(-1, (p4 % 3) * 7 + (p4 % 2) * 4 + hexbeat("f3e3f") * 2),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub6", p3,
      in_scale(0, hexbeat("82") * 7 + hexbeat("423be") * 4 + hexbeat("fedbadad3") * 2),
      fade_in(14, 128) * ampdbfs(-12) * choose(0.3))

  hexplay("f", 
      "SynBrass", p3,
      in_scale(0, 0),
      fade_in(15, 128) * ampdbfs(xoscim(8, array(-18, -14))))

  hexplay("f", 
      "Sub7", p3 * 0.8,
      cpsmidinn(72),
      fade_in(17, 128) * ampdbfs(xoscim(7.9, array(-18, -14))))

endin

