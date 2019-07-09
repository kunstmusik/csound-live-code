; Author: Steven Yi
; Description: Broken rhythms
; Date: 2019-07-09

start("ReverbMixer")

chnset(0.6, "Sub5.rvb")
chnset(0.6, "Sub6.rvb")

instr R5
  ival = (p4 >> (p4 & 0x7)) % 5
  iamp = -18
  schedule("Organ2", 0, ticks(2), in_scale(-1, ival), ampdbfs(iamp))
  schedule("Organ2", 0, ticks(2), in_scale(-1, ival + 2), ampdbfs(iamp))  
  schedule("Organ2", 0, ticks(2), in_scale(-1, ival + 4), ampdbfs(iamp))  
  
  schedule(p1, next_beat(0.5 * rand(array(1,1,2,2,4,8))), 0, p4 + 1)
endin
schedule("R5", next_measure(), ticks(1))

instr R6
  ival = 4 + (p4 >> (p4 & 0xc)) % 12
  ioct = rand(array(-1,0))
  
  iamp = -15
  schedule("Organ1", 0, ticks(2), in_scale(ioct, ival), ampdbfs(iamp))
  schedule("Organ1", 0, ticks(2), in_scale(ioct, ival + 2), ampdbfs(iamp))  
  schedule("Organ2", 0, ticks(2), in_scale(ioct, ival + 4), ampdbfs(iamp -1))  
  schedule("Organ2", 0, ticks(2), in_scale(ioct, ival + 6), ampdbfs(iamp -2))  
  schedule("Organ2", 0, ticks(2), in_scale(ioct, ival + 8), ampdbfs(iamp -3))    
  
  schedule(p1, next_beat(0.25 * rand(array(1,1,2,2,4,8,16))), 0, p4 + 1)
endin
schedule("R6", next_measure(), ticks(1))

instr R7
  ival = 4 + (p4 >> (p4 & 0x15)) % 4
  ioct = rand(array(-1, 0))
  chnset(random:i(0.2, 0.8), "Sub5.pan")
  schedule("Sub5", 0, ticks(2), in_scale(ioct, ival), ampdbfs(-12))
  
  schedule(p1, next_beat(0.25 * rand(array(1,2,4))), 0, p4 + 1)
endin
schedule("R7", next_measure(), ticks(1))

instr R8
  ival = 2 + (p4 >> (p4 & 0x15)) % 4
  ioct = rand(array(1,2))
  chnset(random:i(0.2, 0.8), "Mode1.pan")
  schedule("Mode1", 0, beats(2), in_scale(ioct, ival), ampdbfs(-12))
  
  schedule(p1, next_beat(rand(array(1,2,4))), 0, p4 + 1)
endin
schedule("R8", next_measure(), ticks(1))

instr R9
  ival = 1 + (p4 >> (p4 & 0x15)) % 4
  ioct = -2 
  idur = 4 / ival 
  
  schedule("Sine", 0, beats(idur * 0.98), in_scale(ioct, ival - 1), ampdbfs(-12))
  schedule("Organ2", 0, beats(idur * 0.98), in_scale(ioct, ival - 1), ampdbfs(-9))
  
  schedule(p1, next_beat(idur), 0, p4 + 1)
endin
schedule("R9", next_measure(), ticks(1))

instr P1
  hexplay("f",
      "Sub6", p3,
      in_scale(-1, xoscb(1, array(0,2,4,7))),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.2))

endin
