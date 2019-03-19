;; Author: Steven Yi
;; Title: Voices 
;; 2019-03-19

instr Mixer
  ;; dry and reverb send signals
  a1, a2 sbus_read 0
  a3, a4 sbus_read 1
  
  al, ar reverbsc a3, a4, xchan:k("Reverb.fb", 0.8), xchan:k("Reverb.cut", 12000)
  
  a1 = tanh(a1 + al)
  a2 = tanh(a2 + ar)
  
  out(a1, a2)
  
  sbus_clear(0)
  sbus_clear(1)
endin
start("Mixer")

instr S1
  ifreq = in_scale(1, 0)
  iamp = ampdbfs(-18)
  ipan = 0.5
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  kfreq = ifreq * (lfo(0.005, 4.7) + 1)
  asig = vco2(iamp, kfreq)
  asig += vco2(iamp, kfreq * 2, 10)

  
  ;; Signal Processing
  
  asig = zdf_ladder(asig, 1060 + 1000 * lfo(1, .1, 1), 1)
  
  ;; Panning and send to mixer
  al, ar pan2 asig, ipan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S1")
;; stop("S1")

instr S2
  ifreq = in_scale(1, 2)
  iamp = ampdbfs(-18)
  ipan = 0.5
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  kfreq = ifreq * (lfo(0.005, 4.7) + 1)
  asig = vco2(iamp, kfreq)
  asig += vco2(iamp, kfreq * 2, 10)

  
  ;; Signal Processing
  
  asig = zdf_ladder(asig, 1060 + 1000 * lfo(1, .117, 1), 1)
  
  ;; Panning and send to mixer
  al, ar pan2 asig, ipan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S2")

instr S3
  ifreq = from_root(1, 4)
  iamp = ampdbfs(-18)
  ipan = 0.75
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  kfreq = ifreq * (lfo(0.005, 4.7) + 1)
  asig = vco2(iamp, kfreq)
  asig += vco2(iamp, kfreq * 2, 10)

  
  ;; Signal Processing
  
  asig = zdf_ladder(asig, 1060 + 1000 * lfo(1, .097, 1), 10)

  ;; Panning and send to mixer
  al, ar pan2 asig, ipan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S3")


instr Synth1
  ifreq = p4
  iamp = p5
  ipan = 0.3
  irvb = ampdbfs(-18)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp * 0.5, ifreq * 2.00134, 10)

  
  asig = zdf_ladder(asig, expon(2000, p3, 60), 4)
  
  ;; Signal Processing
  
  ;; Panning and send to mixer
  al, ar pan2 asig, ipan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
;; schedule("Synth1", 0, 0.25, in_scale(-2, rand(array(0,1,2,4,5,6))), ampdbfs(-12))
