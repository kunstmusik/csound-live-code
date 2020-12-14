;; Author: Steven Yi
;; Date: 2020.12.13
;; Description: Organ Memories

start("ReverbMixer")

set_tempo(108)

xchnset("Reverb.fb", 0.85)

xchnset("Organ3.rvb", 0.4)
xchnset("Organ1.rvb", 0.4)

instr P1
  
  hexplay("f",
      "Organ1", p3,
      in_scale(2, cycle(p4 % 13 % 7, array(0,2,4,6,3))),
      fade_in(9, 128) * ampdbfs(-20))
  
  hexplay("f",
      "Organ3", p3,
      in_scale(1, cycle(p4 % 17 % 11, array(0,2,4,3,1,2))),
      fade_in(8, 128) * ampdbfs(-20))
  
  hexplay("f",
      "Organ3", p3,
      in_scale(1, 2 + cycle(p4 % 23 % 13, array(0,2,4,3,1,2))),
      fade_in(8, 128) * ampdbfs(-28))
  
  hexplay("8",
      "Organ3", beats(cycle(p4 % 17 % 7, array(1,1,.75))),
      in_scale(-1, cycle(p4 % 31 % 11, array(4,3,2,2,3))),
      fade_in(5, 128) * ampdbfs(-15))
  
  hexplay("80",
  	  "Organ3", beats(cycle(p4 % 17 % 7, array(2,2,2,1))),
      in_scale(0, cycle(p4 % 31 % 11, array(4,3,2,2,3))),
      fade_in(6, 128) * ampdbfs(-15))
  
  hexplay("8000",
  	  "Organ3", beats(cycle(p4 % 17 % 7, array(4,3,4,2,4))),
      in_scale(-2, cycle(p4 % 31 % 11, array(0,4,6,5,2,3))),
      fade_in(7, 128) * ampdbfs(-12))

endin
