;; Author: Steven Yi
;; Description: Progressive House
;; Date: 2020-02-14
start("ReverbMixer")

set_tempo(128)

instr P1
  hexdirt("80028000",
      "bd:2", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("0808080d0808080f",
      "sd:0", 
      fade_in(16, 128) * ampdbfs(-12))

  hexdirt("cc0000",
      "808:1", 
      fade_in(6, 128) * ampdbfs(-12))

  hexdirt("2",
      "808:1", 
      fade_in(7, 128) * ampdbfs(-12))

  hexdirt("08",
      "808:2", 
      fade_in(8, 128) * ampdbfs(-12))

  hexdirt("8200",
      "jvbass", 
      fade_in(9, 128) * ampdbfs(-12), 
      semitone(xoscb(2, array(0,1))))

  hexplay("09200000", 
      "Bass", p3,
      in_scale(1, 0),
      fade_in(18, 128) * ampdbfs(-12))

  hexplay("2a", 
      "Sub7", p3 * 0.7,
      in_scale(0, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexdirt("aaa00000",
      "yeah:2", 
      fade_in(14, 128) * ampdbfs(-12))
 
  xchnset("808:5.rvb", xlin(phsb(4), 0.1, 0.5))
  hexdirt("02aa2222",
      "808:5", 
      fade_in(15, 128) * ampdbfs(-12))

  hexplay("f", 
      "Click", p3,
      random:i(3000, 6000),
      fade_in(13, 128) * ampdbfs(xlin(phsb(4), -9, -24)) * xoscm(2, array(1, 0)))

  hexplay("000f0e0c", 
      "Square", p3,
      in_scale(1, (p4 # (p4 << 2)) % 32 & 9),
      fade_in(19, 128) * ampdbfs(-12))

endin
