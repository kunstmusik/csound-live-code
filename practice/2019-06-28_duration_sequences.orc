; Author: Steven Yi
; Description: Continued experimenting with duration sequences
; Date: 2019-06-27

start("ReverbMixer")

set_tempo(118)

chnset(0.6, "Sub6.rvb")
chnset(0.8, "Sub7.rvb")

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
  idur = dur_seq(array(3,1,-2,1,3,-2,1,1,1))
  if(idur > 0) then
    cause("Organ2", 0, ticks(idur), in_scale(-2, xlin(phsm(2), 21, 0)), ampdbfs(-6))
    cause("Organ2", 0, ticks(idur), in_scale(-2, 4 + xlin(phsm(2), 21, 0)), ampdbfs(-6))
  endif

  idur = dur_seq(array(1,3,-2,1,1,1,3,1,-2))
  if(idur > 0) then
    cause("Sub5", 0, ticks(idur), in_scale(-1, xlin(phsm(1), 0, 14)), ampdbfs(-6))
  endif


  idur = dur_seq(array(1,2,1,6,3,-4,2,1,5,-3))
  if(idur > 0) then
    cause("Sub5", 0, ticks(idur), in_scale(-1, 1), ampdbfs(-16))
  endif

  idur = dur_seq(array(3,-4,2,1,5,-3,1,2,1,6))
  if(idur > 0) then
    cause("Mode1", 0, ticks(idur), in_scale(1, 4), ampdbfs(-12))
  endif

  idur = dur_seq(array(16, -4,4,8,-4))
  if(idur > 0) then
    cause("Organ2", 0, ticks(idur * 0.95), in_scale(0, 0), ampdbfs(-9))
  endif

  idur = dur_seq(array(1, 1, 4,2))
  if(idur > 0) then
    cause("Organ2", 0, ticks(idur * 0.95), in_scale(0, 4), ampdbfs(-12))
  endif

  idur = dur_seq(array(3,-1,2,-1,1,1,1,2,-3))
  if(idur > 0) then
    cause("Organ2", 0, ticks(idur * 0.95), in_scale(0, (p4 >> (p4 & 0x25)) % 7), ampdbfs(-6))
  endif

  idur = dur_seq(array(1,1,1,2,-3,3,-1,2,-1))
  if(idur > 0) then
    cause("Organ2", 0, ticks(idur * 0.95), in_scale(1, (p4 >> (p4 & 0x25)) % 4), ampdbfs(-6))
  endif

  hexplay("f", 
      "Sub6", p3 * 0.5,
      in_scale(0, 0),
      fade_in(5, 128) * ampdbfs(xlin(phsm(8), -12, -22)))

  if((p4 >> (p4 & 0x15)) & 1 == 1) then
    cause("Sub7", 0, p3, in_scale(2, (p4 >> (p4 & 0x52)) % 7), ampdbfs(-12))
    cause("Sub7", 0, p3, in_scale(2, 2 + (p4 >> (p4 & 0x52)) % 7), ampdbfs(-12))
  endif

  hexplay("f", 
      "Sine", p3,
      in_scale(1, rand(array(0,2,4,6))),
      fade_in(7, 128) * ampdbfs(-9))

  hexplay("80000080", 
      "VoxHumana", beats(xoscm(2, array(6,2))),
      in_scale(2, xoscm(2, array(0,1))),
      fade_in(9, 128) * ampdbfs(-12))


endin
