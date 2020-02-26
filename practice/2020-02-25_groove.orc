;; Author: Steven Yi
;; Description: Groove
;; Date: 2020.02.05

start("ReverbMixer")

xchnset("rvb.default", 0.3)
xchnset("Bass.rvb", 0.3)
xchnset("Mode1.rvb", 0.5)
xchnset("Organ3.rvb", 0.5)


set_tempo(108)
instr P1

  hexplay("8000", 
      "Mode1", p3,
      in_scale(2, 0),
      fade_in(26, 128) * ampdbfs(-12))

  hexplay("9268", 
      "Squine1", p3,
      in_scale(1, xlin(phsb(4), 0, 12)),
      fade_in(25, 128) * ampdbfs(-18))

  hexplay("f", 
      "Bass", p3,
      in_scale(-1, cycle(((p4 << 2) # (p4 << 1)) % 32 % 11, array(0,2,4,7,9,2,4))),
      fade_in(17, 128) * ampdbfs(-12))

  hexplay("f", 
      "Bass", p3,
      in_scale(1, cycle(((p4 << 3) # (p4 << 1)) % 64 % 11, array(0,2,4,7,9,2,4))),
      fade_in(23, 128) * ampdbfs(-18))

  hexplay("cc8080ca", 
      "Bass", p3,
      in_scale(0, 2 + cycle(((p4 << 2) # p4) % 32 % 11, array(0,2,4,7,9,2,4))),
      fade_in(18, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ3", p3,
      in_scale(0, cycle(p4 % 107 % 32 % 11, array(0,2,4,7,9,2,4))) * random:i(0.999, 1.001),
      fade_in(27, 128) * ampdbfs(-18))

  hexdirt("8",
      "bd:0", 
      fade_in(19, 128) * ampdbfs(-12))

  hexdirt("08",
      "808sd:1", 
      fade_in(29, 128) * ampdbfs(-15))

  hexdirt("00000008",
      "808:3", 
      fade_in(21, 128) * ampdbfs(-12))

  hexdirt("2",
      "808:1", 
      fade_in(20, 128) * ampdbfs(xlin(phsm(8), -12, -24)))

  hexdirt("92",
      "jvbass", 
      fade_in(28, 128) * ampdbfs(-12), 
      xlin(phsm(2), 1, 1.1))

  hexdirt("f93b83bdf",
      "psr:4", 
      fade_in(24, 128) * ampdbfs(-18))

endin

;fade_out_mix()
