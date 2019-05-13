;; Author: Steven Yi
;; Title: Rhythmic2
;; 2019-05-13

start("ReverbMixer")

instr P1
  
  chnset(xosci(phsm(4), array(0,1)), "Sub6.pan")
  
  hexplay("8a22222a8a22222f8a22222a8a2222ff",
      "Sub6", p3,
      in_scale(-1, hexbeat("82") * 7 + hexbeat("f34234234") * 2),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("8aba8d8f",
      "SynBrass", p3,
      in_scale(-1, 4 + hexbeat("82") * 7 + hexbeat("f34234234") * 2),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.7))

  hexplay("ba8a8bd8ba8ba88d88b",
      "Sub7", p3,
      in_scale(0, 2 + hexbeat("82") * 5 + hexbeat("f34234234") * 3),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.7))

  hexplay("f",
      "Sub1", p3,
      in_scale(0, 0),
      fade_in(6, 128) * ampdbfs(xosci(phsm(8), array(-30, -15))))
  
endin
