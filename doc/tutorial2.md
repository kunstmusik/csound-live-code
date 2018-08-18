# Tutorial 2 - Let's make our own sound!

_WARNING: This tutorial is currently being written and contains incomplete material. This notice will be removed once the tutorial is complete. Thank you!_

## Introduction

In this tutorial, we're going to make our own sounds (instruments) and walk
through a basic live coding session with Csound. We will start by making a
simple sine tone instrument, next go through a series of iterations to make the
instrument sound nicer, then work with compound events, and finally program our
own simple sonic gesture. By the end of this tutorial, we will have some basic
experience live coding with Csound and be able to make sounds that might fit
well in an ambient music performance.

## Designing Our First Sound 

Let's start by loading up the web site and clearing out all of the code to
start with a fresh, empty code editor. Now,
let's start by typing in the following code:

```csound
instr Add
  asig = oscili(0.25, 440)
  out(asig, asig)
endin

schedule("Add", 0, 2)
```

Try selecting the code and evaluating it using `ctrl-enter`. If all is well, you 
should hear a 440 hertz sine tone that lasts two seconds. Congratulations and
welcome to live coding with Csound!

Now, there is a lot going on here that requires explanation. First, we just
wrote text in the Csound Orchestra Language to both define a new kind of
instrument, named "Add", and schedule running an instance of that instrument
at 0 second from now and for 2 seconds duration. The next few sub sections
get into a bit more detail about what this all means. The details are great,
but feel free to jump ahead to to the next section, "Developing the
Instrument", and see if it intuitively makes sense. If not, you can always
come back here later!

### Defining an Instrument

In Csound, _instruments_ are defined by users as processes which the Csound
engine will run. The definition of the instrument describes what processing
will happen when an instance of a instrument is run. In the above code, we
see the line beginning with `instr` followed by a name `Add`. The word
`instr` starts a new instrument definition and the word or number after
`instr` defines what the name or number of the instrument will be.
(Classically, Csound used only numbered instruments, but named instruments
can be a lot more convenient and it will be what we use in these tutorials.)
Jumping forward, the line that starts with `endin` finishes the definition of
the instrument. Every line of text in between the lines with `instr` and
`endin` are considered code that defines what processing the instrument will
do when it runs.

The _body_ of the instrument definition consists of two lines. Notice that
they are visually indented. We'll be using this practice whenever we
introduce new _blocks_ of code (such as instrument definition blocks,
conditional and iteration blocks, etc.) as it helps to see what code is
associated with what is currently being defined. 

As for the two lines of code, we can read them as follows:

1. First, we want an `oscili` opcode that is configured with parameters 0.25
and 440 and whose output will be assigned to the variable `asig`. 
2. Next, we want an `out` opcode that uses the values in `asig` and sends it
to Csound's output (i.e., to the sound card output).

But what is an _opcode_? Well, opcodes are individual units of processing
that can generate or process data or perform some kind of operation. Opcodes
may take in zero to many inputs and output zero to many outputs, as well as
have their own internal state data. In the language of classical computer
music, Csound's opcodes are _unit generators_.

We define instruments using series of opcodes that we configure and connect
together through constant values and variables. We can think of each opcode
as a module in a modular synthesizer, and an instrument as an entire
synthesizer.

Now, to use an opcode, we use the form of text as first the name of the
opcode; an opening parenthesis; an optional comma-separated list of words,
numbers, expressions, and other opcode calls; and a final closing
parenthesis. We call the inputs within the parentheses the opcode's
_arguments_ or _inputs_. 

To recap, we define instruments as processes. Instruments are made up of
opcodes, each capable of doing some sort of processing. Defining instruments
only defines what we want to do, but does not actually do anything. To run
the instrument, we need to create _instance_ of the instrument and tell
Csound to run it, and to do all that we need to use _events_.

#### Classical Syntax vs. Modern Syntax

One additional point though: the code I presented above is using a modern
version of Csound's Orchestra language that became available in Csound 6. In
the classical Csound syntax, we might write the above instrument as follows:

```csound
      instr   Add
asig  oscili  0.25, 440
      outc    asig, asig
      endin
```

This style uses one opcode call per line of text and has the general form of:

```
[outputs] opcode_name [inputs]
```

where outputs and inputs are commma-separated lists of words and numbers. 

I'll be using the modern syntax in this tutorial. It has some quirks due to being added to a language and system that's over 30 years old (and because we fully support backwards compatibility for the original code style), but hopefully you'll find it intuitive to use as we work through exercises. 

I would note that there is one scenario where we must use the older style syntax, which is when opcodes output multiple output values. You'll find that in these situations I will switch to using the older style syntax, but only in these situations.  (This is a limitation in Csound 6 that has been changed already in code destined for Csound 7.)


