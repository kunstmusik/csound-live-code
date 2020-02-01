# Live Code Reference

## Opcodes

**set\_tempo**(itempo)

Set tempo of global clock to itempo value in beats per minute. 

---

ival = **get\_tempo**()

Returns tempo of global clock in beats per minute. 

---

**go\_tempo**(inewtempo, incr)

Adjust tempo of global clock towards by inewtempo by incr amount. 

---

ival = **now**()

Returns value of now beat time
(Code used from Thorin Kerr's LivecodeLib.csd) 

---

ival = **now\_tick**()

Returns current clock tick at init time 

---

ival = **beats**(inumbeats)

Returns duration of time in given number of beats (quarter notes) 

---

ival = **measures**(inummeasures)

Returns duration of time in given number of measures (4 quarter notes) 

---

ival = **ticks**(inumbeats)

Returns duration of time in given number of ticks (16th notes) 

---

ival = **next\_beat**(ibeatcount)

Returns time from now for next beat, rounding to align
on beat boundary.
(Code used from Thorin Kerr's LivecodeLib.csd) 

---

ival = **next\_measure**()

Returns time from now for next measure, rounding to align to measure
boundary. 

---

**reset\_clock**()

Reset clock so that next tick starts at 0 

---

**adjust\_clock**(iadjust)

Adjust clock by iadjust number of beats.
Value may be positive or negative. 

---

ival = **choose**(iamount)

Given a random chance value between 0 and 1, calculates a random value and
returns 1 if value is less than chance value. For example, giving a value of 0.7,
it can read as "70 percent of time, return 1; else 0" 

---

ival = **cycle**(indx, kvals[])

Cycles through karray using index. 

---

ival = **contains**(ival, iarr[])

Checks to see if item exists within array. Returns 1 if
true and 0 if false. 

---

ival = **contains**(ival, karr[])

Checks to see if item exists within array. Returns 1 if
true and 0 if false. 

---

k[]val = **remove**(ival, karr[])

Create a new array by removing all instances of a
given number from an existing array. 

---

ival = **rand**(kvals[])

Returns random item from karray. 

---

Sval = **rand**(Svals[])

Returns random item from String array. 

---

kval = **randk**(kvals[])

Returns random item from karray. 

---

Sval = **randk**(Svals[])

Returns random item from karray. 

---

**cause**(Sinstr, istart, idur, ifreq, iamp)

Wrapper opcode that calls schedule only if iamp > 0. 

---

ival = **hexbeat**(Spat, itick)

Given a hexadecimal beat string pattern and optional
itick (defaults to current now\_tick()), returns value 1 if
the given tick matches a hit in the hexadecimal beat, or
returns 0 otherwise. 

---

**hexplay**(Spat, itick, Sinstr, idur, ifreq, iamp)

Given hex beat pattern, use given itick to fire
events for given instrument, duration, frequency, and
amplitude 

---

**hexplay**(Spat, Sinstr, idur, ifreq, iamp)

Given hex beat pattern, use global clock to fire
events for given instrument, duration, frequency, and
amplitude 

---

ival = **octalbeat**(Spat, itick)

Given an octal beat string pattern and optional
itick (defaults to current now\_tick()), returns value 1 if
the given tick matches a hit in the octal beat, or
returns 0 otherwise. 

---

**octalplay**(Spat, ibeat, Sinstr, idur, ifreq, iamp)



---

**octalplay**(Spat, Sinstr, idur, ifreq, iamp)



---

ival = **phs**(icount, iperiod)

Given count and period, return phase value in range [0-1) 

---

ival = **phs**(iticks)

Given period in ticks, return current phase of global
clock in range [0-1) 

---

ival = **phsb**(ibeats)

Given period in beats, return current phase of global
clock in range [0-1) 

---

ival = **phsm**(imeasures)

Given period in measures, return current phase of global
clock in range [0-1) 

---

Sval = **euclid\_str**(ihits, isteps)



---

ival = **euclid**(ihits, isteps, itick)

Given number of ihits for a period of isteps and an optional
itick (defaults to current now\_tick()), returns value 1 if
the given tick matches a hit in the euclidean rhythm, or
returns 0 otherwise. 

---

**euclidplay**(ihits, isteps, itick, Sinstr, idur, ifreq, iamp)



---

**euclidplay**(ihits, isteps, Sinstr, idur, ifreq, iamp)



---

ival = **xcos**(iphase)

Returns cosine of given phase (0-1.0) 

---

ival = **xcos**(iphase, ioffset, irange)

Range version of xcos, similar to Impromptu's cosr 

---

ival = **xsin**(iphase)

Returns sine of given phase (0-1.0) 

---

ival = **xsin**(iphase, ioffset, irange)

Range version of xsin, similar to Impromptu's sinr 

---

ival = **xosc**(iphase, kvals[])

Non-interpolating oscillator. Given phase in range 0-1,
returns value within the give k-array table. 

---

ival = **xoscb**(ibeats, kvals[])

Non-interpolating oscillator. Given phase duration in beats,
returns value within the give k-array table. (shorthand for xosc(phsb(ibeats), karr) )

---

ival = **xoscm**(ibeats, kvals[])

Non-interpolating oscillator. Given phase duration in measures,
returns value within the give k-array table. (shorthand for xosc(phsm(ibeats), karr) )

---

ival = **xosci**(iphase, kvals[])

Linearly-interpolating oscillator. Given phase in range 0-1,
returns value intepolated within the two closest points of phase within k-array
table. 

---

ival = **xoscib**(ibeats, kvals[])

Linearly-interpolating oscillator. Given phase duration in beats,
returns value intepolated within the two closest points of phase within k-array
table. (shorthand for xosci(phsb(ibeats), karr) )

---

ival = **xoscim**(ibeats, kvals[])

Linearly-interpolating oscillator. Given phase duration in measures,
returns value intepolated within the two closest points of phase within k-array
table. (shorthand for xosci(phsm(ibeats), karr) )

---

ival = **xlin**(iphase, istart, iend)

Line (Ramp) oscillator. Given phase in range 0-1, return interpolated value between given istart and iend. 

---

ival = **xoscd**(itick, kdurs[])

Given a tick value and array of durations, returns new duration value for tick. 

---

ival = **xoscd**(kdurs[])

Given an array of durations, returns new duration value for current clock tick. Useful with mod division and cycle for additive/subtractive rhythms. 

---

ival = **dur\_seq**(itick, kdurs[])

Given a tick value and array of durations, returns new duration or 0 depending upon whether tick hits a new duration value. Values
may be positive or negative, but not zero. Negative values can be interpreted as rest durations. 

---

ival = **dur\_seq**(kdurs[])

Given an array of durations, returns new duration or 0 depending upon
* whether current clock tick hits a new duration value. Values
may be positive or negative, but not zero. Negative values can be interpreted
as rest durations. 

---

iiival = **melodic**(itick, kdurs[], kpchs[], kamps[])

Experimental opcode for generating melodic lines given array of durations, pitches, and amplitudes. Durations follow dur\_seq practice that negative values are rests. Pitch and amp array indexing wraps according to their array lengths given index of non-rest duration value currently fired. 

---

iiival = **melodic**(kdurs[], kpchs[], kamps[])

Experimental opcode for generating melodic lines given array of durations, pitches, and amplitudes. Durations follow dur\_seq practice that negative values are rests. Pitch and amp array indexing wraps according to their array lengths given index of non-rest duration value currently fired. 

---

Sval = **rotate**(Sval, irot)

rotate - Rotates string by irot number of values.
(Inspired by rotate from Charlie Roberts' Gibber.)


---

Sval = **strrep**(Sval, inum)

Repeats a given String x number of times. For example, `Sval = strrep("ab6a", 2)` will produce the value of "ab6aab6a". Useful in working with Hex beat strings.  

---

**xchnset**(SchanName, ival)

Sets i-rate value into channel and sets initialization to true. Works together
with xchan 

---

ival = **xchan**(SchanName, initVal)

xchan
Initializes a channel with initial value if channel has default value of 0 and
then returns the current value from the channel. Useful in live coding to define
a dynamic point that will be automated or set outside of the instrument that is
using the channel.

Opcode is overloaded to return i- or k- value. Be sure to use xchan:i or xchan:k
to specify which value to use.


---

kval = **xchan**(SchanName, initVal)

xchan
Initializes a channel with initial value if channel has default value of 0 and
then returns the current value from the channel. Useful in live coding to define
a dynamic point that will be automated or set outside of the instrument that is
using the channel.

Opcode is overloaded to return i- or k- value. Be sure to use xchan:i or xchan:k
to specify which value to use.


---

**set\_root**(iscale_root)

Set root note of scale in MIDI note number. 

---

ival = **from\_root**(ioct, ipc)

Calculate frequency from root note of scale, using
octave and pitch class. 

---

**set\_scale**(Scale)

Set the global scale.  Currently supports "maj" for major and "min" for minor scales. 

---

ival = **in\_scale**(ioct, idegree)

Calculate frequency from root note of scale, using
octave and scale degree. 

---

kval = **in\_scale**(koct, kdegree)

Calculate frequency from root note of scale, using
octave and scale degree. (k-rate version of opcode) 

---

ival = **pc\_quantize**(ipitch_in, iscale[])

Quantizes given MIDI note number to the given scale
(Base on pc:quantize from Extempore) 

---

ival = **pc\_quantize**(ipitch_in)

Quantizes given MIDI note number to the current active scale
(Base on pc:quantize from Extempore) 

---

**set\_chord**(ichord_root, ichord_intervals[])



---

**set\_chord**(Schord)



---

ival = **in\_chord**(ioct, idegree)



---

aval = **declick**(ain)

Utility opcode for declicking an audio signal. Should only be used in instruments that have positive p3 duration. 

---

kval = **oscil**(kfreq, kin[])

Custom non-interpolating oscil that takes in kfrequency and array to use as oscillator table
data. Outputs k-rate signal. 

---

**kill**(Sinstr)

Turns off running instances of named instruments.  Useful when livecoding
audio and control signal process instruments. May not be effective if for
temporal recursion instruments as they may be non-running but scheduled in the
event system. In those situations, try using clear\_instr to overwrite the
instrument definition. 

---

**clear\_instr**(Sinstr)

Redefines instr to empty body. Useful for killing
temporal recursion or clock callback functions 

---

**start**(Sinstr)

Starts running a named instrument for indefinite time using p2=0 and p3=-1.
Will first turnoff any instances of existing named instrument first.  Useful
when livecoding always-on audio and control signal process instruments. 

---

**stop**(Sinstr)

Stops a running named instrument, allowing for release segments to operate. 

---

**eval\_at\_time**(Scode, istart)

Evaluate code at a given time 

---

**set\_fade\_range**(irange)

Sets the range in db to fade over. By default, range is -30 (i.e., fades from -30dbfs to 0dbfs) 

---

ival = **fade\_in**(ident, inumticks)

Given a fade channel identifier (number) and number of ticks to fade over time, advances from current fade channel value towards 0dbfs (1.0) using the globally set fade range. (By default starts fading in from -30dBfs and stops at 0dbfs.) 

---

ival = **fade\_out**(ident, inumticks)

Given a fade channel identifier (number) and number of ticks to fade over time, advances from current fade channel value towards 0 using the globally set fade range. (By default starts fading out from 0dBfs and stops at -30dbfs.) 

---

ival = **fade\_read**(ident)

Read value from fade channel. Useful if copy/pasting then wanting to just read from fade and control in the original code. 

---

**set\_fade**(ident, ival)

 Set value for fade channel to given value. Should be in range 0-1.0.  (Typically one sets to either 0 or 1.) 

---

**sbus\_write**(ibus, al, ar)

Write two audio signals into stereo bus at given index 

---

**sbus\_mix**(ibus, al, ar)

Mix two audio signals into stereo bus at given index 

---

**sbus\_clear**(ibus)

Clear audio signals from bus channel 

---

aaval = **sbus\_read**(ibus)

Read audio signals from bus channel 

---

**pan\_verb\_mix**(asig, kpan, krvb)

Utility opcode to pan signal, send dry to mixer, and send amount
of signal to reverb. If ReverbMixer is not on, will output just
panned signal using out opcode. 

---

**reverb\_mix**(al, ar, krvb)

Utility opcode to send dry stereo to mixer and send amount
of stereo signal to reverb. If ReverbMixer is not on, will output just
panned signal using out opcode. 

---

**automate**(Schan, idur, istart, iend, itype)

Automate channel value over time. Takes in "ChannelName", duration, start value, end value, and automation type (0=linear, else exponential). For exponential, signs of istart and end must match and neither can be zero. 

---

**fade\_out\_mix**(idur)

Utility opcode for end of performances to fade out Mixer over given idur time. idur defaults to 30 seconds. *

---

aval = **saturate**(asig, ksat)

Saturation using tanh 

---

## Instruments

|Instrument Name | Description |
| ---- | ---- | 
|  ReverbMixer | Always-on Mixer instrument with Reverb send channel. Use start("ReverbMixer") to run. Designed for use with pan\_verb\_mix to simplify signal-based live coding.  | 
|  FBReverbMixer | Always-on Mixer instrument with Reverb send channel and feedback delay. Use start("FBReverbMixer") to run. Designed for use with pan\_verb\_mix to simplify signal-based live coding.  | 
|  ChnSet | Set a channel value at a given time. p4=ChannelName, p5=value | 
|  Auto | Automation instrument for channels. Takes in "ChannelName", start value, end value, and automation type (0=linear, else exponential).  | 
|  Sub1 | Substractive Synth, 3osc  | 
|  Sub2 | Subtractive Synth, two saws, fifth freq apart  | 
|  Sub3 | Subtractive Synth, three detuned saws, swells in  | 
|  Sub4 | Subtractive Synth, detuned square/saw, stabby. Nice as a lead in octave 2, nicely grungy in octave -2, -1  | 
|  Sub5 | Subtractive Synth, detuned square/triangle  | 
|  Sub6 | Subtractive Synth, saw, K35 filters  | 
|  Sub7 | Subtractive Synth, saw + tri, K35 filters  | 
|  Sub8 | Subtractive Synth, square + saw + tri, diode ladder filter  | 
|  SynBrass | SynthBrass subtractive synth  | 
|  SynHarp | Synth Harp subtracitve Synth  | 
|  SSaw | SuperSaw sound using 9 bandlimited saws (3 sets of detuned saws at octaves) | 
|  Mode1 | Modal Synthesis Instrument: Percussive/organ-y sound  | 
|  Plk | Pluck sound using impulses, noise, and waveguides | 
|  Organ1 | Wavetable Organ sound using additive synthesis  | 
|  Organ2 | Organ sound based on M1 Organ 2 patch  | 
|  Organ3 | Wavetable Organ using Flute 8' and Flute 4', wavetable based on Claribel Flute http://www.pykett.org.uk/the\_tonal\_structure\_of\_organ\_flutes.htm  | 
|  Bass | Subtractive Bass sound  | 
|  ms20_bass | MS20-style Bass Sound  | 
|  VoxHumana | VoxHumana Patch  | 
|  FM1 | FM 3:1 C:M ratio, 2->0.025 index, nice for bass  | 
|  Noi | Filtered noise, exponential envelope  | 
|  Wobble | Wobble patched based on Jacob Joaquin's "Tempo-Synced Wobble Bass"  | 
|  Sine | Simple Sine-wave instrument with exponential envelope  | 
|  Square | Simple Square-wave instrument with exponential envelope  | 
|  Saw | Simple Sawtooth-wave instrument with exponential envelope  | 
|  Squine1 | Squinewave Synth, 2 osc  | 
|  Form1 | Formant Synth, buzz source, soprano ah formants  | 
|  Mono | Monophone synth using sawtooth wave and 4pole lpf. Use "start("Mono") to run the monosynth, then use MonoNote instrument to play the instrument.  | 
|  MonoNote | Note playing instrument for Mono synth. Be careful to use this and not try to create multiple Mono instruments!  | 
|  Click | Bandpass-filtered impulse glitchy click sound. p4 = center frequency (e.g., 3000, 6000)  | 
|  NoiSaw | Highpass-filtered noise+saw sound. Use NoiSaw.cut channel to adjust cutoff.  | 
|  Clap | Modified clap instrument by Istvan Varga (clap1.orc)  | 
|  BD   | Bass Drum - From Iain McCurdy's TR-808.csd  | 
|  SD   | Snare Drum - From Iain McCurdy's TR-808.csd  | 
|  OHH  | Open High Hat - From Iain McCurdy's TR-808.csd  | 
|  CHH  | Closed High Hat - From Iain McCurdy's TR-808.csd  | 
|  HiTom  | High Tom - From Iain McCurdy's TR-808.csd  | 
|  MidTom  | Mid Tom - From Iain McCurdy's TR-808.csd  | 
|  LowTom   | Low Tom - From Iain McCurdy's TR-808.csd  | 
|  Cymbal   | Cymbal - From Iain McCurdy's TR-808.csd  | 
|  Rimshot  | Rimshot - From Iain McCurdy's TR-808.csd  | 
|  Claves | Claves - From Iain McCurdy's TR-808.csd  | 
|  Cowbell | Cowbell - From Iain McCurdy's TR-808.csd  | 
|  Maraca   | Maraca - from Iain McCurdy's TR-808.csd  | 
|  HiConga  | High Conga - From Iain McCurdy's TR-808.csd  | 
|  MidConga   | Mid Conga - From Iain McCurdy's TR-808.csd  | 
|  LowConga   | Low Conga - From Iain McCurdy's TR-808.csd  | 
