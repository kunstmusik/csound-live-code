var cs;
var fadeCounter = 5;

function evalCode() {
	cs.compileOrc(editor.getSelection());
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


let editor = CodeMirror.fromTextArea(
	document.getElementById("csoundCodeEditor"), 
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
      cs = new CsoundObj();
      cs.setOption("-m0");
      cs.compileOrc(
        "sr=48000\nksmps=32\n0dbfs=1\nnchnls=2\n" + 
      v);

      cs.start();
      var ld = document.getElementById("loadDiv");
      if(ld != null) {
        ld.remove();
      }
      editor.refresh();
      editor.focus();
      editor.setCursor(0,0);
    });
  });


}

// Initialize Module before WASM loads

Module = {};
Module['wasmBinaryFile'] = 'web/wasm/libcsound.wasm';
Module['print'] = console.log;
Module['printErr'] = console.log;
Module['onRuntimeInitialized'] = onRuntimeInitialized;

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
