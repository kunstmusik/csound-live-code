;; Author: Steven Yi
;; Title: Sequence 
;; 2019-03-12

instr Mixer
  a1,a2 sbus_read 0
  a3,a4 sbus_read 1
  
  arl, arr reverbsc a3, a4, 0.8, 12000
  
  a1 = tanh(a1 + arl)
  a2 = tanh(a2 + arr)
  
  out(a1, a2)
  sbus_clear(0)
  sbus_clear(1)
  
endin
start("Mixer")

instr S1
  iamp = ampdbfs(-12)
  ipch = in_scale(-2, 0)
  asig = vco2(iamp, ipch)
  asig += vco2(iamp, ipch * 1.0037)
  asig += vco2(iamp * 0.25, ipch * 2.0037, 10)
  
  
  
  klfo = lfo(0.4, 4) + 0.5
  
  asig *= vco2(0.5, 0.2, 10) + 0.5
  asig *= vco2(0.5, 4.17, 10) + 0.5
  asig *= vco2(0.5, 9.17, 10) + 0.5

  asig = zdf_ladder(asig, 8000 * klfo, 7 * klfo)

  
  arl = asig * ampdbfs(-12)
  sbus_mix(0, asig, asig)
  sbus_mix(1, arl, arl)
  
endin
start("S1")


instr S2
  iamp = ampdbfs(-12)
  ipch = in_scale(-2, 0)
  asig = vco2(iamp, ipch, 10)
  asig += vco2(iamp, ipch * 1.0037)
  asig += vco2(iamp * 0.25, ipch * 2.0037, 10)
  
  klfo = lfo(0.4, 4) + 0.5
  
  asig *= vco2(0.5, 0.13, 10) + 0.5
  asig *= vco2(0.5, 3.17, 10) + 0.5
  asig *= vco2(0.5, 7.17, 10) + 0.5

  asig = zdf_ladder(asig, 8000 * klfo, 7 * klfo)

  
  arl = asig * ampdbfs(-12)
  sbus_mix(0, asig, asig)
  sbus_mix(1, arl, arl)
  
endin
start("S2")


instr S3
  iamp = ampdbfs(-18)
  ipch = in_scale(1, 0)
  asig = vco2(iamp, ipch)
  asig += vco2(iamp, ipch * 1.0037)
  asig += vco2(iamp * 0.25, ipch * 2.0037, 10)
  
  ifreq = 0.1
  asig *= vco2(0.5, ifreq, 10) + 0.5
  asig *= phasor(ifreq * 2)

  asig = zdf_ladder(asig, 12000, 3)

  
  arl = asig * ampdbfs(-12)
  sbus_mix(0, asig, asig)
  sbus_mix(1, arl, arl)
  
endin
start("S3")

instr S4
  iamp = ampdbfs(-18)
  ipch = in_scale(0, 0)
  asig = vco2(iamp, ipch)
  asig += vco2(iamp, ipch * 1.0037)
  asig += vco2(iamp * 0.25, ipch * 2.0037, 10)
  
  ifreq = 0.063
  asig *= vco2(0.5, ifreq, 10) + 0.5
  asig *= phasor(ifreq * 2)

  asig = zdf_ladder(asig, 12000, 3)

  
  arl = asig * ampdbfs(-12)
  sbus_mix(0, asig, asig)
  sbus_mix(1, arl, arl)
  
endin
start("S4")

instr S5
  iamp = ampdbfs(-18)
  kpch = in_scale(0, oscil(3.7, array(4,2,3)))
  asig = vco2(iamp, kpch)
  asig += vco2(iamp, kpch * 1.0037)
  asig += vco2(iamp * 0.25, kpch * 2.0037, 10)
  asig += vco2(iamp * 0.55, kpch * 4.0037)
  
  ifreq = 0.12
  asig *= vco2(0.5, ifreq, 10) + 0.5

  asig = zdf_ladder(asig, 12000, 3)

  
  arl = asig * ampdbfs(-12)
  sbus_mix(0, asig, asig)
  sbus_mix(1, arl, arl)
  
endin
start("S5")

instr S6
  iamp = ampdbfs(-18)
  kpch = in_scale(2, oscil(8.13, array(0,7,4)))
  asig = vco2(iamp, kpch)
  asig += vco2(iamp, kpch * 1.0037)
  asig += vco2(iamp * 0.25, kpch * 2.0037, 10)
  asig += vco2(iamp * 0.55, kpch * 4.0037)
  
  ifreq = 0.8
  asig *= vco2(0.5, ifreq, 2, 0.25) + 0.5

  asig = zdf_ladder(asig, 12000, 3)

  
  arl = asig * ampdbfs(-12)
  sbus_mix(0, asig, asig)
  sbus_mix(1, arl, arl)
  
endin
start("S6")

instr P1
  hexplay("120234029834",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.7))
  
  hexplay("000800808000800008",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-6))

  hexplay("8080800",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-9))
endin


