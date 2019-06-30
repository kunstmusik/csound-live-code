; Author: Steven Yi
; Description: Duration Sequence Practice
; Date: 2019-06-29

start("ReverbMixer")

instr P1
  idur = dur_seq(array(2,2,1,-1,-1,1,-2,1,1,3,-7))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(0, (p4 >> (p4 & 0x17)) % 7), ampdbfs(-12))
  endif

  idur = dur_seq(array(-1,-1,1,-2,1,1,3,-7,2,2,1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur),  in_scale(0, 4 + (p4 >> (p4 & 0x17)) % 4), ampdbfs(-12))
  endif

  idur = dur_seq(array(-2,1,1,3,-7,2,2,1,-1,-1,1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur),  in_scale(1, (p4 >> (p4 & 0x71)) % 7), ampdbfs(-12))
  endif

  idur = dur_seq(array(8,-4, 12,-4,2))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur),  in_scale(-1, (p4 >> (p4 & 0x3b)) % 4), ampdbfs(-12))
    schedule("Organ2", 0, ticks(idur),  in_scale(-2, (p4 >> (p4 & 0x3b)) % 4), ampdbfs(-12))
  endif

  idur = dur_seq(array(8,-4, 12,-4,2,2,-4,12,-4,8))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur),  in_scale(1, (p4 >> (p4 & 0xb3)) % 7), ampdbfs(-9))
    schedule("Organ2", 0, ticks(idur),  in_scale(1, 2 + (p4 >> (p4 & 0xb3)) % 7), ampdbfs(-9))
  endif

  if((p4 >> (p4 & 0xc3)) & 1 == 1) then
    schedule("Mode1", 0, beats(1),  in_scale(1, (p4 >> (p4 & 0x27)) % 4), ampdbfs(-9))
    schedule("Mode1", 0, beats(1),  in_scale(1, 2 + (p4 >> (p4 & 0x27)) % 4), ampdbfs(-9))
  endif

  hexplay("fc000000", 
      "Mode1", p3 * 6,
      in_scale(0, xoscb(2, array(0,4,7,11,14,18,18,18))),
      fade_in(5, 128) * ampdbfs(-9))
  
  if((p4 >> (p4 & 0x14c)) & 1 == 1) then
    schedule("Sub2", 0, p3,  in_scale(1, (p4 >> (p4 & 0x72)) % 7), ampdbfs(-9))
    schedule("Sub2", 0, p3,  in_scale(1, 2 + (p4 >> (p4 & 0x72)) % 7), ampdbfs(-9))
  endif

  hexplay("f", 
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))


endin
