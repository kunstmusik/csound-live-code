;; Author: Steven Yi
;; Date: 2020.11.21
;; Description: Modular Forest

start("ReverbMixer")

instr Syn1
  
  ifreq = 400
  iamp = ampdbfs(-12)
 
  kfreq = ifreq * oscil(3.7, array(1,2,3))
  kfreq = port(kfreq, 0.001)

  
  asig = vco2(iamp, kfreq) 
  asig += vco2(iamp * .5, kfreq * 2, 10)
  
  kcut = lfo(3, lfo(2, .1) + 2.1) + lfo(1, 0.177) + lfo(2, 7)
  
  kcut = cpsoct(limit(kcut + 7,4.4, 14))
  
  asig = zdf_ladder(asig, kcut, 2) 
  
  pan_verb_mix(asig, 0.5, 0.4)
endin

start("Syn1")

instr Syn2
  
  ifreq = 300
  iamp = ampdbfs(-12)
  
  kfreq = ifreq * oscil(5, array(1,2,1,2,4))
  
  kspace = lfo(.02, .1) + 1
  
  asig = vco2(iamp, kfreq, 10) 
  asig += vco2(iamp, kfreq * 1.001423424 * kspace)
  asig += vco2(iamp * .5, kfreq * 2.001423424 * kspace)  
  
  
  kcut = lfo(3, lfo(0.3, .2) + .4) + lfo(1, 0.377) + lfo(2, 3) 
  
  kcut = cpsoct(limit(kcut + 7,4.4, 14))
  
  asig = zdf_ladder(asig, kcut, 2)
  
  asig *= .4
  
  
;   asig *= lfo(0.5, .25) + 0.5
 
  
  pan_verb_mix(asig, 0.8, 0.4)
endin

start("Syn2")

instr Syn3
  
  ifreq = 450
  iamp = ampdbfs(-12)
  
  kfreq = ifreq * oscil(2, array(1,2,3,4))
  
  asig = vco2(iamp, kfreq) 
  asig += vco2(iamp * 0.25, kfreq * 2, 12)
  
  kcut = lfo(3, lfo(0.2, .1) + .3) + lfo(1, 0.277) + lfo(2, 3.254) 
  
  kcut = cpsoct(limit(kcut + 7,4.4, 14))
  
  asig = zdf_ladder(asig, kcut, 2)
  
  
;   asig *= lfo(0.5, .25) + 0.5
 
  asig *= 0.5
  
  pan_verb_mix(asig, 0.2, 0.4)
endin

start("Syn3")


