# csound-live code 

Author: Steven Yi\<stevenyi@gmail.com\>

## Introduction 

*csound-live-code* is a library, framework, and web application for live coding and music making with Csound. The core is a library, [livecode.orc](../livecode.orc), that contains a number of user-defined opcodes and instruments. These opcodes and instruments provide a foundation for live coding of music with Csound and provide abstractions like a metronome, tempo, duration units (i.e., ticks, beats, bars), scales, and pattern creation tools.  The parts all work together to form a framework for live coding with callback instruments or temporal recursion. This library is used with desktop Csound installations as well as used as part of the [http://live.csound.com](http://live.csound.com) web application. 

## Documentation

__Getting Started__

* [Using the live.csound.com Web Application](webinterface.md)

__Concepts__

* Live Coding Concepts 
* Session Lifecycle 
* Central Clock 
* Callback Instrument
* Temporal Recursion
* Synthesizer Instruments
* Utility User-defined Opcodes

__Reference__

* [Cheatsheet](cheatsheet.md)
* [UDO Reference](udoreference.md)
* [Instrument Reference](instruments.md)





