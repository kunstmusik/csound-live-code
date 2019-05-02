;; Author: Steven Yi
;; Title: Signals 5 
;; 2019-05-02

start("ReverbMixer")

instr S1

  ifreq = 440
  iclock = 1

  asig = vco2(0.1, ifreq)
  asig += vco2(0.1, ifreq * 2)

  asig *= lfo(0.25, iclock, 2) + 0.5
  asig *= lfo(0.25, iclock * 3, 2) + 0.75

  asig *= linsegr(0, 0.1, 1, 0.1, 0)

  pan_verb_mix(asig, 0.5, 0.2)

endin

start("S1")

instr B1 

  ifreq = in_scale(-2, 0) 
  iclock = 1

  asig = vco2(0.1, ifreq, 10)

  asig *= vco2(0.5, 0.1, 10) + 0.5

  asig *= linsegr(0, 0.1, 1, 0.1, 0)

  pan_verb_mix(asig, 0.5, 0.2)

endin
start("S1")
stop("B1")


instr S2

  kfreq = lfo(1000, 0.2) + 1200 
  iclock = 3 

  asig = vco2(0.1, kfreq)
  asig += vco2(0.1, kfreq * 1.5)

  asig *= lfo(0.25, iclock, 2) + 0.5
  asig *= lfo(0.25, iclock * 3, 2) + 0.75


  asig *= lfo(0.5, 0.1, 1) + 0.5

  asig *= linsegr(0, 0.1, 1, 0.1, 0)

  pan_verb_mix(asig, 0.7, 0.2)

endin

start("S2")


instr S3

  kfreq = lfo(2000, 0.2) + 2400 
  iclock = 4.2839384797 

  asig = vco2(0.1, kfreq)
  asig += vco2(0.1, kfreq * 1.5)

  asig *= lfo(0.25, iclock, 2) + 0.5
  asig *= lfo(0.25, iclock * 3, 2) + 0.75


  asig *= lfo(0.5, 0.11, 1) + 0.5

  asig *= linsegr(0, 0.1, 1, 0.1, 0)

  pan_verb_mix(asig, 0.3, 0.2)

endin

start("S3")


instr S4

  ifreq = 200
  iclock = 3.78734 

  asig = vco2(0.1, ifreq)
  asig += vco2(0.1, ifreq * 2)

  asig *= lfo(0.25, iclock, 2) + 0.5
  asig *= lfo(0.25, iclock * 2, 2) + 0.75


  asig *= 0.4
  asig *= linsegr(0, 0.1, 1, 0.1, 0)

  pan_verb_mix(asig, 0.5, 0.2)

endin

start("S4")


instr S5
  asig = random:a(-1, 1)
  ifreq = 300

  a1 = zdf_2pole(asig, ifreq, 10, 3)
  a1 += zdf_2pole(asig, ifreq * 2, 10, 3) * 0.2
  a1 += zdf_2pole(asig, ifreq * 4, 10, 3) * 0.1
  asig = a1

  asig *= lfo(0.5, 4.545, 2) + 0.5 
  asig *= lfo(0.3, 0.05, 1) + 0.7
  asig *= 2 

  pan_verb_mix(asig, 0.5, 0.3)
endin
start("S5")
