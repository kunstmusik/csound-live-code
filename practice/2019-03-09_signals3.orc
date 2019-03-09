;; Author: Steven Yi
;; Title: Signals 3
;; 2019-03-09

instr Mixer
  a1,a2 sbus_read 0
  a3,a4 sbus_read 1
  
  al, ar reverbsc a3, a4, xchan:k("Mixer.fb", 0.8), xchan:k("Mixer.cut", 8000)
  
  out(a1 + al, a2 + ar)
  
  sbus_clear(0)
  sbus_clear(1)
  
endin
start("Mixer")

instr S1
  asig = vco2(ampdbfs(-12), 300)
  asig = zdf_ladder(asig, 4000 + lfo(3000, 1/7), 11)
  
  asig *= vco2(0.5, 1 / (5 + lfo(4, 1/10)) , 10) + 0.5
  asig *= vco2(0.5, (7.2 + lfo(3, 1/11)) , 10) + 0.5
  asig *= vco2(0.5, 3.32, 10) + 0.5
  
  irvb = ampdbfs(-8)
  
  al, ar pan2 asig, 0.25
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S1")

instr S2
  asig = vco2(ampdbfs(-12), 150)
  asig += vco2(ampdbfs(-15), 300, 10)
  
  asig = zdf_ladder(asig, 2000 + lfo(1500, 1/7), 11)
  
  asig *= vco2(0.5, 1 / (5 + lfo(3, 1/10)) , 10) + 0.5
  asig *= vco2(0.5, (7.2 + lfo(3, 1/11)) , 10) + 0.5
  asig *= vco2(0.5, 8.32, 10) + 0.5
  
  irvb = ampdbfs(-8)
  
  al, ar pan2 asig, 0.5
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S2")

instr S3
  asig = vco2(ampdbfs(-9), 60, 10)
  
  asig = zdf_ladder(asig, lfo(5000, 1/10, 1) + 6000, .5)
  
  asig *= vco2(0.5, 1/2 , 10) + 0.5
  
  asig *= oscil(1/2, array(1,0,1,1,0,1,0,0,1,0,1,1,0))
  
  irvb = ampdbfs(-8)
  
  al, ar pan2 asig, 0.6
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S3")

instr S4
  
  kfreq = cpsmidinn(oscil(1/2, array(72, 74, 71,70,70)))

  asig = vco2(ampdbfs(-18), kfreq, 10)
  
  asig = zdf_ladder(asig, lfo(5000, 1/10, 1) + 6000, .5)
  
  asig *= vco2(0.5, 1/2 , 10) + 0.5
 
  
  irvb = ampdbfs(-8)
  
  al, ar pan2 asig, 0.8
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S4")

instr S5
  asig = vco2(0.1, 3000)
  asig += vco2(0.1, 3017)
  
  asig = zdf_ladder(asig, phasor(1/8) * 8000 + 20, 5)
  
  sbus_mix(0, asig, asig)
  
endin
start("S5")

instr S6
  ipch = cps2pch(7.3, 12)
  asig = vco2(0.1, ipch)
  asig += vco2(0.1, ipch * 1.01)
  
  asig = zdf_ladder(asig, phasor(1/7) * 8000 + 20, 5)
  
  sbus_mix(0, asig, asig)
  
endin
start("S6")
