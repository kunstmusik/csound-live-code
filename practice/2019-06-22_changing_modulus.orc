; Author: Steven Yi
; Description: Changing Modulus
; Date: 2019-06-21

start("ReverbMixer")

set_tempo(108)

instr P1


  if(p4 % xoscm(8, array(32,16,8,8)) == 0) then
    cause("Organ2", 0, measures(2), in_scale(0, rand(array(0,2,4,6))), ampdbfs(-9))
  endif

  if(p4 % xoscm(8, array(16,7,3,5,2)) == 0) then
    cause("Organ2", 0, measures(2), in_scale(1, rand(array(0,2,4,6))), ampdbfs(-9))
  endif

  if(p4 % xoscm(8, array(5,7,13,2)) == 0) then
    cause("Organ2", 0, measures(2), in_scale(2, rand(array(0,2,4,6))), ampdbfs(-9))
  endif

  if(p4 % xoscm(5, array(11,5,7,13,2)) == 0) then
    cause("Organ2", 0, measures(1), in_scale(1, 4 + rand(array(0,2,4,6))), ampdbfs(-9))
  endif

  if(p4 % xoscm(3, array(11,5,7,13,2)) == 0) then
    cause("Organ2", 0, beats(1), in_scale(2, rand(array(0,2,4,6))), ampdbfs(-12))
  endif


endin
