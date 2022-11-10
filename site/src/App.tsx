import { useState } from "react";
import "./App.css";
import { Csound, CsoundObj } from "@csound/browser";
import { restartCsound } from "./actions";
import CodeMirror, { minimalSetup } from "@uiw/react-codemirror";
import { okaidia } from "@uiw/codemirror-theme-okaidia";
import { keymap } from "@codemirror/view";
import { Prec } from "@codemirror/state";
import { StreamLanguage } from "@codemirror/language";
import { basicSetup } from "codemirror";
import { createKeymap } from "./commands";
import startOrc from "../../start.orc?raw";

// @ts-ignore
import { csoundMode } from "./mode/csound";
import Header from "./Header";
import { flashPlugin } from "./flash";

function App() {
  const [running, setRunning] = useState(false);
  const [csound, setCsound] = useState<CsoundObj>();
  const [audioContext, setAudioContext] = useState<AudioContext>();

  const initialize = async () => {
    // let ld = document.getElementById("loadDiv");
    // const consoleOutput = document.getElementById("consoleOutput");
    const cs = await Csound({ useWorker: false });
    if (!cs) {
      alert("Error loading csound, please refresh and try again.");
      return;
    }
    setCsound(cs);
    const context = await cs.getAudioContext();
    setAudioContext(context);

    const finishLoadCsObj = function () {
      context?.resume().then(() => {
        restartCsound(cs);
        setRunning(true);

        // editor.refresh();
        // editor.focus();
        // editor.setCursor(0, 0);

        // updatePlayPauseUI();
      });
    };

    if (context?.state === "running") {
      finishLoadCsObj();
    }
  };

  return (
    <div className="App">
      {running && csound ? (
        <div>
          <Header csound={csound} />
          <CodeMirror
            width="100%"
            height="100%"
            value={
              ";; Select this code and press ctrl-e to evaluate\n" + startOrc
            }
            theme={okaidia}
            extensions={[
              Prec.highest(keymap.of(createKeymap(csound))),
              StreamLanguage.define(csoundMode),
              basicSetup,
              flashPlugin
            ]}
          ></CodeMirror>
        </div>
      ) : (
        <div
          style={{
            width: "100%",
            height: "100%",
            alignItems: "center",
            justifyContent: "center",
            display: "flex"
          }}
        >
          <button onClick={initialize}>
            Start
          </button>
        </div>
      )}
    </div>
  );
}

export default App;
