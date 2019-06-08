; Author: Steven Yi
; Title: Rhythms, Layers 
; Date: 2019-06-08

start("ReverbMixer")

chnset(0.6, "SynBrass.pan")
chnset(0.4, "Mode1.pan")

instr P1
  hexplay("8", 
      "Sub5", p3 * 4,
      in_scale(-1, xoscm(1, array(6,7,3,4))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Sub5", p3 * 2,
      in_scale(0, xoscm(1, array(6,7,3,4))),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.5))

  hexplay("f", 
      "Sub5", p3,
      in_scale(0, xoscb(1, array(2,3,1,2)) + xoscm(1, array(6,7,3,4))),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.7))

  hexplay("f", 
      "Sub5", p3,
      in_scale(0, 4 + xoscb(1, array(2,3,1,2)) + xoscm(1, array(6,7,3,4))),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.4))

  hexplay("f", 
      "Sub2", p3,
      in_scale(-1, 2),
      fade_in(8, 128) * ampdbfs(xoscim(8, array(-22, -16))))

  hexplay("f", 
      "Sub1", p3,
      in_scale(0, 2),
      fade_in(9, 128) * ampdbfs(xoscim(7.7, array(-22, -16))))

  hexplay("f", 
      "Mode1", p3,
      in_scale(0, 4),
      fade_in(11, 128) * ampdbfs(xoscim(7.9, array(-22, -16))))

  hexplay("c000", 
      "Sub7", p3,
      in_scale(0, 0),
      fade_in(10, 128) * ampdbfs(-12))

  hexplay("f800", 
      "SynBrass", p3,
      in_scale(-1, hexbeat("34") * 7),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("f80", 
      "SynBrass", p3,
      in_scale(0, hexbeat("34") * 7 + hexbeat("fe343") * 2 + hexbeat("341343f") *2),
      fade_in(13, 128) * ampdbfs(-12))

  hexplay("f", 
      "SynBrass", p3,
      in_scale(0, 4 + hexbeat("34") * 7 + hexbeat("fe343") * 2 + hexbeat("341343f") *2),
      fade_in(14, 128) * ampdbfs(-12) * choose(0.9))

  if(p4 % xoscm(8, array(64,32,16)) == 0) then
    ibase = random:i(0, 4) * 2
    schedule("Organ2", 0, measures(3.8), in_scale(-2,ibase), ampdbfs(-16))
    schedule("Organ2", 0, measures(3.8), in_scale(-2,ibase + 4), ampdbfs(-18))
  endif

endin

