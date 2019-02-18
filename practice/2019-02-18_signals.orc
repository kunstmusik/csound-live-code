;; Author: Steven Yi
;; Title: Signals
;; 2019-02-18 

instr Mixer
  arvb0, arvb1 sbus_read 1
  adry0, adry1 sbus_read 0
  
  arl, arr reverbsc arvb0, arvb1, 0.9, 2000
  
  out(adry0 + arl, adry1 + arr)
  
  sbus_clear(0)
  sbus_clear(1)
  
endin
start("Mixer")

instr Sig1
  asig = vco2(0.25, 110)
  asig += oscili(0.4, 65)
  kcut = 1500 + lfo(0.5, 0.2) * 1000
  asig = zdf_ladder(asig, kcut + lfo(kcut * 0.4, 8), 3)
  asig *= linsegr(0, 0.05, 1, 1.0, 0.0)
  asig *= vco2(0.5, 1, 10) + 0.5

  irvb = ampdbfs(-12)
  
  al, ar pan2 asig, 0.2
  
  sbus_mix(1, al * irvb, ar * irvb)
  sbus_mix(0, al, ar)
endin
start("Sig1")
; schedule(-nstrnum("Sig1"), 0, 0)

instr Sig2
  kpch = oscil(0.03, array(550, 660, 770, 880)) * 2
  asig = vco2(0.25, kpch)
  kcut = 3500 + lfo(0.5, 0.2) * 2000
  asig = zdf_ladder(asig, kcut + lfo(kcut, 8), 9 + lfo(8, 0.1))
  asig *= linsegr(0, 0.05, 1, 1.0, 0.0)
  irvb = ampdbfs(-18)
  
  al, ar pan2 asig, 0.8
  
  sbus_mix(1, al * irvb, ar * irvb)
  sbus_mix(0, al, ar)
endin
start("Sig2")
; schedule(-nstrnum("Sig2"), 0, 0)

instr Sig3
;   kpch = oscil(0.03, array(550, 660, 770, 880))
  kpch = 1760
  asig = vco2(0.25, kpch)
  asig += vco2(0.2, kpch * 0.5, 12)
  kcut = 4000 + lfo(3000, 0.17)
  asig = zdf_ladder(asig, kcut + lfo(kcut, 8), 9 + lfo(8, 0.1))
  asig *= vco2(0.5, 2, 2, lfo(0.3, 0.1) + 0.5) + 0.5
  asig *= linsegr(0, 0.05, 1, 1.0, 0.0)
  irvb = ampdbfs(-9)
  
  al, ar pan2 asig, 0.5
  
  sbus_mix(1, al * irvb, ar * irvb)
  sbus_mix(0, al, ar)
endin
start("Sig3")
; kill("Sig3")

