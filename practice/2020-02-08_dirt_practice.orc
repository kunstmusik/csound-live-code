start("ReverbMixer")

gSamps[] = fillarray("jvbass:0", "gabba:0", "yeah:0", "gabba:2")


instr P1

  dirt("jvbass:0", ampdbfs(-12) * hexbeat("f800"), semitone( (p4 | (p4 << 1) ) % 11))
  dirt("bd:2", ampdbfs(-12) * hexbeat("808080808080808f"))
  dirt("yeah:1", ampdbfs(-12) * hexbeat("2"), semitone( (p4 # (p4 << 2)) % 11))

  iv = ((p4 << 2) | (p4 << 5)) % 11 % 4
  dirt(gSamps[iv],
        ampdbfs(-15) * hexbeat("ff80008ff"), semitone( (p4 # (p4 << 2) ) % 7))

  hexdirt("2a", "yeah", ampdbfs(-12) )
  hexdirt("0560056d", "casio", ampdbfs(-12) )
  hexdirt("92000000", "yeah:5", ampdbfs(-12) )
  hexdirt("356000000", "yeah:6", ampdbfs(-12) )

  hexplay("ccee", 
      "Click", p3 * 0.5,
      random:i(3000, 6000),
      ampdbfs(-15))

endin
