;; Author: Steven Yi
;; Description: Rhythmic
;; Date: 2019-10-04 
start("ReverbMixer")

xchnset("rvb.default", 0.4)

instr P1
  
  hexplay("f",
      "Sub1", p3,
      in_scale(-1, cycle(p4 % 31 % 12 % 5, array(0,2,4,7,4))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Sub1", p3,
      in_scale(0, cycle(p4 % 27 % 12 % 5, array(4,2,3,1,0))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub1", p3,
      in_scale(0, cycle(p4 % 26 % 12 % 5, array(0,4,7,11, 14))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("c",
      "Sub4", p3,
      in_scale(2, 4),
      fade_in(8, 128) * ampdbfs(xoscim(8, array(-12, -18))))

  hexplay("f",
      "Sub5", p3,
      in_scale(-2, cycle(p4 % 31 % 12 % 7, array(0,4,7,11,7,4))),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub5", p3,
      in_scale(cycle(p4, array(0,1,2)), cycle(p4 % 33 % 12 % 7, array(0,4,7,11,7,4))),
      fade_in(10, 128) * ampdbfs(-12))


endin
