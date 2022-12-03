import { EditorView} from "@codemirror/view";

let starts = [
    [/^\s*instr/, "instr"],
    [/^\s*endin/, "endin"],
    [/^\s*opcode/, "opcode"],
    [/^\s*endop/, "endop"]
  ];
  const startsWithOneOfThese = (txt:string) => {
    for (let i = 0; i < starts.length; i++) {
      if (txt.match(starts[i][0]) != null) {
        return starts[i][1];
      }
    }
    return null;
  };
  
  const findLineWithBlock = (editor:EditorView, start:number, direction:number, limit:number) => {
    const doc = editor.state.doc;
    for (let i = start; i != limit; i += direction) {
        // console.log(i, doc.line(i).text);
      let find = startsWithOneOfThese(doc.line(i).text);
      if (find != null) {
        return [i, find];
      }
    }
    return null;
  };

export const getEvalText = (editor: EditorView) => {
    const state = editor.state;
    const selection = state.selection;
    const doc = state.doc;
    let {from, to} = selection.main;
    let text = state.sliceDoc(from, to);
    if (from === to) {
      let prevBlockMark = findLineWithBlock(editor, doc.lineAt(from).number, -1, 0);
      let nextBlockMark = findLineWithBlock(editor,  doc.lineAt(from).number, 1, doc.lines + 1);

      if (
        prevBlockMark != null &&
        nextBlockMark != null &&
        ((prevBlockMark[1] === "instr" && nextBlockMark[1] === "endin") ||
          (prevBlockMark[1] === "opcode" && nextBlockMark[1] === "endop"))
      ) {
        from = doc.line(prevBlockMark[0] as number).from;
        to = doc.line(nextBlockMark[0] as number).to;
        text = state.sliceDoc(from, to);
      } else {
        const fromLine = doc.lineAt(from);
        from = fromLine.from;
        to = fromLine.to;
        text = fromLine.text;
      }
    }
    return { text, from, to };
  };
