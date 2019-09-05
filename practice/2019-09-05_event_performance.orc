; Author: Steven Yi
; Description: Schedule-based event performance setup
; Date: 2019-09-05

opcode unisine, a, kk
  kamp, kfreq xin
  asig = oscili:a(0.5, kfreq) + 0.5
  asig *= kamp
  
  xout asig
endop

start("ReverbMixer")
xchnset("Reverb.fb", 0.85)

instr S1
  asig = vco2(p5, p4)
  asig += vco2(p5, p4 * 0.9973423, 12)
  asig += vco2(p5* 0.5, p4 * 2.0010343423)
  
  
  asig = zdf_ladder(asig, 500 + rand(array(6000, 8000)) * unisine(1, expon(8, p3, 2)), 5)
  
  asig *= line(1, p3, 0)
  
  pan_verb_mix(asig, random:i(0.3, 0.7), 0.5)
endin

;; edit and eval below to "perform"
schedule("S1", 0, 10, in_scale(rand(array(-2, -1, 0, 1)), rand(array(0,2,4,6,8))), 0.5)

