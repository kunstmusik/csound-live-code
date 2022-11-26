import { defaultKeymap, history, historyKeymap } from "@codemirror/commands";
import { StreamLanguage } from "@codemirror/language";
import { Prec } from "@codemirror/state";
import { keymap } from "@codemirror/view";
import { Csound, CsoundObj } from "@csound/browser";
import { okaidia } from "@uiw/codemirror-theme-okaidia";
import CodeMirror from "@uiw/react-codemirror";
import { useEffect, useState } from "react";
import startOrc from "../../start.orc?raw";
import { restartCsound } from "./actions";
import "./App.css";
import { createKeymap } from "./commands";

// @ts-ignore
import {
  Button,
  Center,
  ChakraProvider,
  createLocalStorageManager,
  Text,
  VStack
} from "@chakra-ui/react";
import { flashPlugin } from "./flash";
import Header from "./Header";
import { csoundMode } from "./mode/csound";
import theme from "./Theme";

const manager = createLocalStorageManager("csound-live-code-color-mode");

enum RunState {
  LOADING,
  REQUIRES_START,
  RUNNING,
}

function App() {
  const [running, setRunning] = useState<RunState>(RunState.LOADING);
  const [csound, setCsound] = useState<CsoundObj>();
  const [audioContext, setAudioContext] = useState<AudioContext>();

  useEffect(() => {
    (async () => {
      const cs = await Csound({ useWorker: false });
      if (!cs) {
        alert("Error loading csound, please refresh and try again.");
        return;
      }
      setCsound(cs);
      const context = await cs.getAudioContext();
      setAudioContext(context);

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
    <ChakraProvider theme={theme} colorModeManager={manager}>
      { csound && running == RunState.RUNNING ? (
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
      ) : running === RunState.REQUIRES_START ? (
        <Center h="100vh">
          <Button onClick={finishLoadCsObj}>Start</Button>
        </Center>
      ) : 
        <Center h="100vh">
          <Text>Loading...</Text> 
        </Center>
    }
    </ChakraProvider>
  );
}

export default App;
