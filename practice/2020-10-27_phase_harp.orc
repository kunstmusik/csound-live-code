;; Author: Steven Yi
;; Date: 2020.10.27
;; Description: Phase Harp Texture

start("ReverbMixer")
set_tempo(102)

xchnset("SynHarp.rvb", 0.5)
xchnset("Reverb.fb", 0.80)

instr P1
  
  xchnset("SynHarp.pan", random:i(0.2, 0.8))
  
  schedule(
      "SynHarp", xoscim(9.5, array(0,1)) * p3, p3 * 0.9,
      in_scale(2, 3),
      fade_in(11, 128) * ampdbfs(-15 - hexbeat("f8324234") * 6))
  
  schedule(
      "SynHarp", xoscim(9, array(0,1)) * p3, p3 * 0.9,
      in_scale(1, 8),
      fade_in(8, 128) * ampdbfs(-16 - hexbeat("f832423") * 6))
  
  schedule(
      "SynHarp", xoscim(7, array(0,1)) * p3, p3 * 0.9,
      in_scale(1, 6),
      fade_in(8, 128) * ampdbfs(-18))
  
  schedule(
      "SynHarp", xoscim(8, array(0,1)) * p3, p3 * 0.9,
      in_scale(1, 2),
      fade_in(8, 128) * ampdbfs(-18))
  
  schedule(
      "SynHarp", xoscim(8, array(1, 0)) * p3, p3 * 0.9,
      in_scale(1, 4),
      fade_in(8, 128) * ampdbfs(-18))
  
  schedule(
      "SynHarp", xoscim(6.5, array(1, 0)) * p3, p3 * 0.9,
      in_scale(2, hexbeat("42384") * 2),
      fade_in(8, 128) * ampdbfs(-18))

endin

