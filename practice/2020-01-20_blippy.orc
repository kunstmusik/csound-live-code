;; Author: Steven Yi
;; Description: Blippy square sounds with interesting bitshift pattern
;; Date: 2020-01-20 

set_tempo(116)

xchnset("rvb.default", 0.3)
xchnset("drums.rvb.default", 0.3)

instr P1
  hexplay("a222",
      "Square", p3,
      in_scale(0, (p4 << (p4 & 0x5)) & 0xd),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("f80",
      "Square", p3,
      in_scale(0, 6 + (p4 << (p4 & 0xd)) & 0xe),
      fade_in(5, 128) * ampdbfs(-12))
  
  hexplay("3e000",
      "Square", p3,
      in_scale(1, 4 + (p4 << (p4 & 0xe)) & 0xb),
      fade_in(5, 128) * ampdbfs(-15))
    
  hexplay("0808080c",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-3))
  
  hexplay("8000",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(6, 128) * ampdbfs(-9))


endin
