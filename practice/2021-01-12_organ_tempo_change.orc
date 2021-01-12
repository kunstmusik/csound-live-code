;; Author: Steven Yi
;; Date: 2021.01.11
;; Description: Organ Rhythm, experiment with synchronized tempo change 

start("ReverbMixer")

xchnset("Organ3.rvb", 0.7)

instr P1

  iv = p4 / 2

;; Synchronizing tempo changes at specific beat 
;   if(iv % 64 == 0) then
;     set_tempo(15)
;   endif

  hexplay("a",
      "Organ3", p3 * 1.9,
      in_scale(0, cycle(iv % 64 % 17, array(0,2,3,1,2,3,4,3))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f",
      "Organ3", p3,
      in_scale(1, cycle(p4 % 17 + xoscm(3, array(0,4,7)), array(0,2,3,1,2,3,4,3))),
      fade_in(6, 128) * ampdbfs(-18))

  hexplay("c000c0c00000",
      "Organ3", p3,
      in_scale(1, 4),
      fade_in(7, 128) * ampdbfs(-12))


endin


