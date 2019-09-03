let cs;
let livecodeOrc = "";
let fadeCounter = 5;

// UI Elements

let playPauseButton = document.getElementById("playPauseButton"),
  restartButton = document.getElementById("restartButton"),
  helpButton = document.getElementById("helpButton"),
  evalNowButton = document.getElementById("evalNowButton"),
  evalMeasureButton = document.getElementById("evalMeasureButton");

let consoleOutput;

/* UI ACTION FUNCTIONS */

const updatePlayPauseUI = () => {
  if (CSOUND_AUDIO_CONTEXT.state == "running") {
    playPauseButton.className = "bar-btn fas fa-pause-circle";
    playPauseButton.title = "Pause Engine";
  } else {
    playPauseButton.className = "bar-btn fas fa-play-circle";
    playPauseButton.title = "Resume Engine";
  }
};

let starts = [
  [/^\s*instr/, "instr"],
  [/^\s*endin/, "endin"],
  [/^\s*opcode/, "opcode"],
  [/^\s*endop/, "endop"]
];
const startsWithOneOfThese = function(txt) {
  for (let i = 0; i < starts.length; i++) {
    if (txt.match(starts[i][0]) != null) {
      return starts[i][1];
    }
  }
  return null;
};

const findLineWithBlock = function(start, direction, limit) {
  for (let i = start; i != limit; i += direction) {
    let find = startsWithOneOfThese(editor.getLine(i));
    if (find != null) {
      return [i, find];
    }
  }
  return null;
};

const getEvalText = function() {
  let text = editor.getSelection();
  let from = editor.getCursor("from");
  let to = editor.getCursor("to");

  if (text === "") {
    let prevBlockMark = findLineWithBlock(from.line, -1, -1);
    let nextBlockMark = findLineWithBlock(from.line, 1, editor.lineCount());

    if (
      prevBlockMark != null &&
      nextBlockMark != null &&
      ((prevBlockMark[1] === "instr" && nextBlockMark[1] === "endin") ||
        (prevBlockMark[1] === "opcode" && nextBlockMark[1] === "endop"))
    ) {
      let handle = editor.getLineHandle(nextBlockMark[0]);
      from = { line: prevBlockMark[0], ch: 0 };
      to = { line: nextBlockMark[0], ch: handle.text.length };
      text = editor.getRange(from, to);
    } else {
      let handle = editor.getLineHandle(from.line);
      text = editor.getLine(from.line);
      from = { line: from.line, ch: 0 };
      to = { line: from.line, ch: handle.text.length };
    }
  }
  return { text, from, to };
};

const flash = function(txt, color) {
  let sel = editor.markText(txt.from, txt.to, { className: color });
  setTimeout(() => {
    sel.clear();
  }, 250);
};

const evalCode = () => {
  let selectedText = getEvalText();
  cs.compileOrc(selectedText.text);
  flash(selectedText, "CodeMirror-highlight");
};

const evalCodeAtMeasure = () => {
  let selectedText = getEvalText();
  // adding fudge of ticks(0.5) to ensure evaluated code is compiled before
  // next measure tick
  let code = `eval_at_time({{${selectedText.text}}}, next_measure() - ticks(0.5))`;
  cs.compileOrc(code);
  flash(selectedText, "CodeMirror-highlight-delayed");
};

const restart = () => {
  consoleOutput.innerHTML = "";

  cs.reset();
  cs.setMessageCallback(csoundMsgCallback);
  cs.setOption("-m0");
  cs.setOption("-odac");
  cs.setOption("-+msg_color=false");
  cs.compileOrc("ksmps=32\n0dbfs=1\nnchnls=2\nnchnls_i=1\n" + livecodeOrc);
  cs.start();
};

const insertHexplay = () => {
  const hexCode =
    'hexplay("8",\n' +
    '      "Sub5", p3,\n' +
    "      in_scale(-1, 0),\n" +
    "      fade_in(" +
    fadeCounter +
    ", 128) * ampdbfs(-12))\n";
  fadeCounter += 1;

  const doc = editor.getDoc();
  doc.replaceRange(hexCode, doc.getCursor());
};

const insertEuclidplay = () => {
  const hexCode =
    "euclidplay(13, 32,\n" +
    '      "Sub5", p3,\n' +
    "      in_scale(-1, 0),\n" +
    "      fade_in(" +
    fadeCounter +
    ", 128) * ampdbfs(-12))\n";
  fadeCounter += 1;

  const doc = editor.getDoc();
  doc.replaceRange(hexCode, doc.getCursor());
};

let editor = null;

