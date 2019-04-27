;; Author: Steven Yi
;; Title: Ringmod+Noise|Beats 
;; 2019-04-19
 
instr Noi
  asig = random:a(-1, 1)
  
  a1 = zdf_ladder(vco2(1, p4, 10), p4 * 4, 1)
  a1 += zdf_2pole(asig, p4 * 1.7, 24.5, 2) * 0.5
  a1 += zdf_2pole(asig, p4 * 3.77, 24.5, 2) * 0.125
  
  a1 *= oscili(1, rand(array(400, 400)))
  
  asig = declick(a1) * p5 * .25
  
  out(asig, asig)
endin

instr S1
  asig = vco2(1, p4)
  asig += vco2(1, p4 * 1.002342034982308)
  asig += vco2(0.25, p4 * 2.002342034982308, 10)

  
  istart = rand(array(60, 600, 6000))
  iend = rand(array(60, 600, 6000))

  asig = zdf_ladder(asig, expon(istart, p3, iend), 4)
  asig *= p5 * 0.25
  
  al, ar pan2 asig, random:i(0.3, 0.7)
  
  out(al, ar)
endin

instr P1
  hexplay("9210945809",
      "Noi", p3,
      from_root(1, xosc(phsm(2), array(0,12,7))),
      fade_in(5, 128) * ampdbfs(-15) * choose(0.8))

  hexplay("f",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-3))

  hexplay("100e00c030012",
      "Sub5", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(-21))

  hexplay("08",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(11, 128) * ampdbfs(-12))

  if(choose(0.2) == 1) then
      schedule("S1", 0, p3 * rand(array(1,2,4)),
      in_scale(-1, rand(array(0,1,2,3))),
      fade_in(13, 128) * ampdbfs(-12))
  endif 

  hexplay("c000c00f",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))

endin
