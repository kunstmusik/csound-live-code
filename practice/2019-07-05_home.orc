; Author: Steven Yi
; Description: At Home...
; Date: 2019-07-05

start("ReverbMixer")

set_tempo(96)
set_scale("maj")

chnset(0.5, "Sub2.rvb")
chnset(0.6, "Sub6.rvb")
chnset(0.5, "Sub7.rvb")

gi_organ1 = ftgen(0, 0, 65536, 10, 1, 0.5, 0.3, 0.1)
instr Organ1
  asig = oscili(p5, p4, gi_organ1)
  asig *= 0.5
  asig = declick(asig)
  pan_verb_mix(asig, 0.5, 0.4)
endin

instr P1

  hexplay("8008", 
      "Organ2", p3 * 4,
      in_scale(-1, xoscb(4, array(0,0,0,1))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3,
      in_scale(0, (p4 >> (p4 & 0xd)) % 7),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("a", 
      "Organ2", p3,
      in_scale(0, 2 + (p4 >> (p4 & 0xd)) % 7),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("888888000000000000", 
      "Sub7", p3 * 3,
      in_scale(-1, xoscb(6, array(0,4,7,11,14,18))),
      fade_in(7, 128) * ampdbfs(-18))

  hexplay("f", 
      "Sub6", p3 * 2,
      in_scale(0, (p4 >> (p4 & 0xd)) % 7),
      fade_in(7, 128) * ampdbfs(-18) * choose(0.2))

  hexplay("f", 
      "Sub6", p3 * 2,
      in_scale(0, 4 + (p4 >> (p4 & 0xd)) % 7),
      fade_in(7, 128) * ampdbfs(-18) * choose(0.2))

  hexplay("a00000002", 
      "Sub2", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("8", 
      "SynBrass", p3,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(xoscm(8, array(-20, -16))))

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 4),
      fade_in(10, 128) * ampdbfs(xoscim(7.7, array(-24, -14))))

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 6),
      fade_in(11, 128) * ampdbfs(xoscim(7.5, array(-24, -14))))

  idur = dur_seq(array(8, -24))
  if(idur > 0) then
      schedule("Organ1", 0, ticks(idur), in_scale(1, 0), ampdbfs(-18))
  endif

  hexplay("f", 
      "Organ1", p3 * 2,
      in_scale(1, 4 + (p4 >> (p4 & 0xd)) % 7),
      fade_in(7, 128) * ampdbfs(-18) * choose(0.2))

  hexplay("f", 
      "Organ1", p3 * 2,
      in_scale(2, (p4 >> (p4 & 0xd)) % 4),
      fade_in(7, 128) * ampdbfs(-18) * choose(0.2))

endin

instr Auto 
  Schan = p4
  istart = p5
  iend = p6
  itype = p7

  chnset(line(istart, p3, iend), Schan)
endin

;schedule("Auto", 0, 20, "Mix.amp", 1, 0)


