;; Author: Steven Yi
;; Description: Shifts, XOR, mod
;; Date: 2020-01-26

start("ReverbMixer")

instr P1
  ia = xsin(phsb(4), 128, 128)
  ipat = ia # (ia << (ia & 0x7))
  ipat = ipat % 12
  
  hexplay("8b35f",
      "Bass", p3,
      from_root(0, ipat),
      ampdbfs(-12))
  
  hexplay("f8b35",
      "Bass", p3,
      from_root(0, 4 + (ipat # (ia >> 2)) % 11),
      ampdbfs(-12))

  hexplay("b35f8",
      "Bass", p3,
      from_root(0, 7 + (ipat # (ia >> 3)) % 17),
      ampdbfs(-12))
  
endin
