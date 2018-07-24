# Live Code User-Defined Opcodes

|Outputs | Opcode | Inputs |
| ---- | ---- | ---- |
|  | **set_tempo** | itempo  |
| ival | **get_tempo** |  |
|  | **go_tempo** | inewtempo, incr  |
| ival | **now** |  |
| ival | **now_tick** |  |
| ival | **beats** | inumbeats  |
| ival | **measures** | inummeasures  |
| ival | **ticks** | inumbeats  |
| ival | **next_beat** | ibeatcount  |
| ival | **next_measure** |  |
|  | **reset_clock** |  |
|  | **adjust_clock** | iadjust  |
| ival | **choose** | iamount  |
| ival | **cycle** | indx, kvals[]  |
| ival | **rand** | kvals[]  |
| Sval | **rand** | Svals[]  |
|  | **cause** | Sinstr, istart, idur, ifreq, iamp  |
| ival | **hexbeat** | Spat, itick  |
|  | **hexplay** | Spat, itick, Sinstr, idur, ifreq, iamp  |
|  | **hexplay** | Spat, Sinstr, idur, ifreq, iamp  |
| ival | **octalbeat** | Spat, itick  |
|  | **octalplay** | Spat, ibeat, Sinstr, idur, ifreq, iamp  |
|  | **octalplay** | Spat, Sinstr, idur, ifreq, iamp  |
| ival | **phs** | icount, iperiod  |
| ival | **phs** | iticks  |
| ival | **phsb** | ibeats  |
| ival | **phsm** | imeasures  |
| Sval | **euclid_str** | ihits, isteps  |
| ival | **euclid** | ihits, isteps, itick   |
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
|  | **set_root** | iscale_root  |
| ival | **from_root** | ioct, ipc  |
|  | **set_scale** | Scale  |
| ival | **in_scale** | ioct, idegree  |
|  | **set_chord** | ichord_root, ichord_intervals[]  |
|  | **set_chord** | Schord  |
| ival | **in_chord** | ioct, idegree  |
| aval | **declick** | ain  |
|  | **kill** | Sinstr  |
|  | **clear_instr** | Sinstr  |
|  | **start** | Sinstr  |
|  | **set_fade_range** | irange  |
| ival | **fade_in** | ident, inumticks  |
| ival | **fade_out** | ident, inumticks  |
|  | **set_fade** | ident, ival  |
|  | **sbus_mix** | ibus, al, ar  |
|  | **sbus_clear** | ibus  |
| aaval | **sbus_read** | ibus  |
