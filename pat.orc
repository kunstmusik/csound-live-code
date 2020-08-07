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

opcode pat_item_count, i, S
  Spat xin
  indx = 0
  icount = 0
  imode = 0
  ibrackets = 0

  while (indx < strlen(Spat)) do
    Stmp = strsub(Spat, indx, indx + 1)
    if(imode == 0) then
      if(strcmp(Stmp, "[") == 0 || strcmp(Stmp, "]") == 0) then
        ;; ignore
      elseif (strcmp(Stmp, " ") != 0) then
          imode = 1 
          icount += 1
      endif
    elseif (imode == 1) then
      if(strcmp(Stmp, " ") == 0 || strcmp(Stmp, "[") == 0 || strcmp(Stmp, "]") == 0) then
        imode = 0
      endif
    endif

    indx += 1
  od
  xout icount 
endop

opcode pat_len, i, S
  Spat xin
  indx = 0
  icount = 0
  imode = 0
  ibrackets = 0
  while (indx < strlen(Spat)) do
    Stmp = strsub(Spat, indx, indx + 1)
    if(imode == 0) then
      if(strcmp(Stmp, " ") != 0) then
        icount += 1
        if (strcmp(Stmp, "[") == 0) then
          ibrackets = 1
          imode = 2
        else
          imode = 1 
        endif
      endif
    elseif (imode == 1) then
      if(strcmp(Stmp, " ") == 0) then
        imode = 0
      endif
    else
        if (strcmp(Stmp, "[") == 0) then
          ibrackets += 1
        elseif (strcmp(Stmp, "]") == 0) then
          ibrackets -= 1
        endif
        if(ibrackets == 0) then
          imode = 0
        endif
    endif
    indx += 1
  od
  xout icount 
endop

opcode pat_subpat, S, Si
  Spat, indx xin

  istart = indx
  indx += 1
  ibrackets = 1
  istrlen = strlen(Spat)

  while (ibrackets > 0 && indx < istrlen) do
    Stmp = strsub(Spat, indx, indx + 1)

    if (strcmp(Stmp, "[") == 0) then
      ibrackets += 1
    elseif (strcmp(Stmp, "]") == 0) then
      ibrackets -= 1
    endif
    indx += 1
  od

  /*if(ibrackets > 0) then*/
  /*  Sout = "error"*/
  /*else */
  /*  Sout = strsub(Spat, istart + 1, indx - 1)*/
  /*endif*/
  Sout = (ibrackets > 0) ?  "error" : strsub(Spat, istart + 1, indx - 1)

  xout Sout
endop

opcode pat_compile2, i[], S
  Spat xin
  icount = pat_len(Spat) 
  istrlen = strlen(Spat)

  ipat[] init 64 

  ;print icount

  ;; header
  ipat[0] = icount 

  ibeatindx = 1
  ipatindx = 1 + icount
 
  indx = 0
  istart = 0
  imode = 0
  igrpcount = 0

  while (indx < istrlen) do

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
          strcmp(Stmp, "]") == 0) then
        Sval = strsub(Spat, istart, indx)

        if(ipatindx + 3 > lenarray(ipat)) then 
          ipat = grow_array(ipat)
        endif

        if(igrpcount == 0) then
          ipat[ibeatindx] = ipatindx
          ibeatindx += 1
        endif

        if(strcmp(Sval, "_") == 0) then
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

