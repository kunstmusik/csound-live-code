; Author: Steven Yi
; Title: Bitshift | Modulus
; Date: 2019-06-08

start("ReverbMixer")

chnset(0.4, "Plk.pan")
chnset(0.6, "Mode1.pan")
chnset(0.8, "Plk.reverb")

instr P1
  hexplay("a",
      "Organ2", p3 * 2,
      in_scale(-2, xoscb(3, array(0,4,7,11,7,4))),
      fade_in(6, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Organ2", p3 ,
      in_scale(-1, xoscb(1.5, array(0,4,7,11,7,4))),
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("c0",
      "Organ2", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f",
      "Plk", p3,
      in_scale(p4 % 2, 0),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Plk", p3,
      in_scale(p4 % 3, (p4 % 2) * 2),
      fade_in(9, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Plk", p3,
      in_scale(1 + p4 % 2, (p4 % 3) * 4),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("f",
      "Mode1", p3,
      in_scale(1, ((p4 >> (p4 & 7)) % 7)),
      fade_in(11, 128) * ampdbfs(-15))

  hexplay("f",
      "Mode1", p3,
      in_scale(1, 4 + ((p4 >> (p4 & 3)) % 7)),
      fade_in(12, 128) * ampdbfs(-15))

endin
