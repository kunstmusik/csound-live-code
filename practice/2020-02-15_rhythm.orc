;; Author: Steven Yi
;; Description: Rhythm 
;; Date: 2020-02-15

start("ReverbMixer")

xchnset("rvb.default", 0.2)

instr P1

  SVals[] fillarray "", "sd", "", "808:1", "808:2"

  hexdirt("f",
      SVals[((p4 << 1) | (p4 << 3)) % lenarray(SVals)], 
      fade_in(17, 128) * ampdbfs(-15))

  hexdirt("8",
      "bd:2", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("2",
      "808:1", 
      fade_in(9, 128) * ampdbfs(-12))

  hexdirt("00ff000000",
      "808:1", 
      fade_in(10, 128) * ampdbfs(xlin(phsb(2), -24, -12)))

  hexdirt("0800",
      "gabba:2", 
      fade_in(6, 128) * ampdbfs(-12))

  hexdirt("0008",
      "gabba:1", 
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("2aaa2222", 
      "Bass", p3,
      in_scale(-1, xoscm(2, array(0,1))),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("f", 
      "Bass", p3,
      in_scale(-1, xoscm(2, array(0,1)) + xosc(phs(2), array(0,7))),
      fade_in(15, 128) * ampdbfs(-18))

  xchnset("Sub4.rvb", 0.3)
  hexplay("00ff0000", 
      "Sub4", p3,
      in_scale(1, (p4 | (p4 << 1)) % 32 % 7),
      fade_in(14, 128) * ampdbfs(-12))

  hexplay("82082088", 
      "Bass", p3,
      in_scale(0, 4),
      fade_in(12, 128) * ampdbfs(-12))

  hexdirt("a200",
      "psr:4", 
      fade_in(16, 128) * ampdbfs(-12))


endin
