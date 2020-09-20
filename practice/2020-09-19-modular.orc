;; Author: Steven Yi
;; Date: 2020.09.19
;; Description: Modular Oscillations

start("ReverbMixer")

instr S1
  irate = 0.1
  
  ibase = 110
  kfreq = int(oscili(4, irate) + 5) * ibase
  
  kfreq = port(kfreq, 0.01, 440)
  asig = vco2(1, kfreq, 2, .4)
  asig += vco2(.5, 2 * kfreq)  
  
  asig = zdf_ladder(asig, cpsoct(oscili(3, 0.1) + 10), 0.5)
  
  asig *= oscili(0.5, 8) + 0.5
  asig *= linsegr(0, .01, .2, 4, 0)
  
  pan_verb_mix(asig, 0.5, 0.3)
endin

start("S1")

instr S2
  irate = .1
  
  ibase = 330
  kfreq = int(oscili(4, irate) + 5) * ibase
  
  kfreq = port(kfreq, 0.01, 440)
  
  asig = vco2(1, kfreq, 2, .4)
  asig += vco2(1, kfreq * 0.9993423, 2, .4)  
  asig += vco2(.5, 2 * kfreq)  
  
  asig = zdf_ladder(asig, cpsoct(oscili(3, 0.9) + 10), 0.5)
  
  asig *= oscili(0.5, 8) + 0.5
  asig *= linsegr(0, .01, .2, 4, 0)
  
  pan_verb_mix(asig, 0.7, 0.2)
endin

start("S2")

instr S3
  irate = .2
  
  ibase = 330
  kfreq = int(oscili(5, irate) + 6) * ibase
  
  kfreq = port(kfreq, 0.01, 440)
  
  asig = vco2(1, kfreq, 2, .4)
  asig += vco2(1, kfreq * 0.9993423, 2, .4)  
  asig += vco2(.5, 2 * kfreq)  
  
  asig = zdf_ladder(asig, cpsoct(oscili(3, 0.9) + 10), 0.5)
  
  asig *= oscili(0.5, 8) + 0.5
  asig *= linsegr(0, .01, .2, 4, 0)
  
  pan_verb_mix(asig, 0.3, 0.2)
endin

start("S3")


instr S4
  irate = 4
  
  ibase = 60
  kfreq = int(lfo(5, irate, 4) + 1) * ibase
  
  kfreq = port(kfreq, 0.002, ibase)
  
  asig = vco2(1, kfreq, 2, .4)
  asig += vco2(1, kfreq * 0.9993423, 2, .4)  
  asig += vco2(.5, 2 * kfreq)  
  
  asig = zdf_ladder(asig, cpsoct(oscili(3, 0.9) + 10), 5)
  
;   asig *= oscili(0.5, 8) + 0.5
  asig *= linsegr(0, .01, .2, 4, 0)
  
  pan_verb_mix(asig, 0.5, 0.2)
endin

start("S4")

instr S5
  irate = 1
  
  ibase = 200
  kfreq = int(lfo(5, irate, 4) + 1) * ibase
  
  kfreq = port(kfreq, 0.002, ibase)
  
  asig = vco2(1, kfreq, 10)
  asig += vco2(.5, 2 * kfreq, 12)  
  
  asig = zdf_ladder(asig, cpsoct(lfo(4, 1,1) + 8) , 5)
  
  asig *= linsegr(0, .01, .2, 4, 0)
  
  pan_verb_mix(asig, 0.5, 0.2)
endin

start("S5")

