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
at 0 second from now and for 2 seconds duration.

... continue here ...

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
