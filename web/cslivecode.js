var cs;
var livecodeOrc = "";
var fadeCounter = 5;

function evalCode() {
    cs.compileOrc(editor.getSelection());
}

function restart() {
    cs.reset();
    cs.setOption("-m0");
    cs.setOption("-odac");
    cs.compileOrc(
        "sr=48000\nksmps=32\n0dbfs=1\nnchnls=2\nnchnls_i=1\n" + 
        livecodeOrc);
    cs.start();
}

function insertHexplay() {
    let hexCode = "hexplay(\"fade\",\n" +
        "      \"S1\", p3,\n" +
        "      in_scale(-1, 0),\n" +
        "      fade_in(" + fadeCounter + ", 128) * ampdbfs(-12))\n";
    fadeCounter += 1;

    var doc = editor.getDoc();
    doc.replaceRange(hexCode, doc.getCursor());
}

function insertEuclidplay() {
    let hexCode = "euclidplay(13, 32,\n" +
        "      \"S1\", p3,\n" +
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
                "Ctrl-H": insertHexplay,
                "Ctrl-J": insertEuclidplay,
                "Ctrl-;": CodeMirror.commands.toggleComment,
        },
    });

fetch('start.orc').then(function(response) {
    return response.text().then(function(v) {
        editor.setValue(
            ";; Select this code and press ctrl-e to evaluate\n" + 
            ";; https://github.com/kunstmusik/csound-live-code/blob/master/doc/intro.md\n" +
            v);
        editor.clearHistory()
    });
});


function loadCSD(editor, csdFile) {
    var client = new XMLHttpRequest();

    client.open('GET', csdFile, true);
    client.onreadystatechange = function() {
        editor.setValue(client.responseText);
    }
    client.send();
}


function onRuntimeInitialized() {
    fetch('livecode.orc').then(function(response) {
        return response.text().then(function(v) {
            livecodeOrc = v;
            let ld = document.getElementById("loadDiv");

            let finishLoadCsObj = function() {
                cs = new CsoundObj();
                //cs.setOption("-m0");
                //cs.setOption("-odac");
                //cs.compileOrc(
                //    "sr=48000\nksmps=32\n0dbfs=1\nnchnls=2\nnchnls_i=1\n" + 
                //    v);

                //cs.start();
                restart();

                if(ld != null) {
                    ld.remove();
                }
                editor.refresh();
                editor.focus();
                editor.setCursor(0,0);
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


// UI CALLBACKS

let playPauseButton = document.getElementById("playPauseButton"),
    restartButton = document.getElementById("restartButton"),
    helpButton = document.getElementById("helpButton");


function openHelp() {
    let url = "https://github.com/kunstmusik/csound-live-code/blob/master/doc/intro.md";
    window.open(url);
}

const playPause = () => {
   if(CSOUND_AUDIO_CONTEXT.state == "running") {
       CSOUND_AUDIO_CONTEXT.suspend();
       playPauseButton.className = "bar-btn fas fa-play-circle";
       playPauseButton.title = "Resume Engine";
   } else {
       CSOUND_AUDIO_CONTEXT.resume();
       playPauseButton.className = "bar-btn fas fa-pause-circle";
       playPauseButton.title = "Pause Engine";
   }
}

        
helpButton.addEventListener("click", openHelp);
playPauseButton.addEventListener("click", playPause);
restartButton.addEventListener("click", restart);
