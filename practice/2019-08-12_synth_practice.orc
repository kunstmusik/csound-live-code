;; Author: Steven Yi
;; Description: Synth practice, FM with VA Oscs, randomized parameters
;; Date: 2019-08-11

start("ReverbMixer")

galfo init 0
instr LFO
  galfo = oscili:a(.5, oscili:a(2, .1) + 2.5) 
endin
start("LFO")

instr S1
  klfo = oscili:k(p5 * expon(4, p3, 1), p5 * expon(5, p3, 0.001))
  asig = vco2(p5, klfo + p4, rand(array(0,10, 12))) 
  asig += vco2(p5 * .25, klfo + p4 * 2.001, rand(array(0,10, 12)))   
  asig += vco2(p5 * .125, klfo + p4 * 1.001, rand(array(0,10, 12)))     

  if(choose(0.8) == 1) then
    asig = zdf_ladder(asig, galfo * 2000 + 2020, rand(array(2,4,6)))
    asig *= 0.8
  else 
    asig = zdf_2pole(asig, galfo * 1000 + 2020, rand(array(2,5)))
    asig *= 0.6
  endif
  
  asig *= expsegr(1, p3, 1, 10, 0.001)
  
  
  pan_verb_mix(asig, rand(array(0.25,.5, .75)), 0.5)
endin

schedule("S1",  0, rand(array(10,15)), in_scale(rand(array(-2, -1, 1, 1)), rand(array(0,2,4,6,8,10))), ampdbfs(-9))
