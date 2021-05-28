;; Author: Steven Yi
;; Date: 2021-05-28
;; Description: FM metallic hits and synth bass

start("ReverbMixer")

xchnset("Reverb.fb", 0.75)

instr SynFM
  kndx = adsr(.1, .1, 1, .01) * 6 + 4 ;* .5 + .5
  
  amod = oscili(kndx * p4 + xoscb(7, array(4,1,2)), p4 * 5)
  amod2 init 0
  if(random:i(0, 1) > 0.8) then
    amod2 = oscili(kndx * p4 + xoscb(5, array(4,1,2)), p4)
  endif
  asig = oscili(p5, p4 + amod + amod2)
  
  asig = expon(1, p3, .001) * asig
  
  pan_verb_mix(asig, xchan:i("SynFM.pan", 0.5), 0.1)
endin

instr B1
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 1.5, 10)  
  asig += oscili(p5, p4 * .5)
  asig = diode_ladder(asig, expon(1200 , p3, 100), 0.5)
  
  asig *= line(1, p3, 0)
  
  pan_verb_mix(asig, 0.5, 0.2)
  
endin

instr P1
  
  xchnset("SynFM.pan", random:i(0, 1))
  
  hexplay("a",
      "SynFM", p3,
      in_scale(0, cycle(p4, array(0,4,2,3,7))),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f",
      "SynFM", p3,
      in_scale(1, cycle(p4 % 64 % 37, array(0,4,2,3,7))),
      fade_in(6, 128) * ampdbfs(-20))
  
  hexplay("3f014e",
      "SynFM", p3,
      in_scale(2, 4),
      fade_in(7, 128) * ampdbfs(-6))
  
  hexplay("f3004",
      "Click", p3,
      random:i(3000, 8000),
      fade_in(8, 128) * ampdbfs(-12))

  if (p4 % 64 == 0) then
    iv = p4 / 64
    schedule("B1", 0, measures(4), in_scale(-2, xosc(iv / 4, array(0,3,4,7))), ampdbfs(-6))
  endif


endin
