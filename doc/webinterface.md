# Using the live.csound.com Web Application 

## Introduction

[https://live.csound.com](https://live.csound.com) is a web application for
live coding with Csound. Thes application uses the WebAssembly version of
Csound and only requires that the user open the website in a browser capable of
supporting Javascript, WebAudio, and WebAssembly. Examples of browsers capable
of supporting these requirements include Chrome, Safari, Firefox, and Edge on
desktop systems (e.g., Windows 10, Linux, OSX), and Chrome, Safari, and Firefox
on mobile devices (i.e., Android and iOS).

When the web application loads, it will start Csound and evaluate the
[livecode.orc](../livecode.orc) library as well as start the framework (i.e.,
turn on the global clock).  The site is ready to go and the user can select and
evaluate code.  

## Add to Home Screen 

live.csound.com is a [Progressive Web Application
(PWA)](https://developers.google.com/web/progressive-web-apps/). PWAs can be
loaded as normal in a web browser, but may also be installed to your desktop or
mobile device homescreen. Once installed, the live.csound.com application may
be run as-if it was a standard application and may be run even when offline.
This can prove useful to test out short ideas while on the go and when in areas
where there is no internet connectivity. 

Browsers that support PWAs usually have some kind of menu option that says
something like "Add to Home Screen" or "Create Shortcut...".  If you can not
find the menu option to install the application, please consult the
documentation for your browser for more information. 


## User Interface

The live.csound.com application has the following interface elements:

* A pause/play button that can pause and resume the WebAudio engine for the page. 
* A restart button that reset and restart Csound, reloading livecode.orc.  
* An "Evaluate Now" button that evaluates code immediately.  
* An "Evaluate at Measure" button that evaluates code at the next 4/4 measure.  
* A help button that links to this documentation.
* The main code editor for live coding using the Csound Orchestra language.

Users will primarily interact with the application by writing and evaluating
Csound code. Keyboard shortcuts are used to trigger code evaluation immediately
or at the next measure, as well as for inserting template code.  

## Evaluating Code

The editor uses a smart set of rules for code evaluation. When the user presses
an evaluation shortcut:

1. If any code is explicitly selected, evaluate only the selected code.
2. If no code is selected, the editor checks to see if the cursor is currently
   within an instrument or opcode definition and, if so, evaluate the entire
   definition.
3. Otherwise, evaluate just the current line of text that the cursor is on.

When code is evaluated, the editor will visually flash the text that selection
that was used for evaluation.


## Keyboard Shortcuts

_The following shortcuts will also work with the OSX cmd- key instead of ctrl-._

|Shortcut | Description |
| ------- | ------------|
| ctrl-e  | evaluate the selected code immediately |
| ctrl-enter  | evaluate the selected code immediately |
| ctrl-shift-enter  | evaluate the selected code at next 4/4 measure |
| ctrl-h  | insert template hexplay() code |
| ctrl-j  | insert template euclidplay() code |
| ctrl-;  | toggle line comments |
| ctrl-alt-c  | toggle line comments (alternate shorcut for keyboards where ctrl-; does not work) |


