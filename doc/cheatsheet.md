# Live Code User-Defined Opcodes

|Outputs | Opcode | Inputs |
| ---- | ---- | ---- |
|  | _ set_tempo_ | itempo  |
| ival | _ get_tempo_ |  |
|  | _ go_tempo_ | inewtempo, incr  |
| ival | _ now_ |  |
| ival | _ beats_ | inumbeats  |
| ival | _ ticks_ | inumbeats  |
|  | _ reset_clock_ |  |
| ival | _ choose_ | iamount  |
| ival | _ cycle_ | indx, kvals[]  |
| ival | _ rand_ | kvals[]  |
| ival | _ hexbeat_ | Spat, itick  |
|  | _ hexplay_ | Spat, itick, Sinstr, idur, ifreq, iamp  |
|  | _ hexplay_ | Spat, Sinstr, idur, ifreq, iamp  |
| ival | _ octalbeat_ | Spat, itick  |
|  | _ octalplay_ | Spat, ibeat, Sinstr, idur, ifreq, iamp  |
|  | _ octalplay_ | Spat, Sinstr, idur, ifreq, iamp  |
| ival | _ phs_ | iticks  |
| ival | _ phsb_ | ibeats  |
| ival | _ phsm_ | imeasures  |
| ival | _ phs_ | icount, iperiod  |
| Sval | _ euclid_str_ | ihits, isteps  |
| ival | _ euclid_ | itick, ihits, isteps  |
|  | _ euclidplay_ | ihits, isteps, itick, Sinstr, idur, ifreq, iamp  |
|  | _ euclidplay_ | ihits, isteps, Sinstr, idur, ifreq, iamp  |
| ival | _ xcos_ | iphase   |
| ival | _ xcos_ | iphase, ioffset, irange   |
| ival | _ xsin_ | iphase   |
| ival | _ xsin_ | iphase, ioffset, irange   |
| ival | _ xosc_ | iphase, kvals[]   |
| ival | _ xosci_ | iphase, kvals[]   |
| ival | _ xlin_ | iphase, istart, iend  |
| Sval | _ rotate_ | Sval, irot  |
| Sval | _ strrep_ | Sval, inum  |
| ival | _ xchan_ | SchanName, initVal  |
| kval | _ xchan_ | SchanName, initVal  |
|  | _ set_scale_ | Scale  |
| ival | _ in_scale_ | ioct, idegree  |
| aval | _ declick_ | ain  |
|  | _ kill_ | Sinstr  |
|  | _ clear_instr_ | Sinstr  |
| ival | _ fade_in_ | ident, inumbeats  |
| ival | _ fade_out_ | ident, inumbeats  |
