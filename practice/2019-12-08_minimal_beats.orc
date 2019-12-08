;; Author: Steven Yi
;; Description: Minimal beats, mode experiments to work with sections of materials with bitshifts
;; Date: 2019-12-08

start("ReverbMixer")

xchnset("rvb.default", 0.3)
xchnset("drums.rvb.default", 0.2)

instr S1
  asig = mpulse(1, 0)
  asig = zdf_2pole(asig, p4, 2, 3)
  asig *= p5
  pan_verb_mix(asig, 0.5, 0.75)
endin

instr S2
  asig = vco2(p5, p4, 10)
  asig *= expseg:a(1, 0.1, 0.001, p3, 0.0001)
  asig *= 0.5
  pan_verb_mix(asig, 0.5, 0.5)
endin

instr S3
  asig = vco2(p5, p4, 12)
  asig = vco2(p5 * .5, p4 * 2.012423423, 12)  
  asig *= expseg:a(1, 0.1, 0.001, p3, 0.0001)
  pan_verb_mix(asig, 0.5, 0.5)
endin

schedule("S1", 0, 2)

instr P1
  
  ;imode = 3
  imode = (p4 >> (p4 & 0x3)) % 5
  
  if(imode & 1 == 1) then
    hexplay("88c8c88a",
        "S1", p3,
        2000,
        fade_in(5, 128) * ampdbfs(-12))

    hexplay("de2834",
        "S1", p3,
        1177,
        fade_in(5, 128) * ampdbfs(-12))
  endif
    
  if(imode & 2 == 2) then
    hexplay("0200",
        "S2", p3,
        in_scale(1, 0),
        fade_in(7, 128) * ampdbfs(-21))

    hexplay("00f0f0000",
        "S3", p3,
        in_scale(1, 0),
        fade_in(8, 128) * ampdbfs(-12))
  endif

  hexplay("0008",
      "Clap", p3,
      in_scale(-1, 0),
      ampdbfs(-12))
  
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))
  
endin
