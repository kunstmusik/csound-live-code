;; Author: Steven Yi
;; Title: Blips 
;; 2019-05-09

start("ReverbMixer")
instr S1
  asig = vco2(p5, p4)
  asig += vco2(p5 * 0.4, p4 * 2, 4, 0.5)
  
  istart = rand(array(15000, 5000, 1200, 100))

  iend = rand(array(15000, 5000, 1200, 100))  
  asig = zdf_ladder(asig, expon(istart, p3, iend), 2)
  
  asig *= 0.5
  
  pan_verb_mix(asig, 0.5, 0.8)
endin

instr P1
  
  hexplay("fa000000",
      "S1", p3,
      in_scale(1, xosc(phsm(1.7), array(0,1,3,4,6,8))),
      fade_in(8, 128) * ampdbfs(-18))
  
  if(choose(0.4) == 1) then
    schedule(
        "S1", 0, p3 * random:i(0.5, 4), 
        in_scale(1, 4 + xosc(phsm(1.7), array(0,1,3,4,6,8))),
        fade_in(8, 128) * ampdbfs(-22))
  endif
  
  if(choose(0.4) == 1) then
    schedule(
        "S1", 0, p3 * random:i(3, 8), 
        in_scale(1, 2 + xosc(phsm(1.9), array(0,0,1,2))),
        fade_in(8, 128) * ampdbfs(-22))
  endif
  
  if(choose(0.3) == 1) then
    schedule(
        "S1", 0, p3 * random:i(1, 4), 
        in_scale(1, 8 + xosc(phsm(1.8), array(0,0,1,2))),
        fade_in(8, 128) * ampdbfs(-22))
  endif
  
  if(choose(0.5) == 1) then
    schedule(
        "S1", 0, p3 * random:i(1, 4), 
        in_scale(1, 12 + xosc(phsm(1.7), array(0,0,1,2))),
        fade_in(8, 128) * ampdbfs(-22))
  endif
  
  hexplay("8",
      "S1", p3,
      in_scale(1, xosc(phsm(4), array(0,0,1,2))),
      fade_in(11, 128) * ampdbfs(-17))

endin
