;; Author: Steven Yi
;; Date: 2020.07.08
;; Description: Groove


start("ReverbMixer")

xchnset("Organ3.rvb", 0.5)

set_scale("min")

instr S1
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 1.5, 12)  
  asig *= oscili:a(0.5, p4 * 1.5) + 0.5
  ioct = octcps(p4)
  asig =zdf_ladder(asig, cpsoct(expon(min:i(13, ioct * 5), p3, ioct)), 0.5)
  pan_verb_mix(asig, xchan:i("S1.pan", 0.5), 0.7)
endin

instr P1
  
  xchnset("S1.pan", xsin(phsm(4), 0.5, 1))
  hexplay("926f",
      "S1", p3,
      in_scale(1, 4),
      fade_in(9, 128) * ampdbfs(-7))

  hexplay("f",
      "Organ3", p3,
      in_scale(2, 0),
      fade_in(5, 128) * ampdbfs(xoscim(8, array(-30, -18))))
  
  hexplay("2",
      "Organ3", p3,
      in_scale(0, xoscb(4, array(2,1,4,4))),
      fade_in(6, 128) * ampdbfs(-15))

  hexplay("f",
      "Organ3", p3,
      in_scale(1, cycle(p4, array(2,4,1,3,0,1))),
      fade_in(7, 128) * ampdbfs(-15))

  hexplay("f",
      "Bass", p3,
      in_scale(-2, cycle(p4 % 77 % 37 % 17, array(0,4,7,9,6,4,5,3))),
      fade_in(8, 128) * ampdbfs(-6))


endin
