# Tutorial 1 - Let's make a sound!

## Introduction

Welcome! In this tutorial, we're going to get to know the csound-live-code
application, learn a little bit about Csound, and make our first sounds using
the pre-built synthesizers.  By the end, you'll get a little bit of a feel for
what live coding with Csound is like and be ready to move on to the next steps:
making your own synthesizers!

## About the Web Environment

Let's get started by opening up the
[csound-live-code](https://live.csound.com) web application. When the
application finishes loading, you should see the top bar with a pause/play
button and a help button, two other buttons for evaluating code immediately 
or at the measure boundary, as well as the primary code editing area. The code
editor will, by default, contain the current example snapshot. Just to
double-check that everything is working alright, click into the code editor
to give it focus, press `ctrl-a` to select all of the text, then press
`ctrl-enter` to evaluate the code. At this point, you should begin to hear a
music example playing.

If you're hearing sound, fantastic!  

Oh, but if you're not hearing sound? Well, it could be a few things. Most
likely, the browser you are using may not support the necessary features,
which are:

1. WebAudio API 
2. WebAssembly

If you know those are working for your browser, you might try checking out
the Javascript Console for your browser (usually found under a Developer Tool
menu option). The console is where any Javascript errors are reported as well
as any Csound output.

If you're not seeing anything obvious reported there, or are using a browser
where there the console is not accessible (i.e., iOS or Anrdroid), then please
contact the author.  Testing usually happens on Windows 10 with Chrome,
Firefox, and Edge; Chrome OS browser; and Chrome on Android; and it could be
you are using a configuration that the author needs to research and test on.

## Our First Sound 

Assuming you've gotten everything working, let's refresh the web site and
clear out all of the code to start with a fresh, empty code editor. Now,
let's start by typing in the following code:

```csound
schedule("Sub1", 0, 2, 440, 0.5)
```

(Note: For these tutorials, you're welcome to copy/paste code to try things
out. However, if you have the time, I'd recommend typing in the code
yourself. I think you'll learn things better and more quickly by doing so.)

Try selecting the code and evaluating it using `ctrl-enter` or one of the
evaluation buttons.  If all is well, you should hear the `Sub1` synthesizer
play at 440 hertz with a volume of 0.5 (about half of the maximum 1.0 value).
Congratulations and welcome to live coding with Csound!

## Csound's Abstractions

So what is all of the above?  In Csound, we have a few primary abstractions/concepts:

1. __Values__ are data. There are a few different types of data available in
   Csound, but for these tutorials we will focus on numeric data (e.g, 0, 2,
   0.5) and String data (e.g., "Sub1"). Sometimes we will write values directly
   into our code, such as in the above example, and other times we will work
   with generated and processed values. 
2. __Variables__ are named places in memory that hold _values_. We generally do
   only two things with variables, which is to _read_ the value from variable
   or _write_ a value into the variable. Variables are important for connecting
   different processing units together and for giving names to things, which
   helps make our code easier to write and understand.  (If you're coming from
   a patching system, whether virtual or analog, you can think of variables as
   the cables that connect modules and by which values are transferred to and
   from each other.) 
3. __Opcodes__ are individual processing units (_unit generators_ in the
   language of MUSIC-N systems).  They are responsible for generating,
   processing, and consuming data. We can think of variables as _nouns_ and
   _opcodes_ as verbs in the programming language of Csound. Opcodes have a
   life cycle where they can perform operations when they are instantiated
   (init-time); during engine performance (perf-time), and when they are
   disposed (destruction-time; we won't worry need to worry too much about this
   phase).  Some opcodes only perform operations at init-time while other do so
   at perf-time, and we use these opcodes differently. It'll be important
   understand this, but we will move on for now and come back to this in the
   next tutorial. 
4. __Instruments__ are objects that define a process though a set of variables
   and series of opcodes. The name _instrument_ comes from the MUSIC-N
   tradition and we often *do* use Csound instruments like traditional ones,
   which is to say for the purpose of making sound.  However, Csound
   instruments are generic processes, and we can use them to do a number of
   different tasks, such as always-on effects, mixing, score generation, and
   more. Additionally, instruments work with events, which is to say we can
   schedule them to run at a given time for a given duration.  
5. __Events__ are messages that have a type, start time, and duration. Csound
   includes a scheduler that holds events and, as the engine processes over
   time, reads pending events and fires off actions according to the given
   type. For these tutorials, the only event type we will be concerned with is
   creating new instrument instances, which we can think of as "play a note for
   this instrument" or "play this sonic gesture".  

## Using Opcodes

Going back to our first example:

```csound
schedule("Sub1", 0, 2, 440, 0.5)
```

We are _calling_ the `schedule` opcode to perform an operation using the Csound
Orchestra language. In the modern syntax (sometimes called _function-call_
syntax in the community), we call an opcode by writing its name, use an open
parenthesis, a list of zero-to-many _arguments_ separated by commas, then a
close parethesis. The values we give to the opcode within the parentheses must
match in both the expected number of arguments that are defined for the opcode
as well as the data types for each argument. The number and types of arguments
are defined by the opcode and the way we learn about them is by looking up the
documentation. (For example, see the reference manual entry for the
[schedule](https://csound.com/docs/manual/schedule.html).) 

In this case, the schedule opcode actually requires three arguments but also
permits giving an open-ended amount of additional arguments. This allows us to
use the opcode with instruments that might require a different number of
parameters to be given. For this tutorial, we're going to use schedule just
like above with five arguments and will discuss arguments and instrument
parameters further in the next tutorial. 


## Exploring the instruments 

The instruments that come with csound-live-code are all designed to use five
parameters. The first three are built into every instrument while the fourth
and fifth are user-defined.  The parameters are:

* p1 - the instrument's numeric ID (named instruments, like Sub1, have numeric
  IDs assigned to them automatically)
* p2 - the instrument's start time
* p3 - the instrument's duration
* p4 - frequency in hertz
* p5 - amplitude scaled to `0dbfs` range  (`0dbfs` is a user-definable setting
  for the range of amplitude for the system. It is commonly defined as 0-1.0
  and is done so for csound-live-code)


Let's now explore the various parameters.

### Start Time

Start time affects when the instrument will run and the numeric value is relative to the current time.  For example, when we use 0, it means "0 seconds from now", which is immediately.  You can try changing the value on its own using postive values. When you evaluate the updated code, it sould now start the note some time after you triggered the evaluation.  One thing to try is to write multiple lines and use different start times.

```csound
schedule("Sub1", 0, 2, 440, 0.5)
schedule("Sub1", 3, 2, 440, 0.5)
```

This should play two notes, each two seconds long, with the second note starting 1 second after the end of the first note.

### Duration

Now, start with duration.  Try modifying the 3rd parameter and evaluating the
line. For example, to change the duration to last 4 seconds or 1 second, you
would write the lines like so:

```csound
schedule("Sub1", 0, 4, 440, 0.5)
schedule("Sub1", 0, 1, 440, 0.5)
```

With the modified values, you should be able to hear the instrument sound for longer and
shorter durations as you update and re-evaluate the code.  


### Frequency

Next, try keeping the same duration but modifying the frequency.  
Try using the values 110, 220, 880 in place of the 440, like so:  

```csound
schedule("Sub1", 0, 2, 110, 0.5)
schedule("Sub1", 0, 2, 220, 0.5)
schedule("Sub1", 0, 2, 880, 0.5)
```

You should hear the `Sub1` instrument sounding at different octaves of the A
scale degree. 

Now, it may seem odd that we use frequency here as we might tend to think more
about scales and note numbers and things like that.  Don't worry, we'll have
ways to work with those kinds of values by using additional opcode calls.  (The
reason the instruments take in frequency is that it permits the end user to
choose whatever tuning or pitch system they would like to use and makes the
instruments reusable for everyone.)

### Amplitude

Next, try modifying just the last value. Be **very** careful to use numeric
values between 0 and 1.0: setting a value larger than 1.0 can cause very loud
output!  


```csound
schedule("Sub1", 0, 2, 110, 0.25)
schedule("Sub1", 0, 2, 220, 0.1)
schedule("Sub1", 0, 2, 880, 0.05)
```

Like frequency, we probably are used to thinking of values in some other scale,
such as decibels, dynamic marking (e.g., "f", "mp", "p"), or MIDI amp values.
For the same reason as frequency, the instruments are made to be flexible and
reusable and we will go through some different ways to work with amplitude in
later tutorials. 


### Instrument Name

Finally, let's experiment with instrument name. csound-live-code provides a set
of pitched instruments as well as percussion instruments (from Iain McCurdy's
TR808 simulation).  All of these instruments take in five parameters, though
the unpitchedinstruments will ignore the frequency value.

| Pitched | 
| ------- | 
| Sub1 |       `            
| Sub2 |
| Sub3 |
| Sub4 |
| Sub5 |
| SynBrass |
| Plk |
| Bass |
| VoxHumana |
| FM1 |
| Noi |
| Wobble |

| Percussion |        
| ---------- |        
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
|  Claves |  |
|  Cowbell |  
|  Maraca   | 
|  HiConga  | 
|  MidConga   |  
|  LowConga   |  

In your code, try replacing the "Sub1" with each of the above and evaluting the updated code to hear what each patch sounds like. 
