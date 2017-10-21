/**
  Live Coding Functions
  Author: Steven Yi
*/ 

gktempo init 120 

gkscale[] = fillarray(0, 2, 3, 5, 7, 8, 10)

opcode inScale, i, ii
  ibase, idegree xin
  idegrees = lenarray:i(gkscale)
  ioct = int(idegree / idegrees)
  xout cpsmidinn(ibase + (ioct * 12) + i(gkscale, idegree % idegrees)) 
endop

opcode hexbeat, i, Si
  Spat, ibeat xin

  ibeatPat = strtol(strcat("0x", Spat)) 
  ipatlen = strlen(Spat) * 4
  indx = (ibeat % ipatlen)

  xout (ibeatPat >> (ipatlen - indx - 1)) & 1 

endop

instr P1
  ibeat = p4
endin

instr Perform
  ibeat = p4

  schedule("P1", 0, p3, ibeat) 
endin

instr Clock ;; our clock	
  kbeat init 0
  kfreq = gktempo / 60 * 4
  kdur = 1 / kfreq
  ktrig = metro(kfreq)

  schedkwhen(ktrig, 0, 0, "Perform", 0, kdur, kbeat)

  if (ktrig == 1) then
    kbeat += 1
  endif

endin

schedule("Clock", 0, -1)
