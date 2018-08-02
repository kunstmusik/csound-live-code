# Central Clock, Tempo, and Time Values

Csound has support for tempos and time values as beats, but only for its score language and score system.  At runtime, any events generated via the orchestra language use time values in seconds, not beats. This design evolved from Csound's non-realtime MUSIC-N roots and multiple-pass performance design. However, Csound comes with all of the necessary tools for building a central metronome, tempo, and time value system. livecode.orc provides pre-made time-related tools for you to use in your projects.  

## Central Clock

livecode.orc provides a central clock instrument that manages time according to a user-defined tempo (by default, the tempo is 120). As soon as livecode.orc is evaluated (e.g., when #include'd in a desktop CSD project; automatically done for user when using live.csound.com), the clock starts running. 

The clock performs following the operations:

1. Updates a global k-rate gk\_now variable with the current time in beats every block of processing.
2. Checks if a new clock tick has occurred. The livecode.orc clock uses 16th notes as the core clock tick. 
3. If a new clock tick is ready, update the gk\_clock\_tick variable and also fire an event to the `Perform` instrument. The Perform instrument in-turn fires a `P1` instrument which is what users can edit as the callback instrument for the clock. (The Perform intermediary instrument is there for users to redefine and add additional processing features. See [livecode-beatviz.csd](../livecode-beatviz.csd) for an example.)

The following are opcodes provided for interacting with the clock:

* reset\_clock() - Resets the clock's time back to 0 
* adjust\_clock(iadjust) - Adjust clock's time by given adjust value. Useful for manual synchronization of clock with another performer. 

## Tempo

The central clock operates using a global tempo value stored in the `gk_tempo` variable. Users can use the following opcodes to work with the tempo:

1. set\_tempo(itempo) - sets the tempo for the global clock in beats per minute.  
2. get\_tempo() - gets the current tempo for the global clock at init-time.  
3. go\_tempo(itarget\_tempo, itempo\_adjust) - update the tempo, moving towards the target tempo by the give adjustment amount.  Useful for moving towards a tempo over time. 


## Time Values

The library provides the following opcodes for calculating duration values according to the current tempo. The user may use these opcodes and the tempo system on their own without using the callback instrument system. These opcodes may also be used with non-integer values (e.g. beat(0.5) returns the duration of half a beat, or one 8th note)

1. now() - return current value of gk\_now beat time at init-time.
2. now\_tick() - return current value of clock tick at init-time.
3. ticks(inumticks) - calculate and return the duration of time in the given number of ticks (16th notes). 
4. beats(inumbeats) - calculate and return the duration of time in the given number of beats (quarter notes). 
5. measures(inummeasures) - calculate and return the duration of time in the given number of measures in 4/4 time. 
 

## Time Functions for Scheduling

Because Csound is a block-based processing system, events may fire when their start times occur anywhere within the duration of the block.  To accomodate for this when scheduling a following note (as when using temporal recursion), the following functions should be used to calculate start times that are aligned to the clock.

1. next\_beat(ibeatcount) - calculate and return time in beats from now, aligning to beat boundary. ibeat count is optional and defaults to 1. 
2. next\_measure() - calculate and return time for the next measure from now, aligning to beat boundary.  

