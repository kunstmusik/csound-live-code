; Author: Steven Yi
; Title: California, 2019
; Date: 2019-06-23 

start("ReverbMixer")

set_tempo(96)

instr P1
 
  hexplay("8008", 
      "Organ2", beats(xoscm(1, array(3, 0.5))),
      in_scale(-1, xoscm(1, array(4,3))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("8008", 
      "Organ2", beats(xoscm(1, array(3, 0.5))),
      in_scale(0, xoscm(1, array(4,3))),
      fade_in(13, 128) * ampdbfs(xoscim(8, array(-22, -30))))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, (p4 >> (p4 & 0xab)) % 5),
      fade_in(6, 128) * ampdbfs(-15))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, 4 + (p4 >> (p4 & 0xab)) % 5),
      fade_in(7, 128) * ampdbfs(-15) * choose(0.4))

  hexplay("aa00a800", 
      "Organ2", p3,
      in_scale(-2, xoscb(2, array(0,2,4,7))),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("a28", 
      "Organ2", p3,
      in_scale(1, 4),
      fade_in(9, 128) * ampdbfs(-17))

  hexplay("8", 
      "SynBrass", p3,
      in_scale(2, 0),
      fade_in(10, 128) * ampdbfs(xoscim(8, array(-22, -28))))

  hexplay("a", 
      "Sub5", p3,
      in_scale(0, (p4 >> (p4 & 0xba)) % 12),
      fade_in(11, 128) * ampdbfs(-15) * choose(0.5))

  idur = int(xoscim(xoscim(5.5, array(6,8)), array(12,4,3,7,4,9,11)))
  if(p4 % idur == 0) then
      schedule("Organ2", 0, ticks(idur), in_scale(1, (p4 >> (p4 & 0x32)) % 4), ampdbfs(-9))
  endif

  idur = int(xoscim(xoscim(5.5, array(6,8)), array(4,3,9,4,9,11)))
  if(p4 % idur == 0 && choose(0.4) == 1) then
      schedule("Organ2", 0, ticks(idur), in_scale(1, 4 + (p4 >> (p4 & 0x32)) % 4), ampdbfs(-9))
  endif

endin
