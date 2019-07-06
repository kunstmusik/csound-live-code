; Author: Steven Yi 
; Description: Organ patterns
; Date: 2019-07-06

start("ReverbMixer")

chnset(0.6, "Sub6.rvb")

instr P1

  hexplay("f", 
      "Organ1", p3,
      in_scale(-1, 4 + (p4 >> (p4 & 0x7)) % 4),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ1", p3,
      in_scale(-2, 4 + (p4 >> (p4 & 0x7)) % 4),
      fade_in(9, 128) * ampdbfs(-9))

  hexplay("f", 
      "Organ1", p3,
      in_scale(0, 2 + (p4 >> (p4 & 0x17)) % 5),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ1", p3,
      in_scale(0, 0 + (p4 >> (p4 & 0x17)) % 5),
      fade_in(10, 128) * ampdbfs(-12) * choose(0.4))

  idur = xoscm(8, array(12,3,6,3,1,2,17)) 
  if(choose(0.2) == 1) then
    schedule("Organ1", 0, ticks(idur), in_scale(2, (p4 >> (p4 & 0x73)) % 4), ampdbfs(-24)) 
  endif

  idur = xoscm(8, array(3,1,2,17,12,3,6))
  if(choose(0.2) == 1) then
    schedule("Organ1", 0, ticks(idur), in_scale(2, 2 + (p4 >> (p4 & 0x73)) % 4), ampdbfs(-24)) 
  endif

  hexplay("80000000", 
      "Organ2", beats(4),
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("80000000", 
      "Organ2", beats(4),
      in_scale(-2, 0),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("c000", 
      "Mode1", p3,
      in_scale(1, 0),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("c000", 
      "SynBrass", p3,
      in_scale(1, 4),
      fade_in(14, 128) * ampdbfs(-12))

  hexplay("8888888800000000", 
      "Sub6", p3,
      in_scale(-1, xoscm(2, array(0,4,7,11,14,18,21,25))),
      fade_in(15, 128) * ampdbfs(xoscim(32, array(-20, -15))))

endin

;chnset(1, "Mix.amp")
;fade_out_mix()
