;; Author: Steven Yi
;; Description: Angular Beats
;; Date: 2020-02-18
start("ReverbMixer")

xchnset("rvb.default", 0.2)

instr P1

  Svals[] fillarray "gabba:2", "yeah:1", "gabba:1"
  hexdirt("823498cdf892f",
      Svals[(p4 | (p4 << 2)) % lenarray(Svals)], 
      fade_in(26, 128) * ampdbfs(-12))

  Svals2[] fillarray "808lt", "808mt", "808ht"
  hexdirt("80",
      Svals2[(p4 | (p4 << 1)) % 32 % lenarray(Svals)], 
      fade_in(26, 128) * ampdbfs(-12))
 
  hexdirt("8020",
      "bd:2", 
      fade_in(5, 128) * ampdbfs(-12))

  hexdirt("2222222222222222f",
      "808:1", 
      fade_in(6, 128) * ampdbfs(-12))

  hexdirt("08",
      "808:3", 
      fade_in(7, 128) * ampdbfs(-12))

  hexdirt("0268",
      "808hc", 
      fade_in(25, 128) * ampdbfs(-12))

  hexdirt("0",
      "jvbass", 
      fade_in(18, 128) * ampdbfs(-12),
      semitone(cycle(p4, array(0,1,2,1))))

  xchnset("Sub7.rvb", 0.7)
  hexplay("a2222222", 
      "Sub7", p3,
      in_scale(0, 0) * xlin(phsm(2), 1, 1.02),
      fade_in(20, 128) * ampdbfs(-12))

endin
set_fade(20, 0)