opcode pat_perf2, 0, SSiooo
  Spat, Sinstr, iamp, ioct, ibase, itick xin

 
  if(itick <= 0) then
    itick = now_tick()
  endif

  if(itick % 4 == 0) then
    ibeat = itick / 4

    print ibeat

    ipat[] pat_compile2 Spat
    ibeat = ibeat % ipat[0]

    /*print ipat[0]*/

    icount = 0
    ipatindx = ipat[1 + ibeat] 
    
    /*print ipatindx*/

    idurs[] init 16
    idurs[0] = 1
    idursindx = 0
    istart = 0

     

    while (istart < 1 && ipatindx < lenarray(ipat)) do
      icmd = ipat[ipatindx]

      if(icmd == 0) then
        ipatdur = idurs[idursindx]
        idursindx += 1
        idurs[idursindx] = ipatdur / ipat[ipatindx + 1]
        ipatindx += 2

      elseif (icmd == 1) then
        idur = idurs[idursindx] * ipat[ipatindx + 1] 
        print istart, idur
        schedule(Sinstr, beats(istart), beats(idur), in_scale(ioct, ibase + ipat[ipatindx + 2]), iamp)
        ipatindx += 3
        istart += idur

      else
        idur = idurs[idursindx] * ipat[ipatindx + 1] 
        ipatindx += 3
        istart += idur
      endif

    od

  endif
endop


opcode pat_compile, i[], S
  Spat xin
  icount = pat_item_count(Spat) 

  ipat[] init (icount * 3)

  ipatindx = 0
  
  imode = 0
  indx = 0
  ibeat = 0
  ibeatdur[] init 16
  ibeatdur[0] = 1
  istackindx = 0
  istart = 0

  while (indx < strlen(Spat)) do

    Stmp = strsub(Spat, indx, indx + 1)

    if (imode == 0) then
      if(strcmp(Stmp, " ") == 0) then
        ;; ignore
      elseif(strcmp(Stmp, "[") == 0) then
        ilen = pat_len(pat_subpat(Spat, indx))
        print ilen
        if(ilen <= 0) then
          indx = strlen(Spat)
        else
          inew_beat_dur = ibeatdur[istackindx] / ilen
          istackindx += 1
          ibeatdur[istackindx] = inew_beat_dur
        endif
      elseif(strcmp(Stmp, "]") == 0) then
        istackindx -= 1
      else
        istart = indx
        imode = 1
      endif
    elseif (imode == 1) then
      if (strcmp(Stmp, " ") == 0 || strcmp(Stmp, "[") == 0 || 
          strcmp(Stmp, "]") == 0) then
        Sval = strsub(Spat, istart, indx)
        ival = strtod(Sval)
        
        ipat[ipatindx] = ibeat
        ipat[ipatindx + 1] = ibeatdur[istackindx]
        ipat[ipatindx + 2] = ival
        ipatindx += 3

        ibeat += ibeatdur[istackindx]

        indx -= 1
        imode = 0
      endif

    endif

    indx += 1
  od

  if(imode == 1) then
        Sval = strsub(Spat, istart, indx)
        ival = strtod(Sval)
        
        ipat[ipatindx] = ibeat
        ipat[ipatindx + 1] = ibeatdur[istackindx]
        ipat[ipatindx + 2] = ival
        ipatindx += 3
  endif
  
  xout ipat

endop


opcode pat_perf, 0, SSioo
  Spat, Sinstr, iamp, ioct, ibase xin

  indx = 0
  ipat[] pat_compile Spat
  while (indx < lenarray(ipat)) do
    schedule(Sinstr, beats(ipat[indx]), beats(ipat[indx + 1]), in_scale(ioct, ibase + ipat[indx + 2]), iamp)
    indx += 3
  od
endop

/* 
print pat_len("1 0 2")
print pat_len("[ 1 0 ]  [3 4 5]")
print pat_item_count("[ 1 0 ] 3 2[3 4 5]")

printarray(pat_compile2("[ 1 0 ] 3 2 [3 4 5]"))

printarray(pat_compile("0 1 2"))
print(pat_len("[ 1 0 ] 3 2 [3 4 5]"))
prints pat_subpat("[ 1 0 ]  [3 4 5]    ", 9)
prints strsub("Test", 0,1)
prints "TEST"
*/

prints(strsub("[ 1 0 ]  [3 4 5] ", 10, 15))

instr P1
  Spat = "0 [_ 2 _ 5] [4 4] 2"
  pat_perf2(Spat, "Squine1", ampdbfs(-12), 0, 0)

endin

;clear_instr("P1")

