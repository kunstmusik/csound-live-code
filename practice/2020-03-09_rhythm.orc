;; Author: Steven Yi
;; Description: Rhythm
;; Date: 2020.03.09

start("ReverbMixer")

xchnset("rvb.default", 0.3)

instr P1
  hexdirt("8",
      "bd:0", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("0008000b0008000c",
      "808:3", 
      fade_in(12, 128) * ampdbfs(-12))

  hexdirt("08",
      "808sd:1", 
      fade_in(6, 128) * ampdbfs(xlin(phsm(8), -12, -24)))

  hexdirt("2",
      "808:1", 
      fade_in(17, 128) * ampdbfs(-18))

  hexdirt("ff0000",
      "808:1", 
      fade_in(16, 128) * ampdbfs(xlin(phsb(2), -20, -12)))

  iv = (p4 << 2) | (p4 << 1)
  hexplay("a", 
      "Bass", p3,
      from_root(1, iv % 64 % 17 % 11),
      fade_in(14, 128) * ampdbfs(xlin(phsm(8), -12, -30)))

  iv = (p4 | (p4 << 1) # (p4 << 2)) & 0x7
  hexplay("ffffffff80000000",
      "Bass", p3,
      from_root(-2, iv),
      fade_in(19, 256) * ampdbfs(-12))

  hexplay("ff800", 
      "Click", p3,
      random:i(300, 9000),
      fade_in(15, 128) * ampdbfs(-12))

  /*Svals[] fillarray "", "808ht", "808mt", "808lt", "psr:4"*/
  /*iv = ((p4 << 3) | (p4 << 2))*/
  /*hexdirt("f",*/
      /*Svals[iv % lenarray(Svals)], */
      /*fade_out(8, 256) * ampdbfs(-12))*/

  Svals[] fillarray "gabba:2", "yeah:2", "gabba:1"
  iv = ((p4 << 3) # (p4 << 2)) >> 1
  hexdirt("ff55",
      Svals[iv % lenarray(Svals)], 
      fade_in(9, 128) * ampdbfs(-12))
  

endin
