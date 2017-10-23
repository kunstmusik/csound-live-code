function loadCSD(editor, csdFile) {
  var client = new XMLHttpRequest();

  client.open('GET', csdFile, true);
  client.onreadystatechange = function() {
    editor.setValue(client.responseText);
  }
  client.send();
}


var cs;


function onRuntimeInitialized() {
  var client = new XMLHttpRequest();
  client.open('GET', 'livecode.orc', true);
  client.onreadystatechange = function() {
    var txt = client.responseText;
    //editor.setValue(txt);
    cs = new CsoundObj();
    cs.setOption("-m0");
    cs.compileOrc(
      "sr=48000\nksmps=32\n0dbfs=1\nnchnls=2\n" + 
    txt);
    //cs.compileCSD(editor.getValue());
    cs.start();
    document.getElementById("loadDiv").remove();
    editor.refresh();
  }
  client.send();

}

