; Author: Steven Yi
; Title: Melodic line explorations
; Date: 2019-06-08

/** Melodic line performance method. Array given has period in ticks, then sets of four values for start, dur, freq, amp. 
    Experimental: not sure how easy this is to use in this setting. In Clojure, I might have made further utility functions thats
    map conversion functions over the pitch and amplitude values or other tools. Need to ponder on this one a bit. */
opcode melodic, 0, Sk[]
  Sinstr, kmel[] xin
  idur = i(kmel, 0)
  icount = lenarray:i(kmel)
  itick = now_tick() % idur
  
  indx = 1
  while (indx < icount) do
    if(i(kmel, indx) == itick) then
      schedule(Sinstr, 0, i(kmel, indx + 1), i(kmel, indx + 2), i(kmel, indx + 3)) 
    endif
    indx += 4
  od
endop
  
chnset(1, "BD.decay")

instr P1
  hexplay("8",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-6))

  hexplay("2aaaaaaa",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(xlin(phsm(4), -15, -30)))

  hexplay("80020000",
      "Sub2", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))
 
  ;; this modulation of the period is very interesting... 
  melodic("FM1", array(xoscm(1, array(8,4,2,6)), 
    					0, ticks(1), in_scale(-2, 0), ampdbfs(-12),
    					1, ticks(1), in_scale(-2, 2), ampdbfs(-12),
    				    2, ticks(3), in_scale(-2, 1), ampdbfs(-12)))

endin
