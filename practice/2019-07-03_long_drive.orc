; Author: Steven Yi
; Description: A long drive across the country...
; Date: 2019-07-03 

start("ReverbMixer")

set_tempo(108)

instr P1

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(-1, xoscb(5, array(0,2,4,7,9))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(-1, 4 + xoscb(5, array(0,2,4,7,9))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(0, 2 + xoscb(3, array(4,5,6))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(1, xoscb(7, array(4,5,6,5,6,5,4))),
      fade_in(9, 128) * ampdbfs(-12))


  if(p4 % 128 == 0) then
    cause("VoxHumana", 0, measures(3.5), in_scale(2,2), ampdbfs(-12))
    cause("VoxHumana", 0, measures(3.5), in_scale(2,4), ampdbfs(-12))
  endif

  if(p4 % 4 == 0) then
    iamp = xoscim(8, array(-30, -27))
    cause("SSaw", 0, beats(0.5), in_scale(2,2), ampdbfs(iamp))
    cause("SSaw", 0, beats(0.5), in_scale(2,4), ampdbfs(iamp))
  endif

  hexplay("800a", 
      "Organ2", p3 * 2,
      in_scale(-1, (p4 % 16) == 12 ? 3 : 2),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a000", 
      "Organ2", p3 * 2,
      in_scale(0, xoscb(1, array(1,0))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("08888888", 
      "Organ2", p3 * 4,
      in_scale(0, xoscim(2, array(2,4))),
      fade_in(7, 128) * ampdbfs(-12))

endin
