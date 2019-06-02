; Author: Steven Yi
; Title: Organic
; Date: 2019.06.01

start("ReverbMixer")

chnset(0.4, "Plk.rvb")
set_fade(10, 1)

gicount = 0

instr P1
  hexplay("f", 
      "Plk", p3,
      in_scale(1, xoscb(2, array(0,2,1,3)) + xoscb(3.7, array(0,4,7,4))),
      fade_in(5, 128) * ampdbfs(-15) * choose(0.3))

  hexplay("a", 
      "Organ2", p3 * 2,
      in_scale(-1, xoscb(2, array(0,2,1,3)) + xoscb(3.7, array(0,4,7,4))),
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ2", p3,
      in_scale(0, xoscb(2, array(0,2,1,3)) + xoscb(3.3, array(0,7)) + xoscm(2.2, array(0,4,7,11))),
      fade_in(7, 128) * ampdbfs(-12) * choose(0.4))

  if(gicount <= 0) then
    idur = rand(array(1,1.5, 2,4))

    ipch = rand(array(0,2,4,6))

    schedule(
        "Organ2", 0, measures(idur),
        in_scale(-1, ipch),
        fade_in(10, 128) * ampdbfs(-12))
    schedule(
        "Organ2", 0, measures(idur),
        in_scale(-1, ipch + 4),
        fade_in(10, 128) * ampdbfs(-14))

    gicount = idur * 16 

  else
    gicount -= 1
  endif

  if(p4 % 64 == 0) then
    schedule(
        "Organ2", 0, measures(3.5),
        in_scale(-2, 0),
        fade_in(10, 128) * ampdbfs(-12))
  endif

  if((p4 + 4) % 64 == 0) then
    schedule(
        "Organ2", 0, measures(3.5),
        in_scale(-1, 0),
        fade_in(10, 128) * ampdbfs(-12))
  endif


  hexplay("f", 
      "Mode1", p3,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(xoscim(16, array(-24, -20))))

endin
