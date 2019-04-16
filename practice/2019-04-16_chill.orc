;; Author: Steven Yi
;; Title: Chill 
;; 2019-04-19

instr Mixer
  ;; dry and reverb send signals
  a1, a2 sbus_read 0
  a3, a4 sbus_read 1
  
  al, ar reverbsc a3, a4, xchan:k("Reverb.fb", 0.65), xchan:k("Reverb.cut", 12000)
  
  a1 = tanh(a1 + al)
  a2 = tanh(a2 + ar)
  
  out(a1, a2)
  
  sbus_clear(0)
  sbus_clear(1)
endin
start("Mixer")

opcode send_mix, 0,akk
  asig, kpan, krvb xin
   ;; Panning and send to mixer
  al, ar pan2 asig, kpan
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * krvb, ar * krvb)
endop

instr S1
  ifreq = p4
  iamp = p5
  ipan = 0.5
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp, ifreq * 1.5, 10)
  
  istart = rand(array(200, 500, 5000, 10000))
  
  iend = rand(array(200, 500, 5000, 10000))
  
  asig = zdf_ladder(asig, expon(istart, p3, iend), 5)
  
  asig *= linsegr(0, 0.02, 1, 0.02, 0) * iamp
  
  send_mix(asig, ipan, irvb)
endin
;;start("S1")
;;stop("S1")

instr R1
  schedule("S1", 0, p3* 0.5, in_scale(p4,rand(array(0, 2, 4,5))), ampdbfs(-15))
  schedule(p1, rand(array(0.25, 0.5, 1,2,4)) * p3, p3, p4)
endin

schedule("R1", 0, 2)
schedule("R1", 0, 4, -1)

instr P1
  hexplay("34028934029834092384",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12) * choose(0.7))

  if(p4 % 16 == 0 && choose(0.7) == 1) then
    schedule("BD", 0, p3, 0, ampdbfs(-6))
  endif
  
endin

instr S2
  ifreq = p4
  iamp = p5
  ipan = 0.5
  irvb = ampdbfs(-12)
  
  ;; Signal Generator
  asig = vco2(iamp, ifreq)
  asig += vco2(iamp, ifreq * 1.0023482384928374)
  asig += vco2(iamp, ifreq * 0.9999435345245435)  
  
  istart = rand(array(200, 500, 5000, 10000))
  
  iend = rand(array(200, 500, 5000, 10000))
  
  asig = zdf_ladder(asig, expon(istart, p3, iend), 5)
  
  asig *= linsegr(0, 0.02, 1, 0.02, 0) * iamp
  
  send_mix(asig, ipan, irvb)
endin

instr R2
  schedule("S2", 0, p3* 0.75, in_scale(p4,rand(array(0, 2, 4,5))), ampdbfs(-15))
  schedule(p1, rand(array(0.5, 1,2)) * p3, p3, p4)
endin

schedule("R2", 0, 4, -1)
schedule("R2", 0, 4, 0)


instr R3
  if(choose(0.8) == 1) then
    ipch = rand(array(0, 2, 4,5))
  	schedule("S2", 0, p3* 0.75, in_scale(p4,ipch), ampdbfs(-15))
	schedule("S2", 0, p3* 0.75, in_scale(p4,ipch + 2), ampdbfs(-15))
	schedule("S2", 0, p3* 0.75, in_scale(p4,ipch + 4), ampdbfs(-15))
  endif
  schedule(p1, p3, p3, p4)
endin
schedule("R3", 0, 4, 2)


