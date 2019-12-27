;; Author: Steven Yi
;; Description: Groovin'
;; Date: 2019.12.27

start("ReverbMixer")

xchnset("rvb.default", 0.2)
xchnset("drums.rvb.default", 0.2)

xchnset("Organ2.rvb", 0.2)

set_tempo(128)

instr P1
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-1, 2 + (p4 << (p4 & 0x7)) & 0xd),
      fade_in(19, 128) * ampdbfs(-15))
  
  hexplay("f",
      "Organ2", p3,
      in_scale(-2, (p4 << (p4 & 0x5)) & 0xb),
      fade_in(19, 128) * ampdbfs(-9))
  
  hexplay("0200",
      "Sub4", p3 * 0.4,
      in_scale(2, 1),
      fade_in(16, 128) * ampdbfs(-12))
  
  hexplay("d00000",
      "Plk", p3,
      in_scale(1, 0),
      fade_in(15, 128) * ampdbfs(-12))
  
  hexplay("2000",
      "Saw", p3,
      in_scale(1, 2),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("a2",
      "Saw", p3,
      in_scale(cycle(p4 % 17, array(0,1,0)), 1),
      fade_in(18, 128) * ampdbfs(-18))
  
  hexplay("a802a00000",
      "Square", p3,
      in_scale(1, 0),
      fade_in(9, 128) * ampdbfs(-15))
  
  hexplay("2",
      "CHH", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(xlin(phsm(8), -15, -30)))
  
  hexplay("f80000",
      "Click", p3,
      6000,
      fade_in(6, 128) * ampdbfs(-12))

  hexplay("bdc00000",
      "Click", p3,
      2739,
      fade_in(7, 128) * ampdbfs(-12))
  
  hexplay("0808080e",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(17, 128) * ampdbfs(-12))
  
  hexplay("0008020c",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(12, 128) * ampdbfs(-12))
  
  hexplay("a002a800a002a8bd",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(5, 128) * ampdbfs(-6))

endin
