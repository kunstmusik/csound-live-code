# Tutorial 1 - Let's make a sound!

## Introduction

In this tutorial, we're going to walk through a basic live coding session
with Csound. We'll start off by making a simple sine tone instrument and
learning how to fire events to make sounds with that instrument. From there
we will go through a series of iterations to make the instrument sound nicer,
work with compound events, and program our own simple sonic gesture. By the
end of this tutorial, we will have some basic experience live coding with
Csound and be able to make sounds that might fit well in an ambient music
performance.

## About the Web Environment

Let's get started by opening up the
[csound-live-code](https://live.csound.com) web application. When the
application finishes loading, you should see the top bar with a pause/play
button and a help button, as well as the primary code editing area. The code
editor will, by default, contain the current example snapshot. Just to
double-check that everything is working alright, click into the code editor
to give it focus, press `ctrl-a` to select all of the text, then press
`ctrl-e` to evaluate the code. At this point, you should begin to hear a
musical example playing.

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

If you're not seeing anything obvious reported there, contact the author.
Testing usually happens on Windows 10 with Chrome, Firefox, and Edge; Chrome
OS browser; and Chrome on Android; and it could be you are using a
configuration that the author needs to research and test on.

## Our First Sound 

Assuming you've gotten everything working, let's refresh the web site and
clear out all of the code to start with a fresh, empty code editor. Now,
let's start by typing in the following code:

```csound
instr Add
  asig = oscili(0.25, 440)
  out(asig, asig)
endin

schedule("Add", 0, 2)
```

(Note: For these tutorials, you're welcome to copy/paste code to try things
out. However, if you have the time, I'd recommend typing in the code
yourself. I think you'll learn things better and more quickly by doing so.)

Try selecting the code and evaluating it using `ctrl-e`. If all is well, you 
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

I'll be using the modern syntax in this tutorial. It has some quirks due being added to a language and system that's over 30 years old (and because we fully support backwards compatibility and need to suppor the older style within the system), but hopefully you'll find it intuitive to use as we work through exercises. 

I would note that there is one scenario where we must use the older style syntax, which is when opcodes output multiple output values. You'll find that in these situations I will switch to using the older style syntax, but only in these situations.  (This is a limitation in Csound 6 that has been changed already in code destined for Csound 7.)


### Scheduling events



## Developing the instrument

At this point, the `Add` instrument works and we can schedule a the instrument to run and generate a 440 hertz sine tone.  If we select

## Full Example

```csound
instr Add
  
  alfo = 1 + oscili(random(0.002, 0.01), random(0.2,3))
  
  asig = oscili(1, p4 * alfo)
  asig += oscili(1, p4 * 2 * alfo)
  
  asig *= 0.25 * p5 * expon(1, p3, 0.001)
  
  outc(asig, asig)
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
