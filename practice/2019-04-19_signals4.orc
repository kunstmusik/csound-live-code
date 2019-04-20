
;; Author: Steven Yi
;; Title: Signals 4 
;; 2019-04-19

instr Mixer
  ;; dry and reverb send signals
  a1, a2 sbus_read 0
  a3, a4 sbus_read 1
  
  al, ar reverbsc a3, a4, xchan:k("Reverb.fb", 0.65), xchan:k("Reverb.cut", 12000)
  
  kamp = xchan:k("Mix.master", 1.0)
  
  a1 = tanh(a1 + al) * kamp
  a2 = tanh(a2 + ar) * kamp
  
  out(a1, a2)
  
  sbus_clear(0)
  sbus_clear(1)
endin
start("Mixer")

instr M1
  chnset(lfo(0.5, 2, 2) + 0.5, "Mix.master")
endin
;start("M1")
;kill("M1")

opcode send_mix, 0,akk
  asig, kpan, krvb xin
   ;; Panning and send to mixer
  al, ar pan2 asig, kpan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * krvb, ar * krvb)
endop

instr S1
  ifreq = 80
  iamp = ampdbfs(-9)
  ipan = 0.5
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp, ifreq * 1.002349829340289)
  
  asig += vco2(iamp, ifreq * 1.5, 10)
  asig += vco2(iamp * 0.5, ifreq * 4, 2, 0.8)
  
  
  ilfo = 0.1
  
  asig *= vco2(0.2, ilfo * 20, 2, 0.25) + 0.35
  
  asig = zdf_ladder(asig, lfo(5000, ilfo, 1) + 6500, 5)
  
  asig *= linsegr(0, 0.02, 1, 0.02, 0) * iamp
  
  send_mix(asig, ipan, irvb)
endin
start("S1")
;;stop("S1")


instr S2
  ifreq = 120
  iamp = ampdbfs(-9)
  ipan = 0.78
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp, ifreq * 1.002349829340289)
  
  asig += vco2(iamp, ifreq * 1.5, 10)
  
  ilfo = 0.05
  
  asig *= vco2(0.5, ilfo, 2, 0.25) + 0.5  
  asig *= vco2(0.5, ilfo * 40, 2, 0.25) + 0.5
  
  asig = zdf_ladder(asig, lfo(5000, ilfo, 1) + 7500, 5)
  
  asig *= linsegr(0, 0.02, 1, 0.02, 0) * iamp
  
  send_mix(asig, ipan, irvb)
endin
start("S2")

instr S3
  ifreq = 480
  iamp = ampdbfs(-12)
  ipan = 0.22
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp, ifreq * 1.002349829340289)
  
  asig += vco2(iamp, ifreq * 1.5, 10)
  
  ilfo = 0.25
  
  asig *= vco2(0.5, ilfo, 2, 0.125) + 0.5  
  asig *= vco2(0.5, ilfo * 10, 2, 0.25) + 0.5
  
  asig = zdf_ladder(asig, lfo(5000, ilfo, 1) + 7500, 5)
  
  asig *= linsegr(0, 0.02, 1, 0.02, 0) * iamp
  
  send_mix(asig, ipan, irvb)
endin
start("S3")

instr S4
  ilfo = 0.25

  kfreq = cpsmidinn(oscil(ilfo * 15, array(70, 77, 82,77)))
  iamp = ampdbfs(-12)
  ipan = 0.4
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, kfreq)
  asig += vco2(iamp, kfreq * 1.002349829340289)
  
  asig += vco2(iamp, kfreq * 1.5, 10)
  
  
  asig *= vco2(0.5, ilfo, 2, 0.125) + 0.5  
  asig *= vco2(0.5, ilfo * 10, 2, 0.25) + 0.5
  
  asig = zdf_ladder(asig, lfo(5000, ilfo, 1) + 7500, 5)
  
  asig *= linsegr(0, 0.02, 1, 0.02, 0) * iamp
  
  send_mix(asig, ipan, irvb)
endin
start("S4")

