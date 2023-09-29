;; Author: Steven Yi
;; Date: 2023-09-29
;; Description: Cascade FM, VCOs, Filter  

start("ReverbMixer")
xchnset("Reverb.fb", 0.80)

opcode mod_oscil, a, ka
    kindex, afreq xin
    xout oscili(kindex * afreq, afreq)
endop

instr Ex1
  amod = mod_oscil(7, a(p4 * 1.5))
  amod2 = mod_oscil(8, p4 * 2 + amod)
  asig = oscili(p5, p4 + amod)

;   asig *= lfo:a(.25, 11) + .75
  asig *= 0.5

  aenv = transegr:a(0, .0125, 1, 1, .5, -4.2, 0, .5, -4.2, 0)

  asig *= aenv  

  asig += oscili(p5, p4)
  asig += vco2(p5, p4)
  asig += vco2(p5 * .5, p4 * 1.5, 2, 0.35) 

  asig = butterhp(asig, p4 * .5)

  acut = cpsoct(limit(aenv * 5 + octcps(p4), 4, 14))

  asig = zdf_ladder(asig, acut , 0.5)

  asig *= aenv 

  pan_verb_mix(asig, 0.5, ampdbfs(-9))

endin

instr Thread2
  if(p4 % 16 % 7 % 3 == 0) then
    schedule("Ex1", 0, p3, in_scale(1, 6), ampdbfs(-14))
  endif

  if(p4 % 32 % 11 % 7 == 0) then
    schedule("Ex1", 0, p3, in_scale(1, 4), ampdbfs(-14))
  endif

  if(p4 % 64 % 37 % 19 % 5 == 0) then
    schedule("Ex1", 0, p3, in_scale(2, 1), ampdbfs(-14))
  endif
endin

instr P1

  schedule("Thread2", 0, p3, p4)

  hexplay("a", "Ex1", p3, 
    in_scale(2, 1),
    ampdbfs(xlin(phsm(5.5), -16, -24)))

  hexplay("d", "Ex1", p3, 
    in_scale(2, 3),
    ampdbfs(xlin(phsm(8), -16, -24)))

  hexplay("f", "Ex1", p3, 
    in_scale(2, 4),
    ampdbfs(xoscim(8, array(-30, -14))))

  hexplay("f", "Ex1", p3, 
    in_scale(0, cycle(p4 % 107 % 73 % 37 % 13 + xoscim(5, array(0,5, 2, 8)), array(0,3,1,2,3,5,4,6,8))),
    ampdbfs(-12))

  hexplay("f", "Ex1", p3, 
    in_scale(1, cycle(p4 % 111 % 71 % 47 % 17 + xoscim(6, array(0,5, 2, 8)), array(0,3,1,2,3,5,4,6,8))),
    ampdbfs(-15))

  hexplay("f", "Ex1", p3, 
    in_scale(-1, cycle(p4 % 117 % 71 % 47 % 17 + xoscim(7, array(0,5, 2, 8)), array(0,3,1,2,3,5,4,6,8))),
    ampdbfs(-16))

  hexplay("f", "Ex1", p3, 
    in_scale(-2, cycle(p4 % 16, array(0,3,1,2,3,5,4,6,8))),
    ampdbfs(-12))

endin