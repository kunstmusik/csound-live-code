; Author: Steven Yi
; Title: Feedback Reverb Study
; Date: 2019.06.02 

start("FBReverbMixer")

instr R1
  ipch = p5 + 2
  chnset(random:i(0.1, 0.9), "Plk.pan")
  schedule("Plk", 0, 0.3, cpsmidinn(60 + ipch), ampdbfs(-15))
  if(p4 - 1 >= 0) then
    schedule(p1, p3, p3, p4 - 1, ipch)
  endif
endin
chnset(0.9, "Plk.rvb")
schedule("R1", 0, 0.05, 3, random:i(-10, 10))

schedule("Organ2", 0, 7, cpsmidinn(48 + rand(array(0,2,4,6,8))), ampdbfs(-12))
