import { ViewPlugin, DecorationSet, ViewUpdate } from "@codemirror/view";

import { StateField, StateEffect } from "@codemirror/state";
import { Decoration } from "@codemirror/view";
import { EditorView } from "@codemirror/view";
import { Range } from "@codemirror/state";

// Effects can be attached to transactions to communicate with the extension
const addMarks = StateEffect.define<Range<Decoration>[]>(),
  filterMarks = StateEffect.define<any>();

export const flash = (
  editor: EditorView,
  txt: { text: string; from: number; to: number },
  color: string
) => {
  const flashMark = Decoration.mark({
    // attributes: {style: "text-decoration: line-through"}
    class: color,
  });

  console.log(flashMark);

  editor.dispatch({
    effects: addMarks.of([flashMark.range(txt.from, txt.to)]),
  });

  setTimeout(() => {
    editor.dispatch({
    effects: filterMarks.of((from:number, to:number) => to <= txt.from || from >= txt.to)
  })

  }, 250);
};

export const flashPlugin = StateField.define({
  // Start with an empty set of decorations
  create() {
    return Decoration.none;
  },
  // This is called whenever the editor updates—it computes the new set
  update(value, tr) {
    // Move the decorations to account for document changes
    value = value.map(tr.changes);
    // If this transaction adds or removes decorations, apply those changes
    for (let effect of tr.effects) {
      if (effect.is(addMarks))
        value = value.update({ add: effect.value, sort: true });
      else if (effect.is(filterMarks))
        value = value.update({ filter: effect.value });
    }
    return value;
  },
  // Indicate that this field provides a set of decorations
  provide: (f) => EditorView.decorations.from(f),
});

export default flash;
