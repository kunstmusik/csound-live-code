import { defaultKeymap, history, historyKeymap } from "@codemirror/commands";
import { StreamLanguage } from "@codemirror/language";
import { Prec } from "@codemirror/state";
import { keymap } from "@codemirror/view";
import { Csound, CsoundObj } from "@csound/browser";
import { okaidia } from "@uiw/codemirror-theme-okaidia";
import CodeMirror, { ReactCodeMirrorRef } from "@uiw/react-codemirror";
import { useEffect, useRef, useState } from "react";
import startOrc from "../../start.orc?raw";
import { restartCsound } from "./actions";
import "./App.css";
import { createKeymap } from "./commands";

// @ts-ignore
import {
  Box,
  Button,
  Center,
  ChakraProvider,
  createLocalStorageManager,
  Text,
  VStack
} from "@chakra-ui/react";
import ConsoleOutput from "./ConsoleOutput";
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
      setAudioContext(context);

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
    <ChakraProvider theme={theme} colorModeManager={manager}>
      {csound && running == RunState.RUNNING ? (
        <VStack maxH="100vh" spacing="0">
          <Header
            csound={csound}
            code={code}
            showConsole={showConsole}
            setShowConsole={setShowConsole}
          />
          <Box w="full" h="full" overflow="auto">
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
                  StreamLanguage.define(csoundMode),
                  // basicSetup,

                  flashPlugin,
                ]}
              ></CodeMirror>
          </Box>

          {showConsole && <ConsoleOutput output={consoleOutput}/>}
        </VStack>
      ) : running === RunState.REQUIRES_START ? (
        <Center h="100vh">
          <Button onClick={finishLoadCsObj}>Start</Button>
        </Center>
      ) : (
        <Center h="100vh">
          <Text color="#666666">Loading...</Text>
        </Center>
      )}
    </ChakraProvider>
  );
}

export default App;
