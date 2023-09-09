;; Author: Steven Yi
;; Date: 2023-09-09
;; Description: Triangle bells with tremolo 

start("ReverbMixer")
set_tempo(120)
set_scale("min")

xchnset("Reverb.fb", .95)

instr Bell
  asig = vco2(p5, p4, 12)
  asig *= (1 + linseg(0, .35, 0, .1, 1, p3, 1) * oscili(0.2, 3.7)) ;; tremolo with delay onset
  asig *= transegr:a(0, .002, 0, 1, 3, -4.2, 0, 3, -4.2, 0) ;; bell envelope

  pan_verb_mix(asig, 0.5, 0.2)
endin

;; callback instrument for csound-live-code
instr P1 

  hexplay("88888000",
      "Bell", p3,
      in_scale(0, xoscim(4.5, array(0,4,2,3))),
      fade_in(5, 128) * ampdbfs(-12))

   hexplay("80808000",
      "Bell", p3,
      in_scale(1, xoscim(5.5, array(0,4,2,3))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("ea81fa80",
      "Bell", p3,
      in_scale(2, cycle(p4, array(0,4,2,3,1,5))),
      fade_in(6, 128) * ampdbfs(-18))

  hexplay("f",
      "Bell", p3,
      in_scale(3, cycle(p4, array(0,4,2,3,1,5))),
      fade_in(7, 128) * ampdbfs(-24))


endin

