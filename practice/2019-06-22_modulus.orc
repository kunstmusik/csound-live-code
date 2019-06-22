; Author: Steven Yi
; Description: Modulus, Modulations
; Date: 2019-06-22

start("ReverbMixer")

instr P1

  idur = xoscm(4, array(12,2,6,3,2,7))
  if(p4 % idur == 0) then
    cause("Organ2", 0, ticks(idur), in_scale(0, (p4 >> (p4 & 7)) % 4), ampdbfs(-18))
  endif

  idur = xoscm(xoscim(8, array(5, 8)), array(13,2,6,3,2,7))
  if(p4 % idur == 0) then
    cause("Organ2", 0, ticks(idur), in_scale(0, 4 + (p4 >> (p4 & 6)) % 4), ampdbfs(-15))
  endif

  idur = xoscm(xoscim(11, array(3, 8)), array(11,2,6,3,2,7))
  if(p4 % idur == 0) then
    cause("Organ2", 0, ticks(idur), in_scale(1, (p4 >> (p4 & 6)) % 4), ampdbfs(-15))
  endif

  chnset(random:i(0.3, 0.7), "Mode1.pan")
  idur = xoscm(xoscim(5.8, array(3, 8)), array(11,2,6,3,2,7))
  if(p4 % idur == 0) then
    cause("Mode1", 0, ticks(idur), in_scale(1, (p4 >> (p4 & 11)) % 11), ampdbfs(-15))
    cause("Mode1", 0, ticks(idur), in_scale(1, 2 + (p4 >> (p4 & 11)) % 11), ampdbfs(-18))
  endif

endin
