import { CsoundObj } from "@csound/browser";
import { saveAs } from "file-saver";
import liveCodeOrc from "../../livecode.orc?raw";

export const restartCsound = async (csound: CsoundObj) => {
  // consoleOutput.innerHTML = "";
  // console.log(csound);
  if (!csound) return;

  await csound.stop();
  await csound.reset();
  // await csound.on("message", csoundMsgCallback);
  await csound.setOption("-m0");
  await csound.setOption("-odac");
  await csound.setOption("-+msg_color=false");
  await csound.setOption("--daemon");
  await csound.compileOrc(
    "ksmps=32\n0dbfs=1\nnchnls=2\nnchnls_i=1\n" + liveCodeOrc
  );
  await csound.start();
};

export const openHelp = () => {
  const url =
    "https://github.com/kunstmusik/csound-live-code/blob/master/doc/intro.md";
  window.open(url);
};

export const saveDocument = (fileName: string, fileContents: string) => {
  const orcFileName = fileName.toLowerCase().endsWith(".orc")
    ? fileName
    : fileName + ".orc";
  const blob = new Blob([fileContents], {type: "text/plain;charset=utf-8"});

  saveAs(blob, orcFileName);
};
