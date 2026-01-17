import { defaultKeymap, history, historyKeymap } from "@codemirror/commands";
import { Prec } from "@codemirror/state";
import { keymap } from "@codemirror/view";
import { Csound, CsoundObj } from "@csound/browser";
import { okaidia } from "@uiw/codemirror-theme-okaidia";
import CodeMirror, { ReactCodeMirrorRef } from "@uiw/react-codemirror";
import { useEffect, useRef, useState } from "react";
import SplitterLayout from "react-splitter-layout";
import "react-splitter-layout/lib/index.css";
import startOrc from "../../start.orc?raw";
import { restartCsound } from "./actions";
import { createKeymap } from "./commands";

import ConsoleOutput from "./ConsoleOutput";
import { flashPlugin } from "./flash";
import Header from "./Header";
import { csoundMode } from "./mode/csound/csound";

enum RunState {
  LOADING,
  REQUIRES_START,
  RUNNING,
}

function App() {
  const [running, setRunning] = useState<RunState>(RunState.LOADING);
  const [csound, setCsound] = useState<CsoundObj>();
  const [audioContext, setAudioContext] = useState<AudioContext>();
  const [showConsole, setShowConsole] = useState(false);
  const [consoleOutput, setConsoleOutput] = useState("");
  const [code, setCode] = useState(
    ";; Select this code and press ctrl-e to evaluate\n" + startOrc
  );

  const refs = useRef<ReactCodeMirrorRef>({});

  useEffect(() => {
    (async () => {
      const cs = await Csound({ useWorker: false });
      if (!cs) {
        alert("Error loading csound, please refresh and try again.");
        return;
      }
      setCsound(cs);
      const context = await cs.getAudioContext();
      setAudioContext(context as AudioContext);

      let consoleOutput = "";

      cs.addListener("message", (msg:string) => {
        consoleOutput += "\n" + msg;
        setConsoleOutput(consoleOutput);
      })

      if (context?.state === "running") {
        restartCsound(cs);
        setRunning(RunState.RUNNING);
      } else {
        setRunning(RunState.REQUIRES_START);
      }
    })();
  }, []);

  const finishLoadCsObj = function () {
    if (audioContext && csound) {
      audioContext?.resume().then(() => {
        restartCsound(csound);
        setRunning(RunState.RUNNING);
      });
    }
  };

  return (
    <div className="flex flex-col h-screen w-screen bg-bg-dark text-text-main overflow-hidden">
      {csound && running == RunState.RUNNING ? (
        <>
          <Header
            csound={csound}
            code={code}
            showConsole={showConsole}
            setShowConsole={setShowConsole}
          />
          <div className="flex-1 relative overflow-hidden">
            {showConsole ? (
                <SplitterLayout 
                    vertical 
                    percentage 
                    secondaryInitialSize={30} 
                    primaryMinSize={10} 
                    secondaryMinSize={10}
                >
                    <div className="w-full h-full overflow-auto">
                         <CodeMirror
                            ref={refs}
                            width="100%"
                            height="100%"
                            value={code}
                            onChange={setCode}
                            theme={okaidia}
                            extensions={[
                              history(),
                              Prec.highest(
                                keymap.of([
                                  ...createKeymap(csound),
                                  ...defaultKeymap,
                                  ...historyKeymap,
                                ])
                              ),
                              csoundMode(),
                              flashPlugin,
                            ]}
                          />
                    </div>
                    <ConsoleOutput output={consoleOutput}/>
                </SplitterLayout>
            ) : (
                <div className="w-full h-full overflow-auto">
                    <CodeMirror
                    ref={refs}
                    width="100%"
                    height="100%"
                    value={code}
                    onChange={setCode}
                    theme={okaidia}
                    extensions={[
                        history(),
                        Prec.highest(
                        keymap.of([
                            ...createKeymap(csound),
                            ...defaultKeymap,
                            ...historyKeymap,
                        ])
                        ),
                        csoundMode(),
                        flashPlugin,
                    ]}
                    />
                </div>
            )}
          </div>
        </>
      ) : running === RunState.REQUIRES_START ? (
        <div className="flex items-center justify-center h-screen">
          <button 
            onClick={finishLoadCsObj}
            className="px-4 py-2 bg-[#333333] hover:bg-[#444444] text-[#cccccc] text-base rounded-md shadow-lg transition-colors"
            >
            Start
          </button>
        </div>
      ) : (
        <div className="flex items-center justify-center h-screen">
          <p className="text-gray-400">Loading...</p>
        </div>
      )}
    </div>
  );
}

export default App;
