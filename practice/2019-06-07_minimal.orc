; Author: Steven Yi
; Title: Minimal
; Date: 2019-06-07

start("ReverbMixer")

instr P1
  hexplay("f",
      "Sub5", p3,
      in_scale(-1, hexbeat("43") * 7),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub5", p3,
      in_scale(-1, hexbeat("43") * 7 + hexbeat("373") * 2),
      fade_in(6, 128) * ampdbfs(-15))

  hexplay("f",
      "Sub5", p3,
      in_scale(0, hexbeat("43") * 7 + hexbeat("373") * 2 + hexbeat("34324") * 2),
      fade_in(6, 128) * ampdbfs(-15))
  
  hexplay("fefedbabda",
      "Sub5", p3,
      in_scale(1, 4 + hexbeat("43") * 7 + hexbeat("373") * 2 + hexbeat("34324") * 2),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.7))

  hexplay("a",
      "Mode1", p3,
      in_scale(1, 0),
      fade_in(8, 128) * ampdbfs(xoscim(8, array(-22, -15))))

  hexplay("f",
      "Sub6", p3,
      in_scale(-1, xoscb(1, array(0,4,7,11))),
      fade_in(9, 128) * ampdbfs(xoscm(8, array(-18, -20))))
  
  hexplay("f000",
      "Sub7", p3,
      in_scale(0, 4 + xoscb(1, array(0,4,7,11))),
      fade_in(10, 128) * ampdbfs(-15))

  hexplay("f",
      "Mode1", p3,
      in_scale(2, 0),
      fade_in(11, 128) * ampdbfs(xoscm(8, array(-24, -18))))

  if(p4 % 128 == 0) then
    schedule("Organ2", 0, beats(15), in_scale(-2, 0), ampdbfs(-12))
  endif
  
  if((p4 - 8) % 128 == 0) then
    schedule("Organ2", 0, beats(13), in_scale(-2, 4), ampdbfs(-12))
  endif
  
  if((p4 - 16) % 128 == 0) then
    schedule("Organ2", 0, beats(11), in_scale(-2, 8), ampdbfs(-12))
  endif
  
  hexplay("c000",
      "Sub2", p3,
      in_scale(0, 0),
      fade_in(12, 128) * ampdbfs(-12))
  
  hexplay("c000",
      "Sub1", p3,
      in_scale(-1, 0),
      fade_in(13, 128) * ampdbfs(-12))
  
endin
