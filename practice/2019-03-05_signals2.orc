;; Author: Steven Yi
;; Title: Signals 2
;; 2019-03-05 

instr Mixer 
  a0,a1 sbus_read 0
  a2,a3 sbus_read 1
  
  a2, a3 reverbsc a2,a3, 0.7, 2000
  
  out(a0 + a2, a1 + a3)
  
  sbus_clear(0)
  sbus_clear(1)
  
endin
start("Mixer")

instr S1
  asig = vco2(1, 60)
  
;   asig *= vco2(0.5, 1/4, 10) + 0.5
  asig *= vco2(0.5, 2.1, 10) + 0.5 
  asig *= vco2(0.5, 3.77, 10) + 0.5
  
  a1 = zdf_ladder(asig, xchan:k("S1.cut", 4000), xchan:k("S1.res", 5))
  a2 = zdf_2pole(asig, xchan:k("S1.center", 400), xchan:k("S1.res2", 10), 3)
  
  asig = a1 + a2
  
  al, ar pan2 asig, xchan:k("S1.pan", 0.2)
  irvb = ampdbfs(-8)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
 
endin
start("S1")

chnset(0.5, "S1.pan")
chnset(1000, "S1.cut")

instr Mod
  chnset(lfo(100, 0.25) + 300, "S1.center")
  chnset(lfo(2500, 0.5) + 3000, "S1.cut")
  chnset(lfo(0.4, 0.5) + 0.5, "S3.pan")
  chnset(lfo(0.5, 0.5, 0.3) + 0.25, "S4.pan")
endin
start("Mod")

instr P1
  if(hexbeat("f0") == 1) then
    chnset(rand(array(0.25, 0.5,0.75)), "S1.pan")
  endif
      
  hexplay("20349820384029384",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-8) * choose(0.8))
endin


instr S2
  asig = vco2(1, 700)
  
  asig *= vco2(0.5, 0.8, 4, 0.5) + 0.5
  asig *= vco2(0.5, 11, 4, 0.5) + 0.5
    
  a1 = zdf_ladder(asig, xchan:k("S2.cut", 4000), xchan:k("S2.res", 5))
  a2 = zdf_2pole(asig, xchan:k("S2.center", 400), xchan:k("S2.res2", 10), 3)
  
  asig = a1 + a2
  
  al, ar pan2 asig, xchan:k("S2.pan", 0.5)
  irvb = ampdbfs(-8)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
 
endin
start("S2")

instr S3
  asig = vco2(1, 700)
  
  asig *= vco2(0.5, 12, 10, 0.5) + 0.5
  asig *= vco2(0.5, 1, 10, 0.5) + 0.5
    
  a1 = zdf_ladder(asig, xchan:k("S3.cut", 4000), xchan:k("S3.res", 5))
  a2 = zdf_2pole(asig, xchan:k("S3.center", 400), xchan:k("S3.res2", 10), 3)
  
  asig = a1 + a2
  
  al, ar pan2 asig, xchan:k("S3.pan", 0.5)
  irvb = ampdbfs(-8)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
 
endin
start("S3")

instr S4
  asig = vco2(1, 90, 10)
  
  asig *= vco2(0.5, 3, 10, 0.5) + 0.5
  asig *= vco2(0.5, 11, 10, 0.5) + 0.5
  asig *= vco2(0.5, 0.2, 10, 0.5) + 0.5
    
  asig = zdf_ladder(asig, xchan:k("S4.cut", 4000), xchan:k("S4.res", 5))
    
  al, ar pan2 asig, xchan:k("S4.pan", 0.5)
  irvb = ampdbfs(-8)
  
  sbus_mix(0, al, ar)
  sbus_mix(1, al * irvb, ar * irvb)
 
endin
start("S4")

