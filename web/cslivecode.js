var cs;
var livecodeOrc = "";
var fadeCounter = 5;

// UI Elements 

let playPauseButton = document.getElementById("playPauseButton"),
    restartButton = document.getElementById("restartButton"),
    helpButton = document.getElementById("helpButton");


const updatePlayPauseUI = () => {
    if(CSOUND_AUDIO_CONTEXT.state == "running") {
        playPauseButton.className = "bar-btn fas fa-pause-circle";
        playPauseButton.title = "Pause Engine";
    } else {
        playPauseButton.className = "bar-btn fas fa-play-circle";
        playPauseButton.title = "Resume Engine";
    }
}

let starts = [
    [/^\s*instr/, "instr"], 
    [/^\s*endin/, "endin"], 
    [/^\s*opcode/, "opcode"], 
    [/^\s*endop/, "endop"]];
const startsWithOneOfThese = function(txt) {
   for(let i = 0; i < starts.length; i++) {
        if(txt.match(starts[i][0]) != null) {
            return starts[i][1];
        }
   }
   return null;
}

const findLineWithBlock = function(start, direction, limit) {
    for(let i = start; i != limit; i += direction) {
        let find = startsWithOneOfThese(editor.getLine(i));
        if(find != null) {
            return [i, find];
        }
    }
    return null;
}

const getEvalText = function() {
    let text = editor.getSelection();
    let from = editor.getCursor("from");
    let to = editor.getCursor("to");

    if(text === "") {

        let prevBlockMark = findLineWithBlock(from.line, -1, -1);
        let nextBlockMark = findLineWithBlock(from.line, 1, editor.lineCount());

        if(prevBlockMark != null && nextBlockMark != null &&
            ((prevBlockMark[1] === "instr" && nextBlockMark[1] === "endin") || 
            (prevBlockMark[1] === "opcode" && nextBlockMark[1] === "endop"))) {
            let handle = editor.getLineHandle(nextBlockMark[0]);
            from = {line: prevBlockMark[0], ch: 0};
            to = { line: nextBlockMark[0], ch: handle.text.length};
            text = editor.getRange(from, to);
        } else {
            let handle = editor.getLineHandle(from.line);
            text = editor.getLine(from.line);
            from = { line: from.line, ch: 0 };
            to = { line: from.line, ch: handle.text.length };
        }
    } 
    return { text, from, to };
}

const flash = function(txt, color) {
    let sel = editor.markText(txt.from, txt.to, { className: color })
    setTimeout(() => { sel.clear() }, 250);
}

function evalCode() {
    let selectedText = getEvalText();
    flash(selectedText, "CodeMirror-highlight");
    cs.compileOrc(selectedText.text);
}

function evalCodeAtMeasure() {
    let selectedText = getEvalText();
    flash(selectedText, "CodeMirror-highlight-delayed");
    let code = `eval_at_time({{${selectedText.text}}}, next_measure())`;
    console.log("code: \n" + code);
    cs.compileOrc(code);
}

function restart() {
    cs.reset();
    cs.setOption("-m0");
    cs.setOption("-odac");
    cs.compileOrc(
        "ksmps=32\n0dbfs=1\nnchnls=2\nnchnls_i=1\n" + 
        livecodeOrc);
    cs.start();
}

function insertHexplay() {
    let hexCode = "hexplay(\"8\",\n" +
        "      \"Sub5\", p3,\n" +
        "      in_scale(-1, 0),\n" +
        "      fade_in(" + fadeCounter + ", 128) * ampdbfs(-12))\n";
    fadeCounter += 1;

    var doc = editor.getDoc();
    doc.replaceRange(hexCode, doc.getCursor());
}

function insertEuclidplay() {
    let hexCode = "euclidplay(13, 32,\n" +
        "      \"Sub5\", p3,\n" +
        "      in_scale(-1, 0),\n" +
        "      fade_in(" + fadeCounter + ", 128) * ampdbfs(-12))\n";
    fadeCounter += 1;

    var doc = editor.getDoc();
    doc.replaceRange(hexCode, doc.getCursor());
}


let editor = CodeMirror(document.getElementById("csoundCodeEditor"), 
    {
        lineNumbers: true,
        matchBrackets: true,
        autoCloseBrackets: true,
        theme: "monokai",
        mode: "csound",
        //keyMap: "vim",
        extraKeys: {
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
        },
    });

fetch('start.orc').then(function(response) {
    return response.text().then(function(v) {
        editor.setValue(";; Select this code and press ctrl-e to evaluate\n" + v);
        editor.clearHistory()
    });
});


function onRuntimeInitialized() {
    fetch('livecode.orc').then(function(response) {
        return response.text().then(function(v) {
            livecodeOrc = v;
            let ld = document.getElementById("loadDiv");

            let finishLoadCsObj = function() {
                CSOUND_AUDIO_CONTEXT.resume().then( () => {
                    cs = new CsoundObj();
                    restart();

                    if(ld != null) {
                        ld.remove();
                    }
                    editor.refresh();
                    editor.focus();
                    editor.setCursor(0,0);

                    updatePlayPauseUI();
                });
            }


            if(CSOUND_AUDIO_CONTEXT.state != "running") {
                ld.innerHTML = "Tap to start Csound";
                ld.addEventListener ("click", function() {
                    finishLoadCsObj();
                });
            } else {
                finishLoadCsObj();
            }

        });
    });


}


// Prevent Refresh

window.onbeforeunload = function() {
    return "Are you...sure?" 
};

// ServiceWorker for PWA
if ('serviceWorker' in navigator) {
    navigator.serviceWorker
        .register('./service-worker.js')
        .then(function() { console.log('Service Worker Registered'); });
}


// Initialize Csound and load
CsoundObj.importScripts("./web/csound/").then(() => {
    onRuntimeInitialized();
});


/* UI SETUP */

function openHelp() {
    let url = "https://github.com/kunstmusik/csound-live-code/blob/master/doc/intro.md";
    window.open(url);
}

const playPause = () => {
    if(CSOUND_AUDIO_CONTEXT.state == "running") {
        CSOUND_AUDIO_CONTEXT.suspend().then(updatePlayPauseUI);
    } else {
        CSOUND_AUDIO_CONTEXT.resume().then(updatePlayPauseUI);
    }

}


helpButton.addEventListener("click", openHelp);
playPauseButton.addEventListener("click", playPause);
restartButton.addEventListener("click", restart);
