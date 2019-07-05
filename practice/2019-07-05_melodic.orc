; Author: Steven Yi
; Description: Melodic, Rhythms 
; Date: 2019-07-05

start("ReverbMixer")

chnset(0.6, "Sub6.rvb")
chnset(0.6, "Sub7.rvb")

opcode melodic, iii, ik[]k[]k[]
  itick, kdurs[], kpchs[], kamps[] xin

  idur = dur_seq(itick, kdurs)
  ipch = 0
  iamp = 0

  indx = 0
  itotal = 0
  ilen = lenarray:i(kdurs)

  while (indx < ilen) do
    itotal += abs:i(i(kdurs, indx))
    indx += 1
  od

  itick = itick % itotal

  if(idur > 0) then
    indx = 0
    icur = 0
    ivalindx = 0

    while (indx < ilen) do
      itemp = i(kdurs, indx) 

      if(icur == itick) then
        indx += ilen
      elseif (icur > itick) then
        indx += ilen 
      else
        if (itemp > 0) then
          ivalindx += 1 
        endif

        icur += abs(itemp)
      endif
      
      indx += 1
    od

    ipch = i(kpchs, ivalindx % lenarray:i(kpchs))
    iamp = i(kamps, ivalindx % lenarray:i(kamps))
  endif

  xout idur, ipch, iamp
endop

opcode melodic, iii, k[]k[]k[]
  kdurs[], kpchs[], kamps[] xin
  idur, ipch, iamp = melodic(now_tick(), kdurs, kpchs, kamps)
  xout idur, ipch, iamp
endop

set_scale("maj")
instr P1
  idur, ipch, iamp = melodic(array(3,1,-2,2), array(2,1), array(-12))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(0, ipch), ampdbfs(iamp))
  endif

  idur, ipch, iamp = melodic(array(16,-2,1,-1,-2,2), array(4), array(-7))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(0, ipch), ampdbfs(iamp))
  endif

  hexplay("f8000000", 
      "Sub5", p3,
      in_scale(-1, xoscb(2, array(0,4,7,11,14,14,14,14))),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("02aaaaaa", 
      "SynBrass", p3,
      in_scale(0, 2),
      fade_in(6, 128) * ampdbfs(-9))

  idur, ipch, iamp = melodic(array(7,-1,1,1,-2), array(4), array(-9))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(-2, (p4 >> (p4 & 0x17)) % 4), ampdbfs(iamp))
  endif


  chnset(random:i(0.2, 0.8), "Mode1.pan")
  hexplay("f27", 
      "Mode1", p3,
      in_scale(1, 4),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("f27b193", 
      "Mode1", p3,
      in_scale(1, 6),
      fade_in(9, 128) * ampdbfs(-12))

  chnset(random:i(0.3, 0.7), "Sub6.pan")
  hexplay("f", 
       "Sub6", p3,
       in_scale(1, (p4 >> (p4 & 0x13)) % 7),
       fade_in(11, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("f", 
       "Sub6", p3,
       in_scale(1, 4 + (p4 >> (p4 & 0x31)) % 7),
       fade_in(12, 128) * ampdbfs(-12) * choose(0.2))

  chnset(random:i(0.4, 0.6), "Sub7.pan")
  hexplay("f", 
      "Sub7", p3,
      in_scale(-1, ((p4 >> (p4 & 0x67)) % 7 ) * 2),
      fade_in(13, 128) * ampdbfs(-9))

endin

