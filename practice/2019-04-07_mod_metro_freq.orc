;; Author: Steven Yi
;; Title: Modulating metro and pitches 
;; 2019-04-07


instr R1
  ksig = metro(2.1 + lfo(0.25, 0.05))
  kfreq = 60 + 20 * (oscili(0.5, 0.454354) + 0.5)
  krand = random:k(0, 1.0)
  if(ksig == 1 && krand > 0.3) then
    event("i", "Sine", 0, 2, cpsmidinn(int(kfreq)), ampdbfs(-18))
  endif
endin

start("R1")

instr R2
  ksig = metro(2.1 + lfo(0.25, 0.05))
  kfreq = 73 + 20 * (oscili(0.5, 0.454354) + 0.5)
  krand = random:k(0, 1.0)
  if(ksig == 1 && krand > 0.3) then
    event("i", "Sine", 0, 2, cpsmidinn(int(kfreq)), ampdbfs(-18))
  endif
endin

start("R2")
