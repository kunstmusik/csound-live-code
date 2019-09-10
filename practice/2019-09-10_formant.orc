;; Author: Steven Yi
;; Description: Practice with Form1
;; Date: 2019-09-10

start("ReverbMixer")

xchnset("rvb.default", 0.5)

instr P1

  hexplay("f", 
      "Form1", p3,
      in_scale(0, cycle(p4 % 31 % 17 % 7, array(0,2,4,3,6,5,1))),
      fade_in(5, 128) * ampdbfs(-18))

  hexplay("f", 
      "Squine1", p3,
      in_scale(-2, cycle(p4 % 33 % 17 % 7, array(0,2,4,3,6,5,1))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f", 
      "Squine1", p3,
      in_scale(-1, 2 + cycle(p4 % 37 % 17 % 7, array(0,2,4,3,6,5,1))),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub7", p3,
      in_scale(1, p4 % 31 % 17 % 8),
      fade_in(7, 128) * ampdbfs(-14))

  hexplay("f", 
      "Sub6", p3,
      in_scale(1, 2 + p4 % 37 % 13 % 7),
      fade_in(9, 128) * ampdbfs(-14))

  hexplay("8000", 
      "Mode1", p3,
      in_scale(1, 2),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 6),
      fade_in(11, 128) * ampdbfs(xoscim(8, array(-20, -12))))

endin
