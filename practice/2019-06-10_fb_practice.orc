; Author: Steven Yi
; Title: FBReverb practice
; Date: 2019-06-10

start("FBReverbMixer")

schedule("Sub4", 0, 4, in_scale(0, rand(array(0,2,4,6))), ampdbfs(-12))

chnset(0.5, "VoxHumana.rvb")

instr R1
  ibase = rand(array(0,2,4,7))
  Sinstr = rand(fillarray("VoxHumana"))
  schedule(Sinstr, 0, 3, in_scale(-1, -2 + ibase), ampdbfs(-9))
  schedule(Sinstr, 0, 3, in_scale(1, -2 + ibase), ampdbfs(-9))
  schedule(p1, p3 * rand(array(1,2,4)), p3)
endin

instr R2
  if(p4 < p6) then
    schedule("SynBrass", 0, p3, in_scale(p5, p4), ampdbfs(-12 - p4))
    schedule("SynBrass", 0, p3, in_scale(p5, p4 + 4), ampdbfs(-12 - p4))
    schedule(p1, p3, p3, p4 + 2, p5, p6)
  endif
endin

chnset(random:i(0.2, 0.8), "SynBrass.pan")
schedule("R2", 0, random:i(0.3, 0.20), rand(array(-2, -4, 0,2,4)), rand(array(-1, 0,1)), random:i(24, 12))

schedule("R1", 0, 2.7)
schedule("Sine", 0, 4, in_scale(1, rand(array(0,2,4,6))), ampdbfs(-18))
