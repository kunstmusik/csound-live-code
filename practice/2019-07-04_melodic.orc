; Author: Steven Yi
; Description: Experiments with array-based melodic writing 
; Date: 2019-07-04

start("ReverbMixer")

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

instr P1
  idur, ipch, iamp = melodic(array(12,-2,6,-2,3,-2,1,1,-7), array(0,4,2,3,7), array(-12, -15))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(0, ipch), ampdbfs(iamp))
  endif

  idur, ipch, iamp = melodic(array(1,-3,1,1,-2,4,-12), array(2,2,3,2), array(-12,-11,-10,-8))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(1, ipch), ampdbfs(iamp))
  endif

  idur, ipch, iamp = melodic(array(1,3,1,5,1,7,9,-23), array(0,1,0,2,0,3,0,4), array(-12))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(1, 4 + ipch), ampdbfs(iamp))
  endif

  idur, ipch, iamp = melodic(array(3,3,3,3,3,17,-23), array(7,5,4,3,2,0), array(-12))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(1, 4 + ipch), ampdbfs(iamp))
  endif

  idur, ipch, iamp = melodic(array(4,3,3,3,3,17,-23), array(7,5,4,3,2,0), array(-12))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(1, 6 + ipch), ampdbfs(iamp))
  endif

  hexplay("90000000", 
      "Organ2", p3 * xoscb(1, array(3,1)),
      in_scale(-2, 2),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f", 
      "Sub5", p3,
      in_scale(0, 2 + (p4 >> (p4 & 0x7)) % 4 + (p4 >> (p4 & 0x5)) % 3),
      fade_in(6, 128) * ampdbfs(-12) * choose(0.2))

  hexplay("92009226", 
      "Sub6", p3,
      in_scale(0, 4 + (p4 >> (p4 & 0x7)) % 4 + (p4 >> (p4 & 0x5)) % 3),
      fade_in(6, 128) * ampdbfs(-18))

  imod = xoscm(8, array(0,2))
  hexplay("aa000000", 
      "SSaw", p3 * 1.5,
      in_scale(0, imod + xoscb(2, array(0,0,0,1))),
      fade_in(7, 128) * ampdbfs(-18))

  hexplay("aa000000", 
      "SSaw", p3 * 1.5,
      in_scale(0, imod + 2 + xoscb(2, array(0,0,0,1))),
      fade_in(7, 128) * ampdbfs(-18))

endin
