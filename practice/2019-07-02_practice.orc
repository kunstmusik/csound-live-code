start("ReverbMixer")

chnset(0.7, "Sub6.rvb")

set_tempo(240)

instr P1
  Srhythm = "a"
  /*Srhythm = "a"*/
  /*Srhythm = "8"*/
  /*Srhythm = "80"*/
  hexplay(Srhythm, 
      "Organ2", p3,
      in_scale(-1, (p4 % 8) / 2),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay(Srhythm, 
      "Organ2", p3,
      in_scale(0, (p4 % 8) / 2),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ2", p3,
      in_scale(0, (p4 % 2)),
      fade_in(5, 128) * ampdbfs(-12))

  hexplay("f", 
      "Organ2", p3,
      in_scale(0, 4 + (p4 % 3)),
      fade_in(5, 128) * ampdbfs(-12))

  /*hexplay(Srhythm, */
  /*    "Organ2", p3,*/
  /*    in_scale(0, (p4 >> (p4 % 3)) % 7),*/
  /*    fade_in(6, 128) * ampdbfs(-12))*/

  /*hexplay(Srhythm, */
  /*    "Organ2", p3,*/
  /*    in_scale(-1, 2 + ((p4 >> (p4 & 0x14)) % 8)),*/
  /*    fade_in(7, 128) * ampdbfs(-6) * choose(0.4))*/

  /*hexplay(Srhythm, */
  /*    "Organ2", p3,*/
  /*    in_scale(-1, 4 + ((p4 >> (p4 & 0x14)) % 8)),*/
  /*    fade_in(8, 128) * ampdbfs(-12) * choose(0.4))*/
 
  /*if(hexbeat("9200") == 1) then*/
  /*    ibase = xoscb(2, array(4,6,2)) */
  /*    schedule("Sub6", 0, p3, in_scale(0, ibase), ampdbfs(-21))*/
  /*    schedule("Sub6", 0, p3, in_scale(0, ibase + 4), ampdbfs(-21))*/
  /*endif*/

endin
