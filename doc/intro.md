# csound-live-code 

Author: Steven Yi\<stevenyi@gmail.com\>

## Introduction 

*csound-live-code* is a library, framework, and web application for live coding and music making with Csound. The core is a library, [livecode.orc](../livecode.orc), that contains a number of user-defined opcodes and instruments. These opcodes and instruments provide a foundation for live coding of music with Csound and provide abstractions like a metronome, tempo, duration units (i.e., ticks, beats, bars), scales, and pattern creation tools.  The parts all work together to form a framework for live coding with callback instruments or temporal recursion. This library is used with desktop Csound installations as well as used as part of the [http://live.csound.com](http://live.csound.com) web application. 

## Documentation

__Getting Started__

* [Using the live.csound.com Web Application](webinterface.md)

__Concepts__

<!--* Live Coding Concepts -->
* [Session Lifecycle](session_lifecycle.md)
* [Basic Introduction to Csound](csound_basics.md)
* [Central Clock, Tempo, and Time Values](time.md)

__Technique__

* Events and Channels
* Temporal Recursion
* Callback Instrument
* Always-on Instruments

__Rhythm and Pattern Generation__

* [Event Time Oscillators](oscillators.md)
* [Hexadecimal Beats](hexadecimal_beats.md)

__Tutorial__

* [Tutorial 1: Let's make a sound!](tutorial1.md)
* [Tutorial 2: Let's make our own sound!](tutorial2.md)
* [Tutorial 3: Performing with a Feedback Delay](tutorial3.md)
* [Tutorial 4: Making Music in a Modular Style](tutorial4.md)

<!-- 
* [Events 1: Simple Events](tutorial2.md)
* [Events 2: Compound Events](tutorial3.md)
* [Events 3: Generating Notes with Loops](tutorial4.md)
* [Realtime Process Score Generation](tutorial5.md)
* [Temporal Recursion](tutorial6.md)
* [Callback Instrument](tutorial7.md)
* [Hex Beats](tutorial8.md)
* [Hex Melodic Lines](tutorial9.md)
-->

__Reference__

* [Cheatsheet](cheatsheet.md)
* [Reference](reference.md)



