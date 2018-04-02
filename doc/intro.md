# csound-live code 

Author: Steven Yi\<stevenyi@gmail.com\>

## Introduction 

*csound-live-code* is a library, framework, and web application for live coding with Csound. The core is a library, [livecode.orc](livecode.orc), that contains a number of user-defined opcodes and instruments. These opcodes and instruments provide a foundation for live coding of music with Csound and provide abstractions like a metronome, tempo, duration units (i.e., ticks, beats, bars), scales, and pattern creation tools.  The parts all work together to form a framework for live coding that uses callback instruments prefers referential transparency at its core. This library is used with desktop Csound installations as well as used as part of the [http://live.csound.com](http://live.csound.com) web application. 



## Live Coding Concepts 

### Session Lifecycle 


## Project Architecture

### Central Clock 

### The P1 Callback Instrument

### Temporal Recursion

### Synthesizer Instruments

### Utility User-defined Opcodes

## Web Application ([http://live.csound.com](http://live.csound.com))

This repository contains a single-page web application within the web folder. This web application uses the Web Assembly version of Csound to embed Csound into the web page and deliver a full Csound-based live coding environment through the web--no installation required.    

When the web application is loaded, the livecode.orc library is evaluated and the framework (i.e., clock) is started.  The site is ready to go and the user can select code and press ctrl-e to evaluate the code.  


### Keyboard Shortcuts

|Shortcut | Description |
| ------- | ------------|
| ctrl-e  | evaluate the selected code |
| ctrl-h  | insert template hexplay() code |
| ctrl-j  | insert template euclidplay() code |
| ctrl-;  | toggle line comments |



## Reference

* [Cheatsheet](cheatsheet.md)
* [UDO Reference](udoreference.md)
* [Instrument Reference](instruments.md)