const setupCodeMirror = () => {
  editor = CodeMirror(document.getElementById("csoundCodeEditor"), {
    lineNumbers: true,
    matchBrackets: true,
    autoCloseBrackets: true,
    theme: "monokai",
    mode: "csound",
    //fallthrough: 'default',
    //keyMap: "vim",
    extraKeys: CodeMirror.normalizeKeyMap({
      "Ctrl-E": evalCode,
      "Cmd-E": evalCode,
      "Ctrl-Enter": evalCode,
      "Cmd-Enter": evalCode,
      "Shift-Ctrl-Enter": evalCodeAtMeasure,
      "Shift-Cmd-Enter": evalCodeAtMeasure,
      "Ctrl-H": insertHexplay,
      "Cmd-H": insertHexplay,
      "Ctrl-J": insertEuclidplay,
      "Cmd-J": insertEuclidplay,
      "Ctrl-;": CodeMirror.commands.toggleComment,
      "Cmd-;": CodeMirror.commands.toggleComment,
      "Ctrl-Alt-C": CodeMirror.commands.toggleComment,
      "Cmd-Alt-C": CodeMirror.commands.toggleComment
    })
  });
};

const csoundMsgCallback = msg => {
  consoleOutput.innerHTML += msg + "\n";
};

const onRuntimeInitialized = () => {
  fetch("livecode.orc").then(function(response) {
    return response.text().then(function(v) {
      livecodeOrc = v;
      let ld = document.getElementById("loadDiv");
      consoleOutput = document.getElementById("consoleOutput");

      const finishLoadCsObj = function() {
        CSOUND_AUDIO_CONTEXT.resume().then(() => {
          cs = new CsoundObj();
          restart();

          if (ld != null) {
            ld.remove();
          }
          editor.refresh();
          editor.focus();
          editor.setCursor(0, 0);

          updatePlayPauseUI();
        });
      };

      if (CSOUND_AUDIO_CONTEXT.state != "running") {
        ld.innerHTML = "Tap to start Csound";
        ld.addEventListener("click", function() {
          finishLoadCsObj();
        });
      } else {
        finishLoadCsObj();
      }
    });
  });
};

/* UI SETUP */

const openHelp = () => {
  const url =
    "https://github.com/kunstmusik/csound-live-code/blob/master/doc/intro.md";
  window.open(url);
};

const playPause = () => {
  if (CSOUND_AUDIO_CONTEXT.state == "running") {
    CSOUND_AUDIO_CONTEXT.suspend().then(updatePlayPauseUI);
  } else {
    CSOUND_AUDIO_CONTEXT.resume().then(updatePlayPauseUI);
  }
};

function layoutComplete() {
  setupCodeMirror();

  // Prevent Refresh

  window.onbeforeunload = function() {
    return "Are you...sure?";
  };

  // ServiceWorker for PWA
  if ("serviceWorker" in navigator) {
    navigator.serviceWorker.register("./service-worker.js").then(function() {
      console.log("Service Worker Registered");
    });
  }

  fetch("start.orc").then(function(response) {
    return response.text().then(function(v) {
      editor.setValue(";; Select this code and press ctrl-e to evaluate\n" + v);
      editor.clearHistory();
    });
  });

  // Initialize Csound and load
  CsoundObj.importScripts("./web/csound/").then(() => {
    onRuntimeInitialized();
  });
  helpButton.addEventListener("click", openHelp);
  playPauseButton.addEventListener("click", playPause);
  restartButton.addEventListener("click", restart);
  evalNowButton.addEventListener("click", evalCode);
  evalMeasureButton.addEventListener("click", evalCodeAtMeasure);
}

// GOLDENLAYOUT CODE
const goldenLayoutConfig = {
  settings: {
    hasHeaders: false,
    constrainDragToContainer: true,
    reorderEnabled: true,
    selectionEnabled: false,
    popoutWholeStack: false,
    blockedPopoutsThrowError: true,
    closePopoutsOnUnload: true,
    showPopoutIcon: false,
    showMaximiseIcon: false,
    showCloseIcon: false
  },
  dimensions: {
    minItemHeight: 20
  },
  content: [
    {
      type: "column",
      content: [
        {
          type: "component",
          componentName: "Live Editor",
          componentState: { text: "Code Window" },
          isClosable: false
        },
        {
          type: "component",
          componentName: "Console",
          componentState: { text: "Console Output" },
          isClosable: false,
          height: 5
        }
      ]
    }
  ]
};

const myLayout = new GoldenLayout(
  goldenLayoutConfig,
  document.getElementById("layoutRoot")
);

myLayout.registerComponent("Live Editor", function(container, state) {
  container.getElement().html('<div id="csoundCodeEditor"></div>');
});

myLayout.registerComponent("Console", function(container, state) {
  container.getElement().html(`<div id="console">  
    <div class='headerTab'>Console</div>
    <div id='consoleWrapper'>
      <pre id='consoleOutput'></pre>
    </div>
  </div>`);
});

myLayout.on("initialised", layoutComplete);

myLayout.init();

window.onresize = () => {
  myLayout.updateSize();
};
