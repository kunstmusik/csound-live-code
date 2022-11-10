import { EditorView, Command, KeyBinding } from "@codemirror/view";
import { CsoundObj } from "@csound/browser";
import { getEvalText } from "./utils";
import { toggleComment } from "@codemirror/commands";
import { StateCommand } from "@codemirror/state";
import flash from "./flash";

let fadeCounter = 5;

const insertHexplay:Command = (editor: EditorView) => {
  const hexCode =
    'hexplay("8",\n' +
    '      "Sub5", p3,\n' +
    "      in_scale(-1, 0),\n" +
    "      fade_in(" +
    fadeCounter +
    ", 128) * ampdbfs(-12))\n";
  fadeCounter += 1;

  const range = editor.state.selection.main;
  editor.dispatch({
    changes: {
      from: range.from,
      to: range.to,
      insert: hexCode,
    },
  });
  return true;
};

const insertEuclidplay:Command = (editor: EditorView) => {
  const hexCode =
    "euclidplay(13, 32,\n" +
    '      "Sub5", p3,\n' +
    "      in_scale(-1, 0),\n" +
    "      fade_in(" +
    fadeCounter +
    ", 128) * ampdbfs(-12))\n";
  fadeCounter += 1;

  const range = editor.state.selection.main;

  editor.dispatch({
    changes: {
      from: range.from,
      to: range.to,
      insert: hexCode 
    },
 })
 return true;
};

export const evalCode = (csound: CsoundObj):Command => {
  return (editor: EditorView) => {
    let selectedText = getEvalText(editor);
    csound.compileOrc(selectedText.text);
    flash(editor, selectedText, "CodeMirror-highlight");

    return true;
  };
};

export const createKeymap = (csound: CsoundObj):KeyBinding[] => {
  const simpleMap:{[key:string]: Command | StateCommand} = {
    "Ctrl-E": evalCode(csound),
    "Cmd-E": evalCode(csound),
    "Ctrl-Enter": evalCode(csound),
    "Cmd-Enter": evalCode(csound),
    //   "Shift-Ctrl-Enter": evalCodeAtMeasure,
    //   "Shift-Cmd-Enter": evalCodeAtMeasure,
    "Ctrl-H": insertHexplay,
    "Cmd-H": insertHexplay,
    "Ctrl-J": insertEuclidplay,
    "Cmd-J": insertEuclidplay,
    "Ctrl-;": toggleComment,
    "Cmd-;": toggleComment,
    "Ctrl-Alt-C": toggleComment,
    "Cmd-Alt-C": toggleComment,
  };

  const keyMap = Object.keys(simpleMap).map(k => {
    const cmd = simpleMap[k];
    return { key: k, run: cmd};
  })
  return keyMap;
};
