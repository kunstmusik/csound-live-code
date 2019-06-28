; Author: Steven Yi
; Description: Experiments from practice session
; Date: 2019-06-26

start("ReverbMixer")

set_tempo(72)

instr P1
;   hexplay("a",
;       "Organ2", p3 * 2,
;       in_scale(-1, xoscm(6, array(0,2,3,1)) + xoscb(3, array(0,2,4,7,4,2))),
;       fade_in(5, 128) * ampdbfs(-12))
  
;   hexplay("800000c00c00",
;       "Organ2", p3,
;       in_scale(-1, 4 + xoscm(6, array(0,2,3,1)) + xoscb(3, array(0,2,4,7,4,2))),
;       fade_in(6, 128) * ampdbfs(-12))

;   hexplay("8",
;       "Organ2", p3 * 4,
;       in_scale(0, xoscm(6, array(0,2,3,1)) + xoscb(3, array(0,2,4,7,4,2))),
;       fade_in(7, 128) * ampdbfs(-12))

;   hexplay("f",
;       "Sub5", p3,
;       in_scale(0, xoscm(5, array(0,2,3,1)) + xoscb(3, array(0,2,4,7,4,2))),
;       fade_in(8, 128) * ampdbfs(-12) * choose(0.3))

;   hexplay("f",
;       "Sub5", p3 * 2,
;       in_scale(0, 4 + xoscm(5, array(0,2,3,1)) + xoscb(3, array(0,2,4,7,4,2))),
;       fade_in(9, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("f",
      "Mode1", p3,
      in_scale(1, (p4 >> (p4 & 0xebd)) % 7),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("f",
      "Mode1", p3,
      in_scale(2, (p4 >> (p4 & 0xdeb)) % 7),
      fade_in(10, 128) * ampdbfs(-15))
  
  hexplay("a",
      "Mode1", p3,
      in_scale(1, (p4 >> (p4 & 0xedb)) % 11),
      fade_in(11, 128) * ampdbfs(-12))
  
  hexplay("bd",
      "Mode1", p3,
      in_scale(0, (p4 >> (p4 & 0xbde)) % 11),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("92",
      "Mode1", p3,
      in_scale(0, 4 + (p4 >> (p4 & 0xbde)) % 9),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("8246",
      "Mode1", p3,
      in_scale(0, (p4 >> (p4 & 0xdeb)) % 9),
      fade_in(11, 128) * ampdbfs(-12))
  
  hexplay("8246",
      "Mode1", p3,
      in_scale(-1, (p4 >> (p4 & 0xdb)) % 4),
      fade_in(11, 128) * ampdbfs(-12))

endin
