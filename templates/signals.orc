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
  ifreq = 80
  iamp = ampdbfs(-12)
  ipan = 0.5
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  
  ;; Signal Processing
  
  ;; Panning and send to mixer
  al, ar pan2 asig, ipan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
endin
start("S1")
;; stop("S1")
