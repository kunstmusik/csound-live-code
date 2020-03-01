;; Author: Steven Yi
;; Description: Ambient
;; Date: 2020.03.01

start("ReverbMixer")

instr S1
  p3 *= 1.5
  asig = vco2(1, p4)
  asig += vco2(0.5, p4 * 2.001342340234)
  asig += vco2(0.25, p4 * 1.50234234234)  
  
  asig = zdf_ladder(asig, cpsoct(linseg(10, 4, 5, 1, 5)), 6)
  
  asig *= 0.6
  asig *= linen:a(p5, 0.01, p3, .01)
  pan_verb_mix(asig, 0.4, 0.5)
endin

instr S2
  asig = vco2(1, p4, 10)
  asig += vco2(1, p4 * 0.99934234234, 10)  
  asig += vco2(0.5, p4 * 2.001342340234)
  
  asig = zdf_ladder(asig, cpsoct(linseg(10, 4, 5, 1, 4)), 6)
  
  asig *= 0.4
  asig *= linen:a(p5, 0.01, p3, .01)
  pan_verb_mix(asig, 0.5, 0.7)
endin

instr S3
  klfo = semitone(oscili:k(.2, 1.734))
  asig = vco2(1, p4 * klfo)
  asig += vco2(0.25, klfo * p4 * 2.001342340234)
  asig += vco2(0.5, klfo * p4 * 1.50234234234)  
  
  asig = zdf_ladder(asig, cpsoct(linseg(7, p3/2, 11, p3/2, 7)), 6)

  asig *= 0.4
  asig *= linen:a(p5, 0.01, p3, .01)
  pan_verb_mix(asig, random:i(0.2, 0.8), 0.3)
endin

schedule("S3", 0, 10, in_scale(rand(array(0, 1)), rand(array(0,2,4,6,8))), 0.5)

instr R1
  kvals[] = fillarray(0,2,4, -1)
  ival = cycle(p4, kvals)
  
  if(ival >= 0) then
   schedule("S1", 0, p3, in_scale(0, ival), ampdbfs(-12))
  else 
    p3 += random:i(-0.1, 0.1)
  endif
  
  schedule(p1, p3, p3, p4 + 1)
endin

schedule("R1", 0, 5.7)


instr R2
  kvals[] = fillarray(5,4,-1,2)
  ival = cycle(p4, kvals)
  
  if(ival >= 0) then
  schedule("S2", 0, p3, in_scale(0, ival), ampdbfs(-12))
      else 
    p3 += random:i(-0.1, 0.1)

  endif
  
  schedule(p1, p3, p3, p4 + 1)
endin

schedule("R2", 0, 5.7)

instr R3
  kvals[] = fillarray(3,1,2,2,-1,-1)
  ival = cycle(p4, kvals)
  
  if(ival >= 0) then
  schedule("S2", 0, p3, in_scale(-1, ival), ampdbfs(-12))
      else 
    p3 += random:i(-0.1, 0.1)
  endif
  
  schedule(p1, p3, p3, p4 + 1)
endin

schedule("R3", 0, 4.77)

instr R4
  kvals[] = fillarray(6,7,8,9,8,7,8,7)
  ival = cycle(p4, kvals)
  
  if(ival >= 0) then
	schedule("S2", 0, p3, in_scale(0, ival), ampdbfs(-12))
  else 
    p3 += random:i(-0.1, 0.1)    
  endif
  
  schedule(p1, p3, p3, p4 + 1)
endin

schedule("R4", 0, 5.1034)

set_tempo(128)

instr P1
  iv = ((p4 << 1) | (p4 << 2)) % 64 % 29 % 5
  hexplay("f",
      "Organ3", p3,
      in_scale(1, iv),
      fade_in(5, 128) * ampdbfs(-30))
  
  iv = ((p4 << 2) | (p4 << 3)) % 64 % 23 % 5
  hexplay("f",
      "Organ3", p3,
      in_scale(0, iv),
      fade_in(6, 128) * ampdbfs(-27))

endin
