;; Author: Steven Yi
;; Title: Rhythmic3
;; 2019-05-13
start("ReverbMixer")
instr P1
  
  hexplay("a000a00a",
      "Sub6", p3,
      in_scale(-1, hexbeat("e81234") * 7 + xosc(phsm(2), array(0,4,7,11,14,18,21))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("febdfedbddfeb",
      "Sub7", p3,
      in_scale(-2, hexbeat("82") * 7 + xosc(phsm(2), array(0,4,7,11,14,18,21))),
      fade_in(5, 128) * ampdbfs(-12) * choose(0.7))

  hexplay("febdfedbddfeb",
      "Sub2", p3,
      in_scale(-1, hexbeat("82") * 7 + hexbeat("59834") * 2 + hexbeat("fe9c834") * 3),
      fade_in(5, 128) * ampdbfs(-13) * choose(0.7))

  hexplay("febdfedbddfeb",
      "SynBrass", p3,
      in_scale(2, hexbeat("82") * 4 + hexbeat("594") * 7 + hexbeat("fe9c834") * 2),
      fade_in(5, 128) * ampdbfs(-12) * choose(0.7))
  
  if(choose(0.2) == 1) then
    schedule(
      "SSaw", 0, p3 * rand(array(2,4,6,8)),
      in_scale(-2, hexbeat("82") * 7 + xosc(phsm(2), array(0,4,7,11,14,18,21))),
      fade_in(5, 128) * ampdbfs(-15) * choose(0.7))
  endif
  
  hexplay("c000",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-6))

  
endin
