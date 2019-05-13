;; Author: Steven Yi
;; Title: Rhythmic 
;; 2019-05-13

start("ReverbMixer")
instr P1
  
  hexplay("f",
      "Sub7", p3,
      in_scale(-2, xosc(phsb(2), array(0,4,7,11, 14, 18, 21, 18, 14, 11))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("cfabcbafbdbedc",
      "Sub6", p3,
      in_scale(-2, 4 + xosc(phsb(1.93), array(0,4,7,11, 14, 18, 21, 18, 14, 11))),
      fade_in(8, 128) * ampdbfs(-12) * choose(0.7))
  
  hexplay("cfabcbafb",
      "Sub7", p3,
      in_scale(-2, 7 + xosc(phsb(1.7), array(0,4,7,11, 14, 18, 21, 18, 14, 11))),
      fade_in(9, 128) * ampdbfs(-12) * choose(0.7))
  
  hexplay("0c",
      "Sub6", p3,
      in_scale(0, xcos(phsb(1.7), 12, 6)),
      fade_in(5, 128) * ampdbfs(-12))

   hexplay("000f",
       "Sub6", p3,
       from_root(2, xosc(phsb(2.7), array(0,2,3,4))),
       fade_in(6, 128) * ampdbfs(-18))

endin
