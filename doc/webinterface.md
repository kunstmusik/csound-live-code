# Using the live.csound.com Web Application 

## Introduction

[https://live.csound.com](https://live.csound.com) is a web application for live coding with Csound. Thes application uses the WebAssembly version of Csound and only requires that the user open the website in a browser capable of supporting Javascript, WebAudio, and WebAssembly. Examples of browsers capable of supporting these requirements include Chrome, Safari, Firefox, and Edge on desktop systems (e.g., Windows 10, Linux, OSX), and Chrome, Safari, and Firefox on mobile devices (i.e., Android and iOS).

When the web application loads, it will start Csound and evaluate the [livecode.orc](../livecode.orc) library as well as start the framework (i.e., turn on the global clock).  The site is ready to go and the user can select and evaluate code.  

## Add to Home Screen 

live.csound.com is a [Progressive Web Application (PWA)](https://developers.google.com/web/progressive-web-apps/). PWAs can be loaded as normal in a web browser, but may also be installed to your desktop or mobile device homescreen. Once installed, the live.csound.com application may be run as-if it was a standard application and may be run even when offline. This can prove useful to test out short ideas while on the go and when in areas where there is no internet connectivity. 

Browsers that support PWAs usually have some kind of menu option that says something like "Add to Home Screen" or "Create Shortcut...".  If you can not find the menu option to install the application, please consult the documentation for your browser for more information. 


## User Interface

The live.csound.com application has a minimal interface consisting of:

* A pause/play button that can stop and resume the WebAudio engine for the page. 
* A help button that links to this documentation.
* The main code editor for live coding using the Csound Orchestra language.

Users will primarily interact with the application by writing and evaluating Csound code. Keyboard shortcuts are used to trigger code evaluation immediately or at the next measure, as well as for inserting template code.  


## Keyboard Shortcuts

|Shortcut | Description |
| ------- | ------------|
| ctrl-e  | evaluate the selected code |
| ctrl-h  | insert template hexplay() code |
| ctrl-j  | insert template euclidplay() code |
| ctrl-;  | toggle line comments |


