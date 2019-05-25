
;; Author: Steven Yi
;; Title: Testing xoscb, xoscm, xoscib, xoscim 
;; 2019-05-25


start("ReverbMixer")

instr P1
  
  set_root(xoscb(7, array(60, 60, 64,68)))
  
  hexplay("c0ccc0ce",
      "Plk", p3,
      in_scale(-1, xoscib(3.5, array(0,7))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("28a2a22",
      "Sub2", p3,
      in_scale(-1, xoscim(2.7, array(0,4,-3, 6))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f",
      "Plk", p3,
      in_scale(-1, xoscb(2, array(0,4,7,4,7,11,7,4))),
      fade_out(7, 128) * ampdbfs(-15))

  hexplay("f6",
      "Sub2", p3,
      in_scale(-2, xoscm(4, array(0,0,4,7)) + xoscb(2, array(0,4,7,11,14,18,21,18,14))),
      fade_in(8, 128) * ampdbfs(-12))
  
endin
