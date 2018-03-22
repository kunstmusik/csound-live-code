/* Algorave - Happy Algosix!

  Steven Yi<stevenyi@gmail.com>
  http://www.kunstmusik.com

  _ Greetings from Rochester, NY, USA! _ 

  Using: 
  
  * csound - http://csound.com
  * csound-live-code - https://github.com/kunstmusik/csound-live-code | http://live.csound.com
  * BeatViz - https://github.com/kunstmusik/BeatViz
  * vim with csound-vim, csound-repl plugins
  * tmux
  * Win10, MSYS2
*/

;;reset_clock()
set_tempo(124)
set_scale("min")

/* P1 callback instrument 
   for csound-live-code framework, called back every tick (16th note)

   p3 is duration of tick
   p4 is current tick number
*/
instr P1 

  ;; Sound Test
  hexplay("8000", 
      "Noi", p3,
      in_scale(1, 0),
      fade_in(5, 128) * ampdbfs(-12))


  /*hexplay("8",*/
  /*    "BD", p3,*/
  /*    in_scale(-1, 0),*/
  /*    ampdbfs(-3))*/

endin
