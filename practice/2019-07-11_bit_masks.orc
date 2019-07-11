; Author: Steven Yi
; Description: Further studies of bit mask relationships
; Date: 2019-07-11

start("ReverbMixer")

set_tempo(96)

chnset(0.5, "Organ1.rvb")
chnset(0.5, "Organ2.rvb")

gicount = 0

instr P1
  hexplay("a000a002", 
     "Organ2", p3,
     in_scale(-1, xoscb(1, array(0,1))),
     fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ1", p3 * 2,
      in_scale(-1, xoscm(1, array(4,3,rand(array(0,1)),2,0,1,-3,-2))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("90000000", 
      "Sub5", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-15))

  if( (p4 >> (p4 & 0x9)) & 2 == 2) then
      schedule("Organ1", 0, p3,
        in_scale(0, (p4 >> (p4 & 0x7)) % 8),
        fade_in(8, 128) * ampdbfs(-15))
  endif

  ;; related bit mask to & 2, will play a subset of times to & 2
  if( (p4 >> (p4 & 0x9)) & 3 == 3) then
      schedule("Organ1", 0, p3,
        in_scale(0, 2 + (p4 >> (p4 & 0x7)) % 8),
        fade_in(8, 128) * ampdbfs(-15))
  endif

  if( (p4 >> (p4 & 0x5)) & 2 == 2) then
      schedule("Organ1", 0, p3,
        in_scale(1, 2 + (p4 >> (p4 & 0x7)) % 8),
        fade_in(8, 128) * ampdbfs(-18))
  endif

  ;; related bit mask to & 2, will play a subset of times to & 2
  if( (p4 >> (p4 & 0x5)) & 3 == 3) then
      schedule("Organ1", 0, p3,
        in_scale(1, 2 + (p4 >> (p4 & 0x7)) % 8),
        fade_in(8, 128) * ampdbfs(-18))
  endif

  if(gicount <= 0) then
    gicount = rand(array(4,6,8,12)) 
    schedule("VoxHumana", 0, ticks(gicount), in_scale(1, 2 + ((p4 >> (p4 & 0x5)) & 8)), ampdbfs(-12))
  else
    gicount -= 1
  endif

endin
