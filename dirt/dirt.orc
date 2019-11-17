;; Code for loading and using Dirt Sample Set with csound-live-code
;; Dirt Samples: https://github.com://github.com/tidalcycles/Dirt-Samples  
;; 
;; To use, download or git clone the sample set from site above into wherever
;; you have SSDIR set for your system. (Or download into the folder where 
;; livecode-dirt.csd is installed.)


opcode dirt_get_index, i, S
  Sname xin
  Sid = strcat("dirtindx.", Sname)
  ival = chnget:i(Sid)
  chnset(ival + 1, Sid)
  xout ival
endop

opcode dirt_set_table, 0, Si
  Sname, indx xin
  Sid = strcat("dirttab.", Sname) 
  chnset(indx, Sid)
endop

opcode dirt_get_table, i, S
  Sname xin
  Sid = strcat("dirttab.", Sname) 
  ival = chnget:i( Sid)
  xout ival
endop

opcode load_dirt_samples, 0,0
  iline = 0
  prints("[dirt] - Loading Dirt Sample Set...\n")

  while (iline >= 0) do
    Sline, iline  readfi  "dirt/dirt_samples.txt"
    if (iline >= 0) then
      Sline = strsub(Sline, 0, strlen(Sline) - 1) 
      Sname = strsub(Sline, 0, strindex(Sline, "/")) 
      indx = dirt_get_index(Sname)
      Sname2 = sprintf("%s:%d", Sname, indx)
      Sfile = strcat("Dirt-Samples/", Sline)
      prints("  Loading %s: %s\n", Sname2, Sfile)
      itab = ftgen(0, 0, 0, 1, Sfile, 0, 0, 1)

      if (indx == 0) then
        dirt_set_table(Sname, itab)
      endif
      dirt_set_table(Sname2, itab)


    endif

  od
  prints("[dirt] - Done loading Dirt sample set.\n")

endop

opcode dirt, 0, Sii
  Sinstr, iamp, irate xin 

  schedule("dirt_play", 0, 1, Sinstr, irate, iamp)
endop

opcode dirt, 0, Si
  Sinstr, iamp xin 

  schedule("dirt_play", 0, 1, Sinstr, 1, iamp)
endop

instr dirt_play
  Sinstr = p4
  itab = dirt_get_table(Sinstr)
  ilen = ftlen(itab)
  idur = ilen / ftsr(itab) 
  p3 = idur / p5

  ;index = strindex(Sinstr, ":")
  ;Sbase = (index > 0) ? strsub(Sinstr, 0, index) : Sinstr

  Sbase = Sinstr
  asig = lposcil:a(p6, p5, 0, ilen, itab) 

  pan_verb_mix(asig, xchan:k(strcat(Sbase, ".pan"), 0.5), 
    xchan:k(strcat(Sbase, ".rvb"), chnget:i("drums.rvb.default")))


  pan_verb_mix(asig, 0.5, 0.1)
endin

; load_dirt_samples() 
; dirt("bd", hexbeat("8") * ampdbfs(-12))
