;; Author: Steven Yi
;; Description: Bitshift with OR operations
;; Date: 2020-01-25

start("ReverbMixer")

xchnset("Sub6.rvb", 0.6)

instr P1
  
  iv = xcos(phsb(4), 4, 4)
  hexplay("bd8fe",
      "Sub6", p3 * 0.7,
      in_scale(-1, (iv | (iv << 2)) % 17),
      fade_in(8, 128) * ampdbfs(-12))

  iv = xcos(phsb(4), 4, 4)
  hexplay("8febd",
      "Sub6", p3 * 0.7,
      in_scale(0, 2 + (iv | (iv << 2)) % 17),
      fade_in(8, 128) * ampdbfs(-12))

  cause("CHH", 0, p3,
      in_scale(-1, 0),
      ampdbfs(-12) * hexbeat("2"))
  
  cause("BD", 0, p3,
      in_scale(-1, 0),
      ampdbfs(-12) * hexbeat("8"))

  
endin
