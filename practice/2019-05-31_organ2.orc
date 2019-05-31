; Author: Steven Yi
; Title: Organ2 testing
; Date: 2019.05.31
start("ReverbMixer")
instr P1

  hexplay("f", 
      "Organ2", p3 * 1.7,
      in_scale(-2, xoscb(2.7, array(0,2,4,2)) + xoscb(1, array(0,4,7,11))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ2", p3 * 1.7,
      in_scale(-1, 2 + xoscb(2.7, array(0,2,4,2)) + xoscb(1, array(0,4,7,11))),
      fade_in(5, 128) * ampdbfs(-18) * choose(0.5))


endin
