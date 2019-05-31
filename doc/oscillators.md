# Event-time Oscillators

livecode.orc includes a set of event-time user-defined opcodes that run only at init-time.  They each take in a phase argument that is a number that should be in the range of 0.0-1.0, then oscillator-specific arguments.  

## Phase 

The following opcodes take in arguments for the period of the phasor and generate an `ival` value in the range of 0.0-1.0:

|Outputs | Opcode | Inputs |
| ---- | ---- | ---- |
| ival | **phs** | icount, iperiod  |
| ival | **phs** | iticks  |
| ival | **phsb** | ibeats  |
| ival | **phsm** | imeasures  |

One typically uses the latter three opcodes that use the global clock tick number (managed by livecode.orc's global clock) and generate the phase within the give number of ticks, beats, or measures. To compare, the following opcode calls will all return the same values: 

```csound
 iphs1 = phs(16) ;; period of 16 ticks
 iphs2 = phsb(4) ;; period of 4 beats 
 iphs3 = phsm(1) ;; period of 1 measure (assumes 4 beat measure)
```

## Oscillators

The following opcodes all take in a phase value and additional oscillator-specific arguments:

|Outputs | Opcode | Inputs |
| ---- | ---- | ---- |
| ival | **xcos** | iphase   |
| ival | **xcos** | iphase, ioffset, irange   |
| ival | **xsin** | iphase   |
| ival | **xsin** | iphase, ioffset, irange   |
| ival | **xosc** | iphase, kvals[]   |
| ival | **xoscb** | iphaseDurationBeats, kvals[]   |
| ival | **xoscm** | iphaseDurationMeasures, kvals[]   |
| ival | **xosci** | iphase, kvals[]   |
| ival | **xoscib** | iphaseDurationBeats, kvals[]   |
| ival | **xoscim** | iphaseDurationMeasures, kvals[]   |
| ival | **xlin** | iphase, istart, iend  |

### xcos
`xcos` is an overloaded UDO that can be called with just a phase value, or called with a phase, offset, and range. Given a phase value from 0.0-1.0, the single-argument `xcos` generates a cosine curve in the range of (-1.0,1.0) and centered at 0.0.  If the three-argument `xcos` is called, one specifies the center point and range to go above and below the center point. (This latter form is inspired by `cosr` from [Extempore](https://extemporelang.github.io/)). 

### xsin

`xsin` is an overloaded UDO that operates just like `xcos` except that it generates a sine curve. 

### xosc

`xosc` is a non-interpolating oscillator that takes in phase and an array. The non-interpolating oscillator is a powerful tool that uses the array like a wavetable and can be used to generate arpeggiation patterns, harmonic root changes, melodic lines, accent patterns, and more.

`xoscb` and `xoscm` are shorthand versions of xosc that take in a phase duration in beats and measures respectively. For example, `xoscb(2, array(0,1)` is equivalent to `xosc(phsb(2), array(0,1))`.

### xosci

`xosci` is an interpolating oscillator that takes in a phase and an array.  The oscillator linearly interpolates values between points.  One can generate melodic and automation curves easily with `xosc`.  

`xoscib` and `xoscim` are shorthand versions of xosc that take in a phase duration in beats and measures respectively. For example, `xoscib(2, array(0,1)` is equivalent to `xosci(phsb(2), array(0,1))`.

### xlin

`xlin` is a linear ramp oscillator.  It uses the phase to generate a line from the start value to the end value. 
