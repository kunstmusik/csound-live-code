; Author: Steven Yi
; Description: Minimalist Groove
; Date: 2019-07-13

start("ReverbMixer")

set_tempo(102)

chnset(0.6, "Sub6.rvb")
chnset(0.6, "Sub7.rvb")
chnset(0.3, "Mode1.rvb")
chnset(0.3, "Plk.rvb")
chnset(0.6, "Plk.pan")

instr Strum
  schedule("Plk", 0, ticks(1), in_scale(0, p4), ampdbfs(-9))
  if(p4 < p5) then
    schedule(p1, p3, p3, p4 + rand(array(1,2)), p5)
  endif
endin

instr S1
  asig = vco2(p5, expon(p4, p3, p4 * 0.25))
  asig += vco2(p5 * 0.5, expon(p4 * 2, p3, p4 * 0.5))
  asig = zdf_ladder(asig, expon(4000, p3, 100), 10)
  a1 = zdf_2pole(asig, 1000, 8, 3)
  a2 = zdf_2pole(asig, 5, 8, 3)
  asig = declick(asig + a1 + a2)
  pan_verb_mix(asig, 0.4, 0.4)
endin

instr P1

  hexplay("80000000", 
      "Organ1", p3 * 4,
      in_scale(-1, 4),
      fade_in(5, 128) * ampdbfs(-9))

  hexplay("80000000", 
      "Organ1", p3 * 4,
      in_scale(0, 1),
      fade_in(14, 128) * ampdbfs(-9))

  hexplay("80000000", 
      "Organ1", p3 * 4,
      in_scale(0, 6),
      fade_in(14, 128) * ampdbfs(-9))

  hexplay("f", 
      "Organ1", p3,
      in_scale(0, 4 + (p4 >> (p4 & 0x5)) % 4),
      fade_in(8, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("f", 
      "Organ1", p3,
      in_scale(0, 6 + (p4 >> (p4 & 0x5)) % 4),
      fade_in(9, 128) * ampdbfs(-12) * choose(0.2))

  if( (p4 >> (p4 & 0xb)) & 1 == 1) then
    schedule("Organ2", 0, p3, in_scale(-1, 4), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0xb)) & 3 == 3) then
    schedule("Organ2", 0, p3, in_scale(0, 3), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0xb)) & 2 == 2) then
    schedule("Organ2", 0, p3, in_scale(0, 1), ampdbfs(-12))
  endif

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 0),
      fade_in(7, 128) * ampdbfs(xoscim(8, array(-24, -18))))

  if( (p4 >> (p4 & 0x3)) & 1 == 1) then
    schedule("Mode1", 0, p3, in_scale(1, 2), ampdbfs(-15))
  endif

  if( (p4 >> (p4 & 0x3)) & 2 == 2) then
    schedule("Mode1", 0, p3, in_scale(1, 4), ampdbfs(-15))
  endif

  if( (p4 >> (p4 & 0x7)) & 1 == 1) then
    schedule("Mode1", 0, p3, in_scale(1, 6), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0x13)) & 1 == 1) then
    chnset(xoscim(8, array(0.3, 0.7)), "Sub6.pan")
    schedule("Sub6", 0, p3 * 0.7, in_scale(1, 0), ampdbfs(-12))
  endif

  if( (p4 >> (p4 & 0x11)) & 1 == 1) then
    chnset(xoscim(7.7, array(0.3, 0.7)), "Sub7.pan")
    schedule("Sub7", 0, p3 * 0.7, in_scale(1, 4), ampdbfs(-12))
  endif

  hexplay("f", 
      "Sub5", p3,
      in_scale(0, xoscb(1, array(0,4,7,4))),
      fade_in(11, 128) * ampdbfs(-12) * choose(0.5))

  hexplay("f", 
      "Sub5", p3,
      in_scale(0, xoscb(2, array(3,2))),
      fade_in(11, 128) * ampdbfs(-6) * choose(0.5))

  hexplay("f", 
      "Plk", p3,
      in_scale(1, (p4 >> (p4 & 0x7)) % 8),
      fade_in(12, 128) * ampdbfs(xoscim(8, array(-18, -12))))

  hexplay("f", 
      "Plk", p3,
      in_scale(0, (p4 >> (p4 & 0x13)) % 12),
      fade_in(13, 128) * ampdbfs(xoscim(7.8, array(-12, -9))))

  if (p4 % 64 == 0) then
    ibase = rand(array(0,4,8,12))
    schedule("Strum", 0, ticks(rand(array(0.25, 0.5, 1))), ibase + rand(array(2,4,6)), ibase + rand(array(12,14,16,18)))

    ;schedule("S1", 0, measures(2), in_scale(0, 0), ampdbfs(-12))
  endif

  /* idur = dur_seq(array(31, -1, 7, -1, 3, -1, 3, -1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(-2, xoscm(3, array(0,0,0,0,1,2,3))), ampdbfs(-6))
  endif */

endin
