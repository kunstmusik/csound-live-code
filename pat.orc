;; internal pat format
;; header: beat-len 
;; cmd args
;; 0 group len 
;; 1 play: start dur val
;; 2 rest: start dur _ 
;; 

;; 0 4, 0 3, 1 0 0 , 1 1 0  
;; 0 3  (new group, len 3)  
;; 0 play
;; 1 rest

opcode grow_array, i[], i[]
  in_array[] xin
  ilen = lenarray(in_array)

  iout_array[] init ilen * 2

  indx = 0
  while (indx < ilen) do
    iout_array[indx] = in_array[indx]
    indx += 1
  od

  xout iout_array
endop

opcode pat_len, i, S
  Spat xin
  indx = 0
  icount = 0
  imode = 0
  ibrackets = 0
  ialts = 0

  while (indx < strlen(Spat)) do
    Stmp = strsub(Spat, indx, indx + 1)

    if (strcmp(Stmp, "[") == 0) then
      if((ialts + ibrackets) == 0 && imode == 1) then
        icount += 1
      endif
      ibrackets += 1
      imode = 0

    elseif (strcmp(Stmp, "]") == 0) then
      ibrackets -= 1
      if((ialts + ibrackets) == 0) then
        icount += 1
      endif
      imode = 0

    elseif (strcmp(Stmp, "<") == 0) then
      if((ialts + ibrackets) == 0 && imode == 1) then
        icount += 1
      endif
      ialts += 1
      imode = 0

    elseif (strcmp(Stmp, ">") == 0) then
      ialts -= 1
      if((ialts + ibrackets) == 0) then
        icount += 1
      endif
      imode = 0

    elseif (strcmp(Stmp, " ") == 0) then
      if((ialts + ibrackets) == 0 && imode == 1) then
        icount += 1
      endif
      imode = 0
    else
      imode = 1
    endif

    indx += 1
  od

  icount += imode ;; in case was reading number value at end

  xout icount 
endop

opcode pat_subpat, S, Si
  Spat, indx xin

  istart = indx
  indx += 1
  Sstart = strsub(Spat, istart, istart + 1)
  ibrackets = strcmp(Sstart, "[") == 0 ? 1 : 0 
  ialts = strcmp(Sstart, "<") == 0 ? 1 : 0 
  istrlen = strlen(Spat)

  while ((ibrackets + ialts) > 0 && indx < istrlen) do
    Stmp = strsub(Spat, indx, indx + 1)

    if (strcmp(Stmp, "[") == 0) then
      ibrackets += 1
    elseif (strcmp(Stmp, "]") == 0) then
      ibrackets -= 1
    elseif (strcmp(Stmp, "<") == 0) then
      ialts += 1
    elseif (strcmp(Stmp, ">") == 0) then
      ialts -= 1
    endif
    indx += 1
  od

  Sout = (ibrackets > 0) ?  "error" : strsub(Spat, istart + 1, indx - 1)

  xout Sout
endop

opcode pat_compile, i[], S
  Spat xin
  ipat[] init 64 

  icount = pat_len(Spat) 
  istrlen = strlen(Spat)


  ;print icount

  ;; header
  ipat[0] = icount 

  ibeatindx = 1
  ipatindx = 1 + icount
 
  indx = 0
  istart = 0
  imode = 0
  igrpcount = 0

  while (indx <= istrlen) do

    Stmp = strsub(Spat, indx, indx + 1)

    if (imode == 0) then
      if(strcmp(Stmp, " ") == 0) then
        ;; ignore
      elseif(strcmp(Stmp, "[") == 0) then

        ilen = pat_len(pat_subpat(Spat, indx))
        ;print ilen

        if(ipatindx + 2 > lenarray(ipat)) then 
          ipat = grow_array(ipat)
        endif

        ;; record top-level beat to speed up performance
        if(igrpcount == 0) then
          ipat[ibeatindx] = ipatindx
          ibeatindx += 1
        endif

        ipat[ipatindx] = 0 ;; cmd: new group
        ipat[ipatindx + 1] = ilen ;; cmd: new group
        ipatindx += 2

        igrpcount += 1
      elseif (strcmp(Stmp, "]") == 0) then
        igrpcount -= 1
      else 
        istart = indx
        imode = 1

      endif

    elseif (imode == 1) then

      if (strcmp(Stmp, " ") == 0 || strcmp(Stmp, "[") == 0 || 
          strcmp(Stmp, "]") == 0 || indx == istrlen) then
        Sval = strsub(Spat, istart, indx)

        if(ipatindx + 3 > lenarray(ipat)) then 
          ipat = grow_array(ipat)
        endif

        ;; record top-level beat to speed up performance
        if(igrpcount == 0) then
          ipat[ibeatindx] = ipatindx
          ibeatindx += 1
        endif

        if(strcmp(Sval, "~") == 0) then
          ipat[ipatindx] = 2 ;; cmd: rest 
          ipat[ipatindx + 1] = 1 
          ipat[ipatindx + 2] = 0 
          ipatindx += 3

        else 
          ival = strtod(Sval)
          ipat[ipatindx] = 1 ;; cmd: play
          ipat[ipatindx + 1] = 1 
          ipat[ipatindx + 2] = ival
          ipatindx += 3

        endif
      

        indx -= 1
        imode = 0

      endif
    endif

    indx += 1
  od

  xout ipat

