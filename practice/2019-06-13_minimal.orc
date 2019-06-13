; Author: Steven Yi
; Description: Minimal
; Date: 2019-06-13

start("ReverbMixer")

instr P1
  hexplay("8008",
      "Organ2", p3 * 4,
      in_scale(-1, xoscm(1, array(0, -4))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("8800",
      "Organ2", p3 * 4,
      in_scale(-1, xoscb(2, array(3, 2))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("2a00",
      "Organ2", p3 * 2,
      in_scale(-1, 4),
      fade_in(7, 128) * ampdbfs(-12))

  hexplay("f",
      "Organ2", p3,
      in_scale(-1, xoscb(2, array(0,4,7,11,14,18,21,25))),
      fade_in(8, 128) * ampdbfs(-15))

  chnset(random:i(0.2, 0.8), "Mode1.pan")
  hexplay("f800",
      "Mode1", p3,
      in_scale(-1, hexbeat("3f") * 7),
      fade_in(9, 128) * ampdbfs(-15))

  hexplay("f80",
      "Mode1", p3,
      in_scale(0, hexbeat("3f") * 7 + hexbeat("34bfd") * 2),
      fade_in(10, 128) * ampdbfs(-14))
  
  hexplay("f8",
      "Mode1", p3,
      in_scale(0, hexbeat("3f") * 7 + hexbeat("34bfd") * 2 + hexbeat("3fbda13") * 2),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub5", p3,
      in_scale(0, 4 + hexbeat("3f") * 7 + hexbeat("34bfd") * 2 + hexbeat("3fbda13") * 2),
      fade_in(12, 128) * ampdbfs(-18) * choose(0.6))
  
  hexplay("c000",
      "Sub2", p3,
      in_scale(-1, 0),
      fade_in(13, 128) * ampdbfs(-15))

  hexplay("8000",
      "Sub1", p3,
      in_scale(-2, 0),
      fade_in(14, 128) * ampdbfs(-15))

  hexplay("f",
      "SynBrass", p3,
      in_scale(0, xoscb(1, array(3,4,2,3))),
      fade_in(15, 128) * ampdbfs(xoscim(8, array(-24, -20))))

  hexplay("f",
      "SynBrass", p3,
      in_scale(0, xoscb(1, array(3,4,2,3))),
      fade_in(17, 128) * ampdbfs(-12) * choose(0.4))

endin
