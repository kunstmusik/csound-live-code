/**
  Live Coding Functions
  Author: Steven Yi
*/ 

;; TIME

gktempo init 120 

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


;; Beats

opcode hexbeat, i, Si
  Spat, ibeat xin

  ;; 4 bits/beats per hex value
  ipatlen = strlen(Spat) * 4
  ;; get beat within pattern length
  ibeat = ibeat % ipatlen
  ;; figure which hex value to use from string
  ipatidx = int(ibeat / 4)
  ;; figure out which bit from hex to use
  ibitidx = ibeat % 4 
  
  ;; convert individual hex from string to decimal/binary
  ibeatPat = strtol(strcat("0x", strsub(Spat, ipatidx, ipatidx + 1))) 

  ;; bit shift/mask to check onset from hex's bits
  xout (ibeatPat >> (3 - ibitidx)) & 1 

endop


opcode hexplay, 0, SiSiip
	Spat, ibeat, Sinstr, idur, ifreq, iamp xin

  if(hexbeat(Spat, ibeat) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp )
  endif
endop

opcode beatphase, i, ii
	ibeat, imax xin
	xout (ibeat % imax) / imax
endop


;; Iterative Euclidean Beat Generator
;; Returns string of 1 and 0's
opcode euclidStr, S, ii
  ihits, isteps xin

  Sleft = "1"
  Sright = "0"

  ileft = ihits
  iright = isteps - ileft

  while iright > 1 do
    if (iright > ileft) then
      iright = iright - ileft 
      Sleft = strcat(Sleft, Sright)
    else
      itemp = iright
      iright = ileft - iright
      ileft = itemp 
      Stemp = Sleft
      Sleft = strcat(Sleft, Sright)
      Sright = Stemp
    endif
  od

  Sout = ""
  indx = 0 
  while (indx < ileft) do
    Sout = strcat(Sout, Sleft)
    indx += 1
  od
  indx = 0 
  while (indx < iright) do
    Sout = strcat(Sout, Sright)
    indx += 1
  od

  xout Sout
endop

opcode euclid, i, iii
  ibeat, ihits, isteps xin
  Sval = euclidStr(ihits, isteps)
  indx = ibeat % strlen(Sval)
  xout strtol(strsub(Sval, indx, indx + 1))
endop

opcode euclidplay, 0, iiiSiip
	ihits, isteps, ibeat, Sinstr, idur, ifreq, iamp xin

  if(euclid(ibeat, ihits, isteps) == 1) then
    schedule(Sinstr, 0, idur, ifreq, iamp)
  endif
endop

;; Phase-based Oscillators 

opcode xcos, i,i
	iphase  xin
	xout cos(2 * $M_PI * iphase)
endop

opcode xsin, i,i
	iphase  xin
	xout cos(2 * $M_PI * iphase)
endop

opcode xosc, i, ik[]
  iphase, kvals[]  xin
  indx = int(lenarray:i(kvals) * (iphase % 1))  
  xout i(kvals, indx)
endop

;; SCALE/HARMONY (experimental)

gkscale[] = fillarray(0, 2, 3, 5, 7, 8, 10)

opcode inScale, i, ii
  ibase, idegree xin

  idegrees = lenarray:i(gkscale)

  if (idegree < 0) then
    ioct = (1 + int(abs:i(idegree) / idegrees))
    indx = idegree + (ioct * idegrees)
    ioct *= -1
  else 
    ioct = int(idegree / idegrees)
    indx = idegree % idegrees
  endif

  xout cpsmidinn(ibase + (ioct * 12) + i(gkscale, indx)) 
endop

;; AUDIO

opcode declick, a, a
	ain xin
	aenv = linseg:a(0, 0.01, 1, p3 - 0.02, 1, 0.01, 0, 0.01, 0)
 	xout ain * aenv
endop


;; INITIALIZATION OF SYSTEM

schedule("Clock", 0, -1)

