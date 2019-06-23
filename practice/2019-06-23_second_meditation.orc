; Author: Steven Yi
; Description: Second Meditation, California
; Date: 2019-06-23

start("ReverbMixer")

set_tempo(96)

instr P1
  hexplay("80000008", 
      "Organ2", beats(xoscm(2, array(7,1))),
      in_scale(-1, (p4 % 32) == 28 ? 1 : 0),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, (p4 >> (p4 & 0xb3)) % 4),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.4))
 
  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, 4 + (p4 >> (p4 & 0x3b)) % 7),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.4))

  hexplay("f", 
      "Organ2", p3,
      in_scale(1, (p4 >> (p4 & 0xe3b)) % 5),
      fade_in(8, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("f", 
      "Organ2", p3,
      in_scale(1, 4 + (p4 >> (p4 & 0xbe3)) % 8),
      fade_in(9, 128) * ampdbfs(-12) * choose(0.2))

  idur = int(xoscim(8, array(11,3,7,2,9)))
  if(p4 % idur == 0) then
    schedule("Mode1", 0, ticks(idur), in_scale(2, (p4 >> (p4 & 0x32)) % 4), ampdbfs(-15))
  endif

endin
