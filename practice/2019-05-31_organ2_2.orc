; Author: Steven Yi
; Title: Organ2 - Second Practice 
; Date: 2019.05.31
start("ReverbMixer")
chnset(0.4, "Plk.rvb")

instr P1

  hexplay("f", 
      "Organ2", p3 * 1.7,
      in_scale(-1, xoscb(2.7, array(0,2,4,2)) + xoscb(1, array(0,4,7,11))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ2", p3 * 1.7,
      in_scale(0, 2 + xoscb(2.7, array(0,2,4,2)) + xoscb(1, array(0,4,7,11))),
      fade_read(5) * ampdbfs(-18) * choose(0.5))

  hexplay("8000", 
      "Plk", p3,
      in_scale(1, 0),
      fade_in(8, 128) * ampdbfs(-9))

  hexplay("f", 
      "Plk", p3 * 0.5,
      in_scale(1, xoscb(2.7, array(0,2,4,2)) + xoscb(1, array(0,4,7,11))),
      fade_in(8, 128) * ampdbfs(-16) * choose(0.5))

  hexplay("f0000000", 
      "Sub2", p3,
      in_scale(0, xoscb(1, array(0,4,7,11))),
      fade_in(11, 128) * ampdbfs(xoscim(8.1, array(-20, -14))))

  hexplay("a222", 
      "Mode1", p3,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(-12))

  hexplay("22a2", 
      "Mode1", p3,
      in_scale(0, 4),
      fade_in(12, 128) * ampdbfs(-15))

  hexplay("8000", 
       "Sub6", p3,
       in_scale(-1, 0),
       fade_in(10, 128) * ampdbfs(xoscim(7.7, array(-20, -14))))

  hexplay("8000", 
       "Sub7", p3,
       in_scale(0, 0),
       fade_in(10, 128) * ampdbfs(xoscim(8, array(-20, -14))))

  chnset(xoscim(16, array(2000, 4000)), "Organ2.cut")

endin

