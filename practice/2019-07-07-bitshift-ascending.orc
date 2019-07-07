; Author: Steven Yi
; Description: Bitshift rhythms and melodic lines, ascending lines 
; Date: 2019-07-07

start("ReverbMixer")

chnset(0.6, "Sub6.rvb")
chnset(0.6, "Sub7.rvb")

set_scale("maj")

instr P1

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, (p4 >> (p4 & 0x2)) & 4),
      fade_in(6, 128) * ampdbfs(-15))

  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 2 + (p4 >> (p4 & 0x2)) & 5),
      fade_in(7, 128) * ampdbfs(-15))

  hexplay("f", 
      "Sub5", p3,
      in_scale(-1, 0 + (p4 >> (p4 & 0x5)) & 4),
      fade_in(10, 128) * ampdbfs(-15))

  hexplay("a", 
      "Sub5", p3 * 2,
      in_scale(1, 2 + (p4 >> (p4 & 0x5)) & 4),
      fade_in(11, 128) * ampdbfs(-12))

  hexplay("c000", 
      "Mode1", p3,
      in_scale(0, 0),
      fade_in(15, 128) * ampdbfs(xoscim(8, array(-22, -15))))
  
  if((p4 >> (p4 & 0x7)) & 2 == 2) then
    ibase = xoscm(2, array(0, 0, 4)) 

    chnset(random:i(0.2, 0.8), "Plk.pan")
    schedule("Plk", 0, p3, in_scale(1, ibase), ampdbfs(-12))
    schedule("Plk", 0, p3, in_scale(1, ibase + 4), ampdbfs(-12))
  endif

  if((p4 >> (p4 & 0xb)) & 1 == 1) then
    ibase = xlin(phsm(8), 0, 12) 
    schedule("Sub2", 0, p3, in_scale(-1, ibase), ampdbfs(-12))
    schedule("Sub2", 0, p3, in_scale(-1, ibase + 4), ampdbfs(-12))
  endif

  if((p4 >> (p4 & 0x3)) & 1 == 1) then
    schedule("SynBrass", 0, p3, in_scale(2, 0), ampdbfs(-12))
    schedule("SynBrass", 0, p3, in_scale(2, 4), ampdbfs(-12))
  endif

  if((p4 >> (p4 & 0x37)) & 1 == 1) then
    ibase = rand(array(0,2,4,6))
    schedule("Sub6", 0, p3, in_scale(1, ibase), ampdbfs(-15))
    schedule("Sub6", 0, p3, in_scale(1, 2 + ibase), ampdbfs(-15))
  endif

  chnset(random:i(0.2, 0.8), "Sub7.pan")
  if((p4 >> (p4 & 0x73)) & 1 == 1) then
    ibase = rand(array(0,2,4,6))
    schedule("Sub7", 0, p3, in_scale(2, ibase), ampdbfs(-15))
    schedule("Sub7", 0, p3, in_scale(2, 2 + ibase), ampdbfs(-15))
  endif

  hexplay("8000", 
      "VoxHumana", p3 * 15,
      in_scale(2, xoscm(8, array(0,1,2,3,4,5,6,7))),
      fade_in(13, 128) * ampdbfs(-10))

  hexplay("800", 
      "VoxHumana", p3 * 11,
      in_scale(2, 2 + xoscb(24, array(0,1,2,3,4,5,6,7))),
      fade_in(13, 128) * ampdbfs(-10))

  hexplay("80000", 
      "VoxHumana", p3 * 19,
      in_scale(2, 4 + xoscb(40, array(0,1,2,3,4,5,6,7))),
      fade_in(13, 128) * ampdbfs(-10))

  if(p4 % 64 == 1) then
    schedule("Sub5", 0, measures(3.7), in_scale(-2, 0), ampdbfs(-6))
  endif

endin
