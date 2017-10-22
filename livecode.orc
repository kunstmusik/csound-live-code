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

;; CURVES

opcode cosr, i,iii
	iphase, iamp, ioffset xin
	xout cos(2 * $M_PI * iphase) * iamp + ioffset
endop

;; SCALE/HARMONY (experimental)

gkscale[] = fillarray(0, 2, 3, 5, 7, 8, 10)

opcode inScale, i, ii
  ibase, idegree xin
  idegrees = lenarray:i(gkscale)
  ioct = int(idegree / idegrees)
  xout cpsmidinn(ibase + (ioct * 12) + i(gkscale, idegree % idegrees)) 
endop

;; AUDIO

opcode declick, a, a
	ain xin
	aenv = linseg:a(0, 0.01, 1, p3 - 0.02, 1, 0.01, 0, 0.01, 0)
 	xout ain * aenv
endop


;; INITIALIZATION OF SYSTEM

schedule("Clock", 0, -1)