endop



opcode pat_perf, 0, i[]Siooo
  ipat[], Sinstr, iamp, ioct, ibase, itick xin
 
  if(itick <= 0) then
    itick = now_tick()
  endif

  if(itick % 4 == 0) then
    ibeat = itick / 4

    /*print ibeat*/

    ibeat = ibeat % ipat[0]

    /*print ipat[0]*/

    ipatindx = ipat[1 + ibeat] 
    
    /*print ipatindx*/

    igrpcount[] init 16
    igrpcount[0] = 0    
    idurs[] init 16
    idurs[0] = 1

    igrpindx = 0
    istart = 0

    while (istart < 1 && ipatindx < lenarray(ipat)) do
      icmd = ipat[ipatindx]

      if(icmd == 0) then
        ipatdur = idurs[igrpindx]
        igrpindx += 1
        igrplen = ipat[ipatindx + 1] 
        idurs[igrpindx] = ipatdur / igrplen  
        igrpcount[igrpindx] = igrplen 

        ipatindx += 2

      elseif (icmd == 1 || icmd == 2) then
        idur = idurs[igrpindx] * ipat[ipatindx + 1] 
        ;;print istart, idur
        if(icmd == 1) then
          schedule(Sinstr, beats(istart), beats(idur), 
                   in_scale(ioct, ibase + ipat[ipatindx + 2]), iamp)
        endif
        ipatindx += 3
        istart += idur

        if(igrpindx > 0) then
          icount = igrpcount[igrpindx] - 1
          if(icount == 0) then
            igrpindx -= 1
          else
            igrpcount[igrpindx] = icount
          endif
        endif

      else
        prints("Error: Unknown command %d\n", icmd)
        ipatindx += 3
      endif

    od

  endif
endop


opcode pat_perf, 0, SSiooo
  Spat, Sinstr, iamp, ioct, ibase, itick xin

  ipat[] pat_compile Spat
  pat_perf(ipat, Sinstr, iamp, ioct, ibase, itick)
endop

/* 
print pat_len("1 0 2")
print pat_len("[ 1 0 ]  [3 4 5]")

printarray(pat_compile("[ 1 0 ] 3 2 [3 4 5]"))

printarray(pat_compile("0 1 2"))
print(pat_len("[ 1 0 ] 3 2 [3 4 5]"))
prints pat_subpat("[ 1 0 ]  [3 4 5]    ", 9)

prints pat_subpat("[ 1 0 ]  <3 [4 5] 5>    ", 9)
print pat_len("[ 1 <0 4>] <3 [4 5 ] 5> 4")
prints strsub("Test", 0,1)
prints "TEST"
*/

/*prints(strsub("[ 1 0 ]  [3 4 5] ", 10, 15))*/

start("ReverbMixer")

gipat1[] = pat_compile("0 0 [~ 5 ~ 5] [4 4] ")

instr P1
  /*Spat = "0 0 [_ 5 _ 5] [4 4]"*/
  /*pat_perf(Spat, "Bass", ampdbfs(-12), -1, 0)*/

  /*xchnset("Bass.pan", random:i(0, 1))*/
  /*xchnset("Bass.pan", 0.5)*/
  pat_perf(gipat1, "Bass", ampdbfs(-12), -1, 0)

  Spat = "[4 4] [~ ~ 4 ~] [4 3 7 4] ~"
  pat_perf(Spat, "Bass", ampdbfs(-12), ((p4 << 2) # p4) % 3)

  Spat = "8 ~ 8 ~ [9 9 ] ~ 8 ~"
  pat_perf(Spat, "Bass", ampdbfs(-12), -1 + ((p4 << 1) # p4) % 3)

  hexdirt("2", "808:1", ampdbfs(-21))

  hexdirt("8", "bd", ampdbfs(-9))

endin

printarray(pat_compile("0 [~ ~ ~ 5] [4 4] 2"))

;clear_instr("P1")

