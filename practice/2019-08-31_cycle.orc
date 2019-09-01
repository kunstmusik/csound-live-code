;; Author: Steven Yi
;; Description: Shifting cycle() patterns
;; Date: 2019.08.31

start("ReverbMixer")

xchnset("rvb.default", 0.4)

xchnset("FM1.pan", 0.5)
xchnset("Sub1.pan", 0.3)
xchnset("Sub5.pan", 0.7)

instr P1
  
  hexplay("f",
      "Sub5", p3,
      in_scale(0, 2 + cycle(p4 % 33 % xoscm(8, array(3,7,8)), array(0,2,4,8,3,4,2))),
      fade_in(31, 128) * ampdbfs(-16))
  
  hexplay("f",
      "Sub5", p3,
      in_scale(0, 4 + cycle(p4 % 33 % xoscm(5, array(3,7,8)), array(0,2,4,8,3,4,2))),
      fade_in(31, 128) * ampdbfs(-16))
  
  hexplay("f",
      "Sub1", p3,
      in_scale(0, cycle(p4 % 31 % xoscm(3.5, array(3,7,8)), array(0,2,4,8,3,4,2))),
      fade_in(32, 128) * ampdbfs(-16))
  
  hexplay("f",
      "FM1", p3,
      in_scale(-1, 
        2 * hexbeat("fe34e") + 3 * hexbeat("34203942") + 3 * hexbeat("cfef3")),
      fade_in(30, 128) * ampdbfs(-12))
  
  hexplay("f",
      "FM1", p3,
      in_scale(-1, 
        2 + 2 * hexbeat("fe34") + 3 * hexbeat("3420394") + 3 * hexbeat("cfef")),
      fade_in(30, 128) * ampdbfs(-12))
  
  hexplay("f",
      "FM1", p3,
      in_scale(-1, 
        4 + 2 * hexbeat("fe3") + 3 * hexbeat("340394") + 3 * hexbeat("fef")),
      fade_in(30, 128) * ampdbfs(-12))

endin
