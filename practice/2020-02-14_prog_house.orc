;; Author: Steven Yi
;; Description: Progressive House
;; Date: 2020-02-14

start("ReverbMixer")

xchnset("rvb.default", 0.3)

instr P1
  hexdirt("80209020",
      "bd:2", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("d000",
      "yeah:3", 
      fade_in(7, 128) * ampdbfs(-12))

  hexdirt("08",
      "808:2", 
      fade_in(8, 128) * ampdbfs(-12))

  hexdirt("000c",
      "808:1", 
      fade_in(17, 128) * ampdbfs(-12))

  hexdirt("ff0000",
      "808:1", 
      fade_in(18, 128) * ampdbfs(xlin(phsb(2), -24, -12)))

  hexdirt("0808080b",
      "808:3", 
      fade_in(10, 128) * ampdbfs(-12))

  hexdirt("ffff000000000000",
      "sn", 
      fade_in(13, 128) * ampdbfs(xlin(phsm(1), -12, -24)))

  hexdirt("002c00",
      "sid:2", 
      fade_in(21, 128) * ampdbfs(-12), 1 + random:i(-.3, .3))

  hexplay("a800", 
      "Square", p3,
      in_scale(0, (p4 | (p4 << 1)) % 32 % 7),
      fade_in(16, 128) * ampdbfs(-12))

  hexdirt("9222",
      "jvbass", 
      fade_in(15, 128) * ampdbfs(-12), 
      semitone(xoscm(1, array(0, 12))))


endin