### Scheduling events

Once we have an instrument defined, we can create events using the schedule() opcode:

```csound
schedule("Add", 0, 2)
```

The schedule opcode takes in 3 mandatory arguments and any number of additional
arguments. What it say is "schedule to run an instance of the Add instrument,
at time 0, for 2 seconds duration". The call to schedule will then create an
event, schedule the event with the scheduler using relative start time, then
return.  It will be the scheduler itself that fires the event once the start
time has been reached.  (In this case, by using 0, we are saying "schedule an
event to start 0 seconds from now", which runs the instrument immediately.) 

If instruments are designed to use additional pfields, then you will need to
supply additional values as arguments when you use schedule. We'll see how that
works in the next section when we add pfields and update our schedule call.  
 
## Parameterizing the instrument

At this point, the `Add` instrument works and we can schedule a the instrument
to run and generate a 440 hertz sine tone. However, how we "play" the
instrument is pretty limited, as the instrument only has the default pfields.
Really, all we can do is change the duration of how long the instrument will
run.  

Let's make a small change now to add an additional pfield for frequency. We do
that by putting `p4` in our code where we want to receive a value.

```csound
instr Add
  asig = oscili(0.25, p4)
  out(asig, asig)
endin

schedule("Add", 0, 2, 440)
```

In the above, we've made two changes:

1. Updated our instrument to use a p4 value.  Csound's pfields are going to be
   either numbers or Strings (text data). For this tutorial we will use pfields
   as numbers. Also, anywhere we have a static number in our code, we can
   replace it with a pfield. (You could replace the 0.25 with a p5, for
   example.)
2. Updated our schedule call to use the value 440 as the fourth argument.  This
   will be assigned to the p4 variable when the Add instrument is run. 

At this point, we've made the instrument a little more versatile by making the oscilator frequency be a parameter.  Try changing what value you use for p4 (e.g., change 440 to 220, 330, 880, etc.) and re-evaluating the schedule line to hear sines with different frequencies.


## Adding another oscillator 

A simple sine is a good place to start, but lets now make the instrument a little more interesting.  

First, let's try changing the instrument to use two oscillators:

```csound
instr Add
  asig = oscili(0.25, p4)
  asig2 = oscili(0.25, p4 * 2)
  asum = asig + asig2
  out(asum, asum)
endin
```

What we've done here is add an additional `oscili` oscillator, running at two times the frequency value of p4. We then added the two signals together and assigned to the `asum` variable, then use that value as the output. Try evaluating the schedule() call now to hear the new sound.

One thing we can do now is use a slightly different assignment operation to make things a little shorter in code:

```csound
instr Add
  asig = oscili(0.25, p4)
  asig += oscili(0.25, p4 * 2)
  out(asig, asig)
endin
```

This version of the instrument sounds exactly the same as the previous version.  It uses a `+=` assignment to add the value generated on the right side of the `+=` to the value on the left side, then store it back in to the variable on the left.  The line with the `+=` is equivalent to writing `asig = asig + oscili(0.25, p4 *2)`. 

As we go through this tutorial, whenever we make a change to our code, it's important to test the change. In this case, we would re-select the instrument code, evaluate it, then select the schedule() code and evaluate that.  It's best to test often so that you don't make too many changes, find you have a problem, then scratch your head figuring out which of all the new changes made it stop working.  


## Shaping the output

The Add instrument is starting to make interesting sounds, but having it play at full volume for the full duration of the note can be a bit tiring. Let's modify the code now to shape the amplitude of the sound by using an exponential envelope generator, like so:


```csound
instr Add
  asig = oscili(0.25, p4)
  asig += oscili(0.25, p4 * 2)
  asig *= expon(1, p3, 0.001)
  out(asig, asig)
endin
```

The key change was adding one line, `asig *= expon(1, p3, 0.001)`.  This line uses the `*=` assignment which operates like the `+=` but multiplies the left-hand side value (i.e., code to the left to the assignment operator) by the results of the code on the right-hand side. That line is equivalent to `asig = asig * expon(1, p3, 0.001)`.  

`expon` is a classic Csound opcode that takes in 3 values: a start value, a duration, and an end value. The opcode generates an exponential curve going from the start value to the end value over the given duration. (Here we are using p3, the duration of the instrument instance we gave when calling `schedule()`.)  Exponential envelopes can not calculate to zero, so we use 0.001 as a target here. 

The sound is starting to have some life to it.  We could further shape the sound in various ways by changing amplitude values for the oscillators to get a different mix, introduce envelop generators like `expon` or `line` to replace static values (i.e., each oscillator could have a different envelope), make the frequency change over time, and so on.  It's pretty natural in Csound (and really, any synthesis system) to start off simple with static values, then iteratively add and change our code to further shape and contour the sound until we get the desired outcome. 

For now, let's leave the sound design here and take a look at how we're playing the instrument through scheduling events.  


## A Palette of Events

Up until now, we've been using a single `schedule()` opcode call to play exactly one instance of our instrument.  This leads to a one-to-one mapping of line of code to generated sound and is an important place to start. Even with this alone, we could sit and code and perform music.  However, if all we did was edit the one line of code and re-evaluate to get different notes at different times, it can be a little slow and probably limit what kinds of music we live code.  

A natural next step is to have multiple lines of code pre-written that we might then select and evaluate.  Think of it like have a piano keyboard in front of you: you have many keys that produce different notes on the same instrument and you select and hit a key to get a different sound. However, in our case, instead of physical keys, we'll have different lines of code we can select and evaluate. Try entering the following code:

```csound
schedule("Add", 0, 2, 440) 
schedule("Add", 0, 2, 550)
schedule("Add", 0, 2, 660)
schedule("Add", 0, 2, 880)
```

Now try evaluating each line of code one at a time (without selecting code, you can press ctrl-enter in the live.csound.com editor and it will run just the current line of code when not within an instrument). You should here an A, C#, E, and A one octave above. Each time you evalute the code, it will schedule and `Add` instrument to start immediately, run for two seconds, at the given frequency.  

Writing out multiple lines like this to create a palette of sounds is a good way to start exploring the sonic capabilities of an instrument and start the process of improvisation and performance.  


## Compound Events

Using a one-to-one event-to-sound mapping is a starting point. The next step is produce multiple sounds using a one-to-many action.  Let's start off by reusing the last example code. However, instead of evaluating one line at a time, try selecting two consecutive lines and evaluating the code. It's a simple step to take to start producing multiple notes with single gestures.

The next step to take is to modify the start times in our code:

```csound
schedule("Add", 0, 2, 440) 
schedule("Add", 2, 2, 550)
schedule("Add", 4, 2, 660)
schedule("Add", 6, 2, 880)
```

Here's I've changed each `schedule()` call to use start times of 0, 2, 4, and 6. If we evaluate the whole block of code, we will get a sequence of notes over time.  Again, we have a one-to-many action producing multiple tones, but now we're starting to extend our thinking process from working with text like and instrument to thinking about musical gestures in time. 

One thing to notice is unlike the step before, the code no longer lends itself to playing notes individually.  If we try to evaluate just the last two notes, it will schedule the first note at 4 seconds from now and the second note 6 seconds from now.  This is to say that the code we wrote has started to have a relationship to each other and needs to be used as a whole rather than as parts. (There are ways to get around this taking different data-based approaches which is beyond the scope of this tutorial.)

Now that we're working with a set of code that is starting to function as a single gesture, let's package our code in a way that expresses that intention using an instrument:  

```csound
instr Arpeggio 
  schedule("Add", 0, 2, 440) 
  schedule("Add", 2, 2, 550)
  schedule("Add", 4, 2, 660)
  schedule("Add", 6, 2, 880)
endin

schedule("Arpeggio", 0, 0)
```

Try evaluating the Arpeggio instrument and then the `schedule` line.  You should now here the arpeggio gesture run any time you run the one Arpeggio instrument. Also try evaluating the Arpeggio schedule line multiple times while other ones are running to hear the gesture running against itself. 

One interesting part here is that we are using a duration of 0 for the `schedule()` line.  The reason we do this here is that our Arpeggio instrument is made up of code that only runs at initialization time.  However, instruments will typically always run for the given duration when creating an instance of the instrument.  If we don't use the duration of 0, the instrument will run at performance time (like our sounding Add instrument) but it won't really do anything since there is no performance-time code.  Using the 0 duration gives us then two benefits: it ensures we don't waste any computational cycles running an effectively empty instrument at performance time and it also makes it easy to see in our code when we are calling instruments designed to just run at init-time.   


## Full Example

```csound
instr Add
  alfo = 1 + oscili(random(0.002, 0.01), random(0.2,3))
  
  asig = oscili(1, p4 * alfo)
  asig += oscili(1, p4 * 2 * alfo)
  
  asig *= 0.25 * p5 * expon(1, p3, 0.001)
  
  out(asig, asig)
endin

instr Chord
  isd = random(0, 12)
  schedule("Add", 0, 30, in_scale(rand(array(-1,0)), isd), ampdbfs(-12))
  schedule("Add", 0, 30, in_scale(rand(array(-1,0)), isd + 4), ampdbfs(-12))
endin

instr Run
  schedule("Chord", 0, 0)
  
  if(p4 < 5) then
    schedule(p1, 10, 1, p4 + 1)
  endif
endin

schedule("Run", 0, 0)
```
