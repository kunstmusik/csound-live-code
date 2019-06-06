; Author: Steven Yi 
; Title: Rhythms
; Date: 2019-06-05

start("ReverbMixer")


chnset(0.6, "Sub1.pan")
chnset(0.45, "Mode1.pan")

instr P1
  hexplay("a",
      "Organ2", p3,
      in_scale(-1, xoscb(2, array(2,3,1,2)) + xoscb(3.7, array(0,4))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f800",
      "Organ2", p3,
      in_scale(-1, xoscb(1, array(2,3,1,2)) + xoscb(1.7, array(0,4))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f",
      "Organ2", p3,
      in_scale(0, 4 + xoscb(2, array(2,3,1,2)) + xoscb(3.7, array(0,4))),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.6))
  
  hexplay("9000", 
      "Organ2", p3 * (1 + p4 % 4),
      in_scale(1, 4 + xoscb(2, array(2,3,1,2)) + xoscb(3.7, array(0,4))),
      fade_in(5, 128) * ampdbfs(-9))

  hexplay("d800", 
      "Mode1", p3 * (1 + p4 % 4),
      in_scale(1, 4 + xoscb(2, array(2,3,1,2)) + xoscb(3.7, array(0,4))),
      fade_in(5, 128) * ampdbfs(-9))

  hexplay("d80", 
      "Mode1", p3 * (1 + p4 % 4),
      in_scale(1, 8 + xoscb(2, array(2,3,1,2)) + xoscb(3.7, array(0,4))),
      fade_in(5, 128) * ampdbfs(-9))

  hexplay("db", 
      "Mode1", p3 * (1 + p4 % 4),
      in_scale(0, 6 + xoscb(2, array(2,3,1,2)) + xoscb(3.7, array(0,4))),
      fade_in(5, 128) * ampdbfs(-9))

  hexplay("a", 
      "Mode1", p3,
      in_scale(0, xoscm(16, array(0,1,2,3))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("febdafedfdfbddf", 
      "Sub1", p3,
      in_scale(1, xoscb(1, array(0,2,1,3)) + xoscb(2.95, array(0,4,7))),
      fade_in(7, 128) * ampdbfs(-6) * choose(0.7))

  hexplay("d0000000", 
      "Sub7", p3 * (1 + hexbeat("1") * 16),
      in_scale(0, xoscm(16, array(0,1,2,3))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("00d00000", 
      "Sub7", p3 * (1 + hexbeat("1") * 16),
      in_scale(0, 4 + xoscm(16, array(0,1,2,3))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("000d0000", 
      "Sub7", p3 * (1 + hexbeat("1") * 16),
      in_scale(0, 8 + xoscm(16, array(0,1,2,3))),
      fade_in(6, 128) * ampdbfs(-12))

endin
