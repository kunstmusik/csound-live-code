;; Author: Steven Yi
;; Date: 2020.07.12
;; Description: Mellow Groove

start("ReverbMixer")

xchnset("Reverb.fb", 0.8)

xchnset("Square.rvb", 0.5)
xchnset("Saw.rvb", 0.7)
xchnset("Mode1.rvb", 0.5)
xchnset("Form1.rvb", 0.7)

instr P1
  
  hexplay("a",
      "Form1", p3 * 0.5,
      in_scale(0, 1),
      fade_in(13, 128) * ampdbfs(xcos(phsm(8), -12, 6)))
  
  hexplay("a222",
      "Mode1", p3 * 0.5,
      in_scale(2, 3),
      fade_in(12, 128) * ampdbfs(-12))
  
  hexplay("a0aa",
      "Sub5", p3,
      in_scale(-1, xoscb(1, array(0,7)) + xoscm(1, array(0, 2,3,4))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("2a002a22",
      "Sub2", p3,
      in_scale(0, 2),
      fade_in(6, 128) * ampdbfs(-15))
  
  hexplay("c",
      "Bass", p3,
      in_scale(2, 2 + cycle(p4 % 77 % 37 % 17, array(0,4,2,3,1,2,4,3))),
      fade_in(7, 128) * ampdbfs(xlin(phsm(8), -15, -30)))

  hexplay("c300",
      "Saw", p3,
      in_scale(1, xoscb(2, array(0,7))),
      fade_in(8, 128) * ampdbfs(-15))
  
  hexplay("a",
      "Organ3", p3,
      in_scale(0, cycle(p4 % 77 % 37 % 17, array(0,4,2,3,1,2,4,3))),
      fade_in(10, 128) * ampdbfs(-18))

   hexplay("c",
      "Saw", p3 * 0.8,
      in_scale(1, 8),
      fade_in(9, 128) * ampdbfs(xlin(phsm(4), -18, -30)))


endin
