; Author: Steven Yi
; Description: Experimenting with duration sequences
; Date: 2019-06-27

start("ReverbMixer")

set_tempo(126)

;; experimenting with duration sequences...
opcode dur_seq, i, ik[]
  itick, kdurs[] xin
  ival = 0
  icur = 0
  ilen = lenarray:i(kdurs)
  itotal = 0

  indx = 0
  while (indx < ilen) do
    itotal += abs:i(i(kdurs, indx))
    indx += 1
  od

  ;print itotal

  indx = 0
  itick = itick % itotal

  while (indx < ilen) do
    itemp = i(kdurs, indx) 
    if(icur == itick) then
      ival = itemp 
      indx += ilen
    elseif (icur > itick) then
      indx += ilen 
    else
      icur += abs(itemp)
    endif
    
    indx += 1
  od
  xout ival 
endop


opcode dur_seq, i, k[]
  kdurs[] xin
  xout dur_seq(now_tick(), kdurs)
endop

/*print dur_seq(2, array(1,2))*/

instr P1

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(-1, xoscb(2, xoscm(8, array(-3, -2, 0, 2)) + array(0,4,7,11))),
      fade_in(6, 128) * ampdbfs(-12))
 
  idur = dur_seq(array(1,2,4,5,2,2,5,4,2,1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(0, 0), ampdbfs(-9))
  endif

  idur = dur_seq(array(2,2,-1,3,1,1,1,1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur), in_scale(0, 2), ampdbfs(-9))
  endif

  idur = dur_seq(array(7,8,1,4,12,3,1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur * 0.75), in_scale(-1, 6), ampdbfs(-12))
  endif

  idur = dur_seq(array(64, -32, 16,-16))
  if(idur > 0) then
    schedule("VoxHumana", 0, ticks(idur * 0.75), in_scale(2, 6), ampdbfs(-15))
    schedule("VoxHumana", 0, ticks(idur * 0.75), in_scale(2, 4), ampdbfs(-16))
    schedule("VoxHumana", 0, ticks(idur * 0.75), in_scale(2, 2), ampdbfs(-17))
  endif

  idur = dur_seq(array(2,1,-1,1,1,-1,1,1,1,-1,-1,1))
  if(idur > 0) then
    schedule("Organ2", 0, ticks(idur * 0.75), in_scale(1, 0), ampdbfs(-12))
    schedule("Organ2", 0, ticks(idur * 0.75), in_scale(1, 4), ampdbfs(-12))
    schedule("Organ2", 0, ticks(idur * 0.75), in_scale(1, 6), ampdbfs(-12))
  endif

  idur = dur_seq(array(1,-1,1,1,1,-1,-1,1,2,1,-1,1))
  if(idur > 0) then
    ibase = xoscb(8, array(0,1,2,0))
    schedule("Mode1", 0, ticks(idur * 0.75), in_scale(1, ibase), ampdbfs(-15))
    schedule("Mode1", 0, ticks(idur * 0.75), in_scale(1, ibase + 2), ampdbfs(-15))
    schedule("Mode1", 0, ticks(idur * 0.75), in_scale(1, ibase + 4), ampdbfs(-15))
  endif

endin
