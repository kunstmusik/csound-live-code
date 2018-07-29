# Session Lifecycle

The following describes the basic lifecycle for a live coding session. 

## Basic Audio Engine Lifecycle

The following diagram shows the basic processing flow for an audio engine. The diagram shows the two main phases of initialization and runtime and will be further explained in the sections below.  

![Audio Engine Lifecycle](images/audio_engine.png)

## Initialization

When a users begins a session, they start their audio engine with a given set of options.  These options may be commandline flags, saved program settings, or other sources of configuration.  The program starts by processing these options and configuring the engine for runtime.  

Next, any initial code is evaluated. For example, a CSD document is often provided to Csound as the project to render. This initial code may describe fully everything that will be rendered--as is the case when creating non-realtime projects meant to render to disk--or it may be a basic setup for a realtime performance.  

In the case of csound-live-code, this project provides a main livecode.orc file that contains the entire library of code for the project. There is also a livecode.csd file provided that #include's livecode.csd and configures some other options.  One can use the CSD file as the initial code when working on a desktop system so that when Csound enters its main rendering loop, it will be ready for live coding.   

## Runtime

