;; Author: Steven Yi
;; Date: 2022-11-12
;; Description: Modular

start("ReverbMixer")
xchnset("Reverb.fb", 0.95)

instr S1
  kfreq = 440 * semitone(oscil(1.1, array(0,7,3,4,11,9,12)))

  kamp = oscil(1, array(0,1,0,0,1,0,1,0))
  asig = vco2(.5 * kamp, kfreq)

  asig = zdf_ladder(asig, port(8000 * semitone(oscil(.3, array(0,4,7,12,4,7,3))), .1), .5)

  pan_verb_mix(asig, 0.5, 0.25)
endin
start("S1")


instr S2
  kfreq = 660 * semitone(oscil(5, array(0,4,2,3,7)))

  kamp = oscil(1, array(1,1,0,0,1,0,1,0))
  kamp *= oscil(4, array(1,1,0,0,1,0,1,0,1,0,0,0))
  
  kamp = port(kamp, 0.001)
  kamp *= kamp
  asig = vco2(.2 * kamp, kfreq)

  kcut = port(5000 * semitone(lfo:k(12, .377)), .1)
  asig = spf(asig, a(0), a(0), kcut, 0.5)

  pan_verb_mix(asig, 0, 0.25)
endin
start("S2")

instr S3
  kfreq = 330 * semitone(lfo(.025, .25))

  kamp = oscil(.2, array(1,0,0,1, 0))
  asig = vco2(.5 * kamp, kfreq)

  asig = K35_lpf(asig, 4000 * semitone(lfo(12, .2)), .5)

  pan_verb_mix(asig, 1, 0.25)
endin
start("S3")

instr S4
  ifreq = rand(array(100, 200, 400, 600, 800))
  asig = vco2(.5, ifreq, 2, line(.4, p3, .25))
  asig += vco2(.5, ifreq * 2, 2, .4)

  asig *= .5

  asig = K35_lpf(asig, 4000 * semitone(lfo(12, .2)), .5)

  pan_verb_mix(asig, 0, 0.25)

  schedule(p1, rand(array(1,2,2,4)) * .5, 1)
endin
schedule("S4", 0, 1)

