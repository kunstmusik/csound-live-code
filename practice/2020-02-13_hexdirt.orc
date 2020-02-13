;; Author: Steven Yi
;; Description: hex, dirt, shift, osc, mod
;; Date: 2020-02-13
start("ReverbMixer")

set_tempo(108)

instr P1
  hexdirt("8",
      "bd:0", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("08",
      "808:3", 
      fade_in(7, 128) * ampdbfs(-12))

  hexdirt("342834",
      "808:2", 
      fade_in(9, 128) * ampdbfs(-12))

  hexdirt("2a",
      "jvbass:0", 
      fade_in(8, 128) * ampdbfs(-12),
      semitone(cycle(p4 % 17 % 11, array(0,4,7,4,2,3,1,2))))

  iv = xsin(phsb(4), 8, 8) + xsin(phsb(2), 2,2)
  iv += xoscb(4, array(0,-2,-1,-3))
  hexplay("80008880", 
      "Bass", p3,
      from_root(0, (iv | (iv << 2)) % 7),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("a222", 
      "Bass", p3,
      from_root(1, (iv # (iv << 1)) % 7),
      fade_in(11, 128) * ampdbfs(-15))

  hexdirt("92",
      "yeah:3", 
      fade_in(13, 128) * ampdbfs(-12))


endin
