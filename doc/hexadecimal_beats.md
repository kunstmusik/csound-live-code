# Hexadecimal Beats

Hexadecimal Beats is a system for using Hexadecimal notation (base 16) for notating rhythmic onsets. It allows for notating a set of four sixteenth notes using a single character. The system matches up well with drum programming and modular sequencer programming practices and is useful for drum and melodic line programming for synchronized music. 

NOTE: I had developed and worked with this system for a couple of years before coming across prior work by Bernhard Wagner in [http://bernhardwagner.net/musings/RPABN.html](Rhythmic Patterns As Binary Numbers). The article by Wagner discusses the use for notation and gives examples performed by instrumentalists as well as bit shifting and complementation operations. 

## Hexadecimal (Base 16), Binary (Base 2), and Base 10

A Hexadecimal digit is written using the numbers 0-9 and letters a-f. Each digit maps to one of the base 10 numbers between 0 and 15. A single hexadecimal digit is equivalent to a four-digit base 2 number (i.e., 4 bits). If the 1's and 0's of base 2 are interpreted as note hits and silences, a single hexadecimal digit can represent one beat of material made up of four sixteenth notes.  

| Hex | Binary | Base 10 | 
|:--:|:--:|:--:|
|0 | 0000 | 00 | 
|1 | 0001 | 01 | 
|2 | 0010 | 02 | 
|3 | 0011 | 03 | 
|4 | 0100 | 04 | 
|5 | 0101 | 05 | 
|6 | 0110 | 06 | 
|7 | 0111 | 07 | 
|8 | 1000 | 08 | 
|9 | 1001 | 09 | 
|a | 1010 | 10 | 
|b | 1011 | 11 | 
|c | 1100 | 12 | 
|d | 1101 | 13 | 
|e | 1110 | 14 | 
|f | 1111 | 15 | 

## Converting from Rhythm to Hex

Notation in Hex can take some pratice, but once mastered can be very quick for notating rhythmic ideas.  To interpret a four sixteenth note pattern into hex:

1. First visualize the four sixteenth notes, then see the on's and off's as 1's and 0's and convert the rhythm into binary. For example, two eighth notes may look like `1010`.  
2. Convert from binary: each digit represents a power of 2 and matches up with `8421`. If the digit in the rhythm is a one, look at the the match and use that value. For example, for `1010`, we have one 8 and one 2, which sums to 10.  
3. Convert to hex: from 10 we can lookup in the table to see what is the corresponding hex value, which is `a`.    

## Values of Hex Beat Notation

1. With practice, one gets famililar with each of the hex values and how to use them to notate a rhythm. 
2. The hex values stick out and make it easy to remember common rhythms (e.g., `9228` is a 4/4 _Son Clave_ rhythm).
3. Hexadecimal is a compressed data format. It takes less characters to express a rhythm than it would in a binary representation or [Time Unit Box System (TUBS)](https://en.wikipedia.org/wiki/Time_unit_box_system) notation.

## Drawbacks of Hex Beat Notation

1. Hexadecimal beats only works with 16th note divisions for a beat. (Though there are tricks to developing 32nd note patterns, see "Hacking 32nd Notes" below)


## hexbeat() and hexplay()

livecode.orc provides two opcodes for interpreting hexadecimal beat strings as onsets. First, hexbeat() takes in one required argument, the hex string, and an optional index value.  If an index value is not give, the current clock tick is used. The opcode returns a 1 if the given tick corresponds with a hit and a 0 if it corresponds with a silence. For example, with a hex value of `"8"`--which translates to `1000` in binary--the following code would result in the following values:

```csound
  ival1 = hexbeat("8", 0) ;; ival1 equals 1
  ival2 = hexbeat("8", 1) ;; ival2 equals 0
  ival3 = hexbeat("8", 2) ;; ival3 equals 0
  ival4 = hexbeat("8", 3) ;; ival4 equals 0
```

The output value of `hexbeat()` being a 1 or 0 allows it to be used to control onsets either by conditional test or through multiplication for amplitude.  For example:

```csound
  if (hexbeat("80") == 1) then
    schedule("Sub1", 0, ticks(1), in_scale(0,0), ampdbfs(-12))
  endif
```

would check the current clock tick against the hex beat string and, if the tick matches a beat onset, will return a 1 and allow the if-block to run.  

Another way to use the `hexbeat()` output is to pair it with `cause()` and multiply the amplitude by the result of `hexbeat()`. For example, the following will achieve the same result as the previous example: 

```csound
cause("Sub1", 0, ticks(1), in_scale(0,0), ampdbfs(-12) * hexbeat("80"))
```

Because `cause()` is designed to only fire when it's fifth argument (amplitude) is greater than 0, notes for `Sub1` will only fire according to the hex beat notation.

## Learning Hexadecimal Beats 

The suggested learning path for Hexadecimal Beat notation is to start off simple and gradually get more complex. 

1. First try working just with strings of `8`'s and `0`'s. This will be equivalent to notate with just quarter notes and quarter rests.  Try using a `hexplay()` call with a `BD` instrument and pattern `8`. Try modifyin the hex string to `80`, then `8000`, and hear how that affects the rhythm.  Next, try adding an additional `hexplay()` call with an `SD` instrument pattern of `08`.  Next try modifyin the `SD` rhythm to `0800` and hear how that affects the rhythm.

2. After notating quarter note rhythms, try working with 8th note rhythms.  These would be `8`, `0`, `2`, and `a`. Again start with just a `BD` pattern, then again work with a second `SD` pattern with a complementary rhythm.

3. After working 8th notes, try working with the various single-note 16th note rhythms.  These would be `8`, `4`, `2`, and `1`.  Try out these each on their own, then combine with 8th and quarter note rhythms.

4. Next, try the two-note 16th note rhythms. These would be `a`, `9`, `c`, `6`, `3`, and `5`. 

5. Finally, experiment with the three-note 16th note rhythms (`b`, `d`, `e`) and the all 16th-note rhythm (`f`). 

Additionally, I would highly recommend practicing by:

1. Notating rhythms you hear in music. 

2. Reproducing 808 patterns found at the [808 Drum Patterns](http://808.pixll.de/) website. There are many patterns to choose from and in many different styles.  


## Hacking 32nd Notes

While Hex Beats works at 16th note resolution, a hack is available to develop 32nd note rhythms by using a start time offset.  In the example below, there are two patterns setup for triggering the _CHH_ (Closed High Hat) instrument. The first uses a standard hexplay() call to generate the usual 16th notes.  The second uses a cause() call together with a `p3 / 2` start time (p3 is equal to the current tick length, or the duration of one 16th note). The two together will give the generated rhythm a 32nd note fill on the fourth beat of every other measure. 

```csound
set_tempo(85)

instr P1
  
  hexplay("a",
      "Sub2", p3,
      in_scale(-1, 2),
      fade_in(11, 128) * ampdbfs(xlin(phsm(8), -18, -30)))

  hexplay("f00c",
      "Sub5", p3,
      in_scale(-2, ((p4 % 16) == 13) ? 7 : 0),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("00000aaa",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(xlin(phsm(4), -20, -12)))

  hexplay("aaff",
      "CHH", p3,
      in_scale(-1, 0),
      ampdbfs(-12))

  cause("CHH", p3/2, p3, 0, ampdbfs(-12) * hexbeat("0000000f"))

  hexplay("080c",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("91569154",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-9))

endin
```

## Hacking Pitch Curves

In the previous example, numeric computations were used to determine if a particular tick was found and, if so, to generate one scale degree:

```csound
  hexplay("f00c",
      "Sub5", p3,
      in_scale(-2, ((p4 % 16) == 13) ? 7 : 0),
      fade_in(10, 128) * ampdbfs(-12))
```

The computation checks if the `p4` (the current tick or 16th note) is equal to 13 (which corresponds to the second hit from the `c` hex pattern) and, if so, to generate a 7, otherwise a 0. This means that we want all notes to be 0 except for a 7 when were are on tick 13.

Another way to express the same computation would be to use `hexbeat()` to generate a 1 or 0 and then to multiply by 7, as follows:


```csound
  hexplay("f00c",
      "Sub5", p3,
      in_scale(-2, hexbeat("0004") * 7),
      fade_in(10, 128) * ampdbfs(-12))
```

Using `hexbeat()` in this way can be a quick way to generate pitch patterns that alternate between two values. `hexbeat()` could be further employed for affecting duration, octave, accent, etc. 
