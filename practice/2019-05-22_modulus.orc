;; Author: Steven Yi
;; Title: Modulus 
;; 2019-05-22

start("ReverbMixer")

instr P1
  hexplay("cc8a",
      "Sub2", p3,
      in_scale(-1, 0),
      fade_out(5, 128) * ampdbfs(-12))

  hexplay("cc8a",
      "Sub1", p3,
      in_scale(0, 0),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("f",
      "Plk", p3,
      in_scale(1, xosc(phsb(1), array(0,4,7,11))),
      fade_in(12, 128) * ampdbfs(-12))

  hexplay("f",
      "Sub5", p3,
      in_scale(-2, (p4 % 3) * 7 + (p4 % 2) * 2 + (p4 % 5) * 4 + (p4 % 7) * 3),
      fade_in(10, 256) * ampdbfs(-15))

  hexplay("f",
      "Sub5", p3,
      in_scale(-1, 4 + (p4 % 3) * 7 + (p4 % 2) * 2 + (p4 % 5) * 4 + (p4 % 7) * 3),
      fade_in(14, 128) * ampdbfs(-15) * choose(0.5))

  hexplay("92000000",
      "SSaw", p3,
      in_scale(0, 0),
      fade_in(13, 128) * ampdbfs(-15))

endin

