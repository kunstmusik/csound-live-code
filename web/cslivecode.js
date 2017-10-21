function loadCSD(editor, csdFile) {
  var client = new XMLHttpRequest();

  client.open('GET', csdFile, true);
  client.onreadystatechange = function() {
    editor.setValue(client.responseText);
  }
  client.send();
}
