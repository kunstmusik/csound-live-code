import { CsoundObj } from "@csound/browser";

const Header = ({csound}:{csound:CsoundObj}) => {
   return     <header>
   <h1>csound-live-code</h1>
   <nav>
     <i
       id="playPauseButton"
       className="bar-btn fas fa-pause-circle"
       title="Pause Engine"
     ></i>
     <i
       id="restartButton"
       className="bar-btn fas fa-redo-alt"
       title="Restart Engine"
     ></i>
     <i
       id="evalNowButton"
       className="bar-btn fas fa-code"
       title="Evaluate Now"
     ></i>
     <i
       id="evalMeasureButton"
       className="bar-btn fas fa-code"
       title="Evaluate at Measure"
     ></i>
   </nav>
   <i
     id="helpButton"
     className="bar-btn fas fa-question-circle"
     style={{float:"right"}}
     title="Open Documentation in new Window"
   ></i>
 </header>
}

export default Header;