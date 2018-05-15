;; test file for working with livecode.orc and
;; temporal recursion
<CsoundSynthesizer>
<CsOptions>
-o dac -d --port=10000 -m0
</CsOptions>
; ==============================================
<CsInstruments>

sr	=	48000
ksmps	= 16	
nchnls	=	2
0dbfs	=	1

#include "livecode.orc"

instr TRe
  ifreq = p4
  iphs = p5

  if(choose(0.25) == 1) then 
    schedule("Sub1", 0, 
      beats(rand(array(3,7,11))), 
      ifreq * xosc(phs(iphs, 16), array(0.5, 1, 1.5)), 
      ampdbfs(rand(array(-18, -21, -24))))
  endif

  schedule(p1, beats(rand(array(2.5, 1, 1.5))), p3, ifreq,  iphs + 1)

endin


opcode alg0, k[], ik[]
  // rand slice that is rand rotated
  inum, kin[] xin
  
  ilen = lenarray:i(kin)
  inum = min:i(inum, ilen)
  istart = int(random(0, ilen))

  kvals[] init inum

  indx = 0

  while (indx < inum) do
    kvals[indx] init i(kin, istart)

    istart = (istart + 1) % inum
    indx += 1
  od 

  kout[] init inum
  indx = 0
  iread = int(random(0, inum))

  while (indx < inum) do
    ival = i(kvals, iread)
    kout[indx] init ival 
    iread = (iread + 1) % inum
    indx += 1
  od

  xout kout
endop

instr Melodic
  iphs = p4

  if(choose(.7) == 1) then 
    schedule("Sub4", 0, 
      beats(8), 
      in_scale(rand(array(1,2)), xosc(phs(iphs, 13), array(2,4,6,8, 6, 4))), 
      ampdbfs(-18))
  endif

  idur = beats(xosc(phs(iphs, 7), array(1, 1.5, 2)))

  schedule(p1, idur, p3, iphs + 1)

endin

opcode play_chord,0,Siik[]i
  Sinstr, idur, ibase, kvals[], iamp xin

  turnoff

  indx = 0
  while (indx < lenarray:i(kvals)) do
    schedule(Sinstr, 0, idur, cpsmidinn(ibase + i(kvals, indx)), ampdbfs(iamp))
    indx += 1
  od

endop

/*
play_chord("Sub1", beats(8), 72, array(0,2,4,5,7,9), -24)
play_chord("Sub1", beats(8), 67, array(0,2,4,5,7,9), -24)
play_chord("Sub1", beats(8), 62, array(0,1,3,5,6,8,10, 11), -28)
play_chord("Sub1", beats(8), 48, array(0,1,3,5,6,8,10, 11), -28)
*/


instr Mel2
  ;; put this here to make sure no perf code happens
  turnoff


  ;; From the array note numbers, take a random 
  ;; slice, and start at a random index for the 
  ;; slice

  /*knn[] = array(0,2,4,5,7,8,11,13)*/
  /*knn[] = array(7, 0, 1, 8)*/
  knn[] = array(2,5,7,1)

  ilen = lenarray(knn)
  inum = int(random(1, ilen + 1)) 

  kvals[] alg0 inum, knn 

  indx = 0
  istart = 0

  while (indx < inum) do
    inn = i(kvals, indx)
    print inn

    schedule("Sub1", istart, 
      beats(8), 
      cpsmidinn(72 + inn), 
      ampdbfs(-22))
    if(choose(0.75) == 1) then
      istart += beats(random(2, 4))
    else 
      istart += beats(random(0.25, 1))
    endif

    indx += 1
  od


  schedule(p1, istart + beats(random(3,5)), p3)
endin

/*clear_instr("TRe")*/
/*schedule("Mel2", 0, 1)*/

/* PROJECT MAIN */

instr Start
  seed(0)
  set_scale("maj")
  set_tempo(84)
  schedule("TRe", 0, 1, 420, 0)
  schedule("TRe", measures(8), 1, 120, 0)
  schedule("TRe", measures(14), 1, 360, 0)
  schedule("TRe", measures(20), 1, 800, 0)
  ;;schedule("Melodic", 0, 1, 0)
  schedule("Mel2", 0, 1)
endin

schedule("Start", 0, 1)

/*clear_instr("TRe")*/
/*clear_instr("Melodic")*/

</CsInstruments>
</CsoundSynthesizer>

