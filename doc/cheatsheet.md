# Live Code User-Defined Opcodes

|Outputs | Opcode | Inputs |
| ---- | ---- | ---- |
|  | **set_tempo** | itempo  |
| ival | **get_tempo** |  |
|  | **go_tempo** | inewtempo, incr  |
| ival | **now** |  |
| ival | **beats** | inumbeats  |
| ival | **ticks** | inumbeats  |
|  | **reset_clock** |  |
| ival | **choose** | iamount  |
| ival | **cycle** | indx, kvals[]  |
| ival | **rand** | kvals[]  |
| ival | **hexbeat** | Spat, itick  |
|  | **hexplay** | Spat, itick, Sinstr, idur, ifreq, iamp  |
|  | **hexplay** | Spat, Sinstr, idur, ifreq, iamp  |
| ival | **octalbeat** | Spat, itick  |
|  | **octalplay** | Spat, ibeat, Sinstr, idur, ifreq, iamp  |
|  | **octalplay** | Spat, Sinstr, idur, ifreq, iamp  |
| ival | **phs** | iticks  |
| ival | **phsb** | ibeats  |
| ival | **phsm** | imeasures  |
| ival | **phs** | icount, iperiod  |
| Sval | **euclid_str** | ihits, isteps  |
| ival | **euclid** | itick, ihits, isteps  |
|  | **euclidplay** | ihits, isteps, itick, Sinstr, idur, ifreq, iamp  |
|  | **euclidplay** | ihits, isteps, Sinstr, idur, ifreq, iamp  |
| ival | **xcos** | iphase   |
| ival | **xcos** | iphase, ioffset, irange   |
| ival | **xsin** | iphase   |
| ival | **xsin** | iphase, ioffset, irange   |
| ival | **xosc** | iphase, kvals[]   |
| ival | **xosci** | iphase, kvals[]   |
| ival | **xlin** | iphase, istart, iend  |
| Sval | **rotate** | Sval, irot  |
| Sval | **strrep** | Sval, inum  |
| ival | **xchan** | SchanName, initVal  |
| kval | **xchan** | SchanName, initVal  |
|  | **set_scale** | Scale  |
| ival | **in_scale** | ioct, idegree  |
| aval | **declick** | ain  |
|  | **kill** | Sinstr  |
|  | **clear_instr** | Sinstr  |
| ival | **fade_in** | ident, inumbeats  |
| ival | **fade_out** | ident, inumbeats  |
