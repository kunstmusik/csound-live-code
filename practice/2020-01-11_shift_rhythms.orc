;; Author: Steven Yi
;; Description: Shift patterns for instrument choices
;; Date: 2020.01.11

start("ReverbMixer")

instr P1
  Svals[] = fillarray("BD", "SD", "CHH", "Clap", "BD", "Click")
  
  cause(Svals[(p4 << (p4 & 0x3)) % 17 % 6], 0, p3, in_scale(0, 0), ampdbfs(-12) * hexbeat("c88"))  
  cause(Svals[(p4 >> (p4 & 0x5)) % 19 % 6], 0, p3, in_scale(0, 0), ampdbfs(-9) * hexbeat("f"))

  Svals[] = fillarray("Square", "Saw", "Sub5")

  cause(Svals[(p4 >> (p4 & 0x3)) % 19 % 3], 0, p3, 
    in_scale(0, cycle(p4 % 17 % 11, array(0,2,3,1,3))), ampdbfs(-15) * hexbeat("f"))
  
  cause(Svals[(p4 << (p4 & 0x3)) % 17 % 3], 0, p3, 
    in_scale(0, 4 + cycle(p4 % 17 % 11, array(0,2,3,1,3))), ampdbfs(-15) * hexbeat("f"))
  
  hexplay("f",
      "Sub6", p3 * 0.5,
      in_scale(1, 0),
      fade_in(5, 128) * ampdbfs(xlin(phsm(8), -18, -12)))
  
endin
