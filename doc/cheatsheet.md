# Live Code Cheatsheet

## User-Defined Opcodes

|Outputs | Opcode | Inputs |
| ---- | ---- | ---- |
|  | **set\_tempo** | itempo  |
| ival | **get\_tempo** |  |
|  | **go\_tempo** | inewtempo, incr  |
| ival | **now** |  |
| ival | **now\_tick** |  |
| ival | **beats** | inumbeats  |
| ival | **measures** | inummeasures  |
| ival | **ticks** | inumbeats  |
| ival | **next\_beat** | ibeatcount  |
| ival | **next\_measure** |  |
|  | **reset\_clock** |  |
|  | **adjust\_clock** | iadjust  |
| ival | **choose** | iamount  |
| ival | **cycle** | indx, kvals[]  |
| ival | **contains** | ival, iarr[]  |
| ival | **contains** | ival, karr[]  |
| k[]val | **remove** | ival, karr[]  |
| ival | **rand** | kvals[]  |
| Sval | **rand** | Svals[]  |
| kval | **randk** | kvals[]  |
| Sval | **randk** | Svals[]  |
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
| Sval | **euclid\_str** | ihits, isteps  |
| ival | **euclid** | ihits, isteps, itick   |
|  | **euclidplay** | ihits, isteps, itick, Sinstr, idur, ifreq, iamp  |
|  | **euclidplay** | ihits, isteps, Sinstr, idur, ifreq, iamp  |
| ival | **xcos** | iphase   |
| ival | **xcos** | iphase, ioffset, irange   |
| ival | **xsin** | iphase   |
| ival | **xsin** | iphase, ioffset, irange   |
| ival | **xosc** | iphase, kvals[]   |
| ival | **xoscb** | ibeats, kvals[]  |
| ival | **xoscm** | ibeats, kvals[]  |
| ival | **xosci** | iphase, kvals[]   |
| ival | **xoscib** | ibeats, kvals[]  |
| ival | **xoscim** | ibeats, kvals[]  |
| ival | **xlin** | iphase, istart, iend  |
| ival | **xoscd** | itick, kdurs[]  |
| ival | **xoscd** | kdurs[]  |
| ival | **dur\_seq** | itick, kdurs[]  |
| ival | **dur\_seq** | kdurs[]  |
| iiival | **melodic** | itick, kdurs[], kpchs[], kamps[]  |
| iiival | **melodic** | kdurs[], kpchs[], kamps[]  |
| Sval | **rotate** | Sval, irot  |
| Sval | **strrep** | Sval, inum  |
|  | **xchnset** | SchanName, ival  |
| ival | **xchan** | SchanName, initVal  |
| kval | **xchan** | SchanName, initVal  |
|  | **set\_root** | iscale_root  |
| ival | **from\_root** | ioct, ipc  |
|  | **set\_scale** | Scale  |
| ival | **in\_scale** | ioct, idegree  |
| kval | **in\_scale** | koct, kdegree  |
| ival | **pc\_quantize** | ipitch_in, iscale[]  |
| ival | **pc\_quantize** | ipitch_in  |
|  | **set\_chord** | ichord_root, ichord_intervals[]  |
|  | **set\_chord** | Schord  |
| ival | **in\_chord** | ioct, idegree  |
| aval | **declick** | ain  |
| kval | **oscil** | kfreq, kin[]  |
|  | **kill** | Sinstr  |
|  | **clear\_instr** | Sinstr  |
|  | **start** | Sinstr  |
|  | **stop** | Sinstr  |
|  | **eval\_at\_time** | Scode, istart  |
|  | **set\_fade\_range** | irange  |
| ival | **fade\_in** | ident, inumticks  |
| ival | **fade\_out** | ident, inumticks  |
| ival | **fade\_read** | ident  |
|  | **set\_fade** | ident, ival  |
|  | **sbus\_write** | ibus, al, ar  |
|  | **sbus\_mix** | ibus, al, ar  |
|  | **sbus\_clear** | ibus  |
| aaval | **sbus\_read** | ibus  |
|  | **pan\_verb\_mix** | asig, kpan, krvb  |
|  | **reverb\_mix** | al, ar, krvb  |
|  | **automate** | Schan, idur, istart, iend, itype  |
|  | **fade\_out\_mix** | idur  |
| aval | **saturate** | asig, ksat  |
## Instruments

|Instrument Name | 
| ---- | 
|  ReverbMixer | 
|  FBReverbMixer | 
|  ChnSet | 
|  Auto | 
|  Sub1 | 
|  Sub2 | 
|  Sub3 | 
|  Sub4 | 
|  Sub5 | 
|  Sub6 | 
|  Sub7 | 
|  Sub8 | 
|  SynBrass | 
|  SynHarp | 
|  SSaw | 
|  Mode1 | 
|  Plk | 
|  Organ1 | 
|  Organ2 | 
|  Organ3 | 
|  Bass | 
|  ms20_bass | 
|  VoxHumana | 
|  FM1 | 
|  Noi | 
|  Wobble | 
|  Sine | 
|  Square | 
|  Saw | 
|  Squine1 | 
|  Form1 | 
|  Mono | 
|  MonoNote | 
|  Click | 
|  NoiSaw | 
|  Clap | 
|  BD   | 
|  SD   | 
|  OHH  | 
|  CHH  | 
|  HiTom  | 
|  MidTom  | 
|  LowTom   | 
|  Cymbal   | 
|  Rimshot  | 
|  Claves | 
|  Cowbell | 
|  Maraca   | 
|  HiConga  | 
|  MidConga   | 
|  LowConga   | 
