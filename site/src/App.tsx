import { defaultKeymap, history, historyKeymap } from "@codemirror/commands";
import { StreamLanguage } from "@codemirror/language";
import { Prec } from "@codemirror/state";
import { keymap } from "@codemirror/view";
import { Csound, CsoundObj } from "@csound/browser";
import { okaidia } from "@uiw/codemirror-theme-okaidia";
import CodeMirror from "@uiw/react-codemirror";
import { useState } from "react";
import startOrc from "../../start.orc?raw";
import { restartCsound } from "./actions";
import "./App.css";
import { createKeymap } from "./commands";

// @ts-ignore
import { Button, Center, ChakraProvider, createLocalStorageManager, VStack } from "@chakra-ui/react";
import { flashPlugin } from "./flash";
import Header from "./Header";
import { csoundMode } from "./mode/csound";
import theme from "./Theme";

const manager = createLocalStorageManager("csound-live-code-color-mode")


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
    <ChakraProvider theme={theme} colorModeManager={manager}>
      {running && csound ? (
        <VStack maxH="100vh" spacing="0">
          <Header csound={csound} />
          <CodeMirror
            width="100%"
            height="100%"
            value={
              ";; Select this code and press ctrl-e to evaluate\n" + startOrc
            }
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
              StreamLanguage.define(csoundMode),
              // basicSetup,

              flashPlugin,
            ]}
          ></CodeMirror>
        </VStack>
      ) : (
        <Center h="100vh">
          <Button onClick={initialize}>Start</Button>
        </Center>
      )}
    </ChakraProvider>
  );
}

export default App;
