;; reset_clock()
set_tempo(120)
set_scale("min")

;; callback instrument for csound-live-code
instr P1 

  hexplay("90", 
      "Claves", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-3))

  hexplay("0808080c", 
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("2",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("0200", 
      "Sub5", p3,
      in_scale(2, 2),
      fade_in(7, 128) * ampdbfs(-12))

endin


;; custom instruments
instr Up
  indx = 0
  istart = int(random:i(-4, 4))
  irange = 12
  while (indx < irange) do
    schedule("Sub5", ticks(indx), ticks(1), in_scale(-1, istart + indx), ampdbfs(-12 - indx))
    indx += 1
  od
endin

;; temporal recursion process
instr Run
  irange = 8
  ibase = int(random(-irange, irange))
  schedule("Sub1", 0, ticks(1), in_scale(0, ibase), ampdbfs(-12))
  
  schedule("Sub5", 0, ticks(1), in_scale(0, xcos(phsm(4), ibase, 8)), ampdbfs(-12))

  if(choose(0.3) == 1) then
    schedule("Sub4", 0, ticks(1), in_scale(1, xcos(phsm(2.5), ibase, 4)), ampdbfs(-12))
  endif

  if(choose(0.5) == 1) then
    schedule("SynBrass", 0, ticks(2), in_scale(1, ibase + rand(array(0,2,4))), ampdbfs(-12))
  endif
  
  if(choose(0.25) == 1) then
  	schedule("Sub1", 0, ticks(1), in_scale(0, ibase + 2), ampdbfs(-12))
  endif
  
  if(choose(0.15) == 1) then
  	schedule("Up", 0, 1)
  endif
    
  schedule(p1, next_beat(rand(array(1,2,4,8)) * 0.25), 1)
endin

;; starts the process, be careful not to evaluate multiple times for this example
schedule("Run", 0, 1)


;; temporal recursion process
instr Run2
  if(choose(0.7) == 1) then
    isd = random(-8, 8)
    schedule("Sub3", 0, beats(random(6,8)), in_scale(2, isd), ampdbfs(-22))
    schedule("Sub3", 0, beats(random(6,8)), in_scale(2, isd + 4), ampdbfs(-22))
  endif

  schedule("FM1", 0, ticks(1), in_scale(-2, rand(array(0,2,4))), ampdbfs(-18))

  schedule(p1, next_beat(rand(array(1,2,4,8))), 1)
endin


;; starts the process, be careful not to evaluate multiple times for this example
schedule("Run2", 0, 1)
