start("ReverbMixer")

set_tempo(96)


instr P1
  hexplay("80000088", 
      "Organ2", beats(xoscm(2, array(6,1))),
      in_scale(-1, xoscm(1, array(0,0,1,2))),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(-15) * choose(0.6))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, (p4 >> (p4 & 0xbc)) % 4),
      fade_in(10, 128) * ampdbfs(-12) * choose(0.5))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, 4 + (p4 >> (p4 & 0xcb)) % 7),
      fade_in(11, 128) * ampdbfs(-12) * choose(0.5))

  hexplay("f", 
      "Organ2", p3,
      in_scale(1, (p4 >> (p4 & 0xa3)) % 7),
      fade_in(12, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("f", 
      "Organ2", p3,
      in_scale(0, 4 + (p4 >> (p4 & 0xd5)) % 12),
      fade_in(13, 128) * ampdbfs(-12) * choose(0.1))

  hexplay("80a0", 
      "SynBrass", p3,
      in_scale(1, 2),
      fade_in(14, 128) * ampdbfs(-25))

  idur = int(xoscim(8, array(11,3,7,2,9,4)))
  if(p4 % idur == 0) then
    schedule("Mode1", 0, ticks(idur), in_scale(1, (p4 >> (p4 & 0x3ef)) % 7), ampdbfs(-15))
  endif

  idur = int(xoscim(8, array(7,2,9,4,11,3)))
  if(p4 % idur == 0 && choose(0.5) == 1) then
    schedule("Mode1", 0, ticks(idur), 4 + in_scale(1, (p4 >> (p4 & 0x3ef)) % 7), ampdbfs(-15))
  endif


endin
