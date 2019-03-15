;; Author: Steven Yi
;; Title: Practice Session 2019-03-15

instr Mixer
  a1, a2 sbus_read 0
  a3, a4 sbus_read 1
  
  al, ar reverbsc a3, a4, 0.8, 12000
  
  a1 = tanh(a1 + al)
  a2 = tanh(a2 + ar)
  
  out(a1, a2)
  
  sbus_clear(0)
  sbus_clear(1)
  
endin
start("Mixer")

instr S1
  iamp = ampdbfs(-12)
  asig = vco2(iamp, 110)
  
  asig = zdf_ladder(asig, 5000 * (lfo(0.4, 0.03, 1) + 0.5), 8)
  
  asig *= vco2(0.5, 0.2, 10) + 0.5
  asig *= vco2(0.5, 3.17341, 10) + 0.5  
  asig *= vco2(0.5, 8.34098, 10) + 0.5  
  
  al, ar pan2 asig, 0.5
  irvb = ampdbfs(-12)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
  
endin
start("S1")
; stop("S1")

instr S2
  iamp = ampdbfs(-12)
  asig = vco2(iamp, 300)
  asig += vco2(iamp, 303.234)
  asig += vco2(iamp, 600, 10)
  
  asig *= 0.6
  
  asig = zdf_ladder(asig, 1000, 4)
  
  asig *= vco2(0.5, 0.075, 2, 0.25) + 0.5
  asig *= vco2(0.5, 1.2, 10) + 0.5  
  
  al, ar pan2 asig, 0.25
  irvb = ampdbfs(-18)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
  
endin
start("S2")
; stop("S2")

instr S3
  iamp = ampdbfs(-12)
  ifreq = 425
  asig = vco2(iamp, ifreq, 10)
  asig += vco2(iamp, ifreq * 1.01, 10)
  asig += vco2(iamp * 0.5, ifreq * 2, 10)
  
  asig *= 0.4
  
  asig = zdf_ladder(asig, 1000, 24)
  
  asig *= vco2(0.5, 0.25, 10) + 0.5
  asig *= vco2(0.5, 6.0, 10) + 0.5  
  asig *= vco2(0.5, 18.0, 10) + 0.5  
  
  al, ar pan2 asig, 0.75
  irvb = ampdbfs(-18)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S3")
; stop("S3")

instr S4
  iamp = ampdbfs(-12)
  kfreq = cpsmidinn(oscil(3.7, array(72, 74, 73, 77, 74, 71)))
  asig = vco2(iamp, kfreq, 10)
  asig += vco2(iamp, kfreq * 1.01, 10)
  asig += vco2(iamp * 0.5, kfreq * 2, 10)
  
  asig *= 0.4
  
  asig = zdf_ladder(asig, 5000, 8)
  
  asig *= vco2(0.5, 0.1, 2, 0.2) + 0.5
  
  al, ar pan2 asig, lfo(0.4, 0.01) + 0.5
  irvb = ampdbfs(-18)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S4")
; stop("S4")

instr S5
  iamp = ampdbfs(-12)
  kfreq = cpsmidinn(7 + oscil(3.7, array(72, 74, 73, 77, 74, 71)))
  asig = vco2(iamp, kfreq, 10)
  asig += vco2(iamp, kfreq * 1.01, 10)
  asig += vco2(iamp * 0.5, kfreq * 2, 10)
  
  asig *= 0.4
  
  asig = zdf_ladder(asig, 5000, 8)
  
  asig *= vco2(0.5, 0.1, 2, 0.2) + 0.5
  
  al, ar pan2 asig, lfo(0.4, 0.01) + 0.5
  irvb = ampdbfs(-18)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S5")
; stop("S5")


instr S6
  iamp = ampdbfs(-12)
  ifreq = cpsmidinn(83)
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp, ifreq * 0.997)
  
  asig *= 0.6
  
  asig = zdf_ladder(asig, phasor(0.1) * 10000 + 60, 4)
  asig *= vco2(0.5, 0.05, 10) + 0.5
  
  asig *= linsegr(1, 0.1, 1, 100, 1)
  
  al, ar pan2 asig, 0.49
  irvb = ampdbfs(-18)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
  
endin
start("S6")
; kill("S6")

