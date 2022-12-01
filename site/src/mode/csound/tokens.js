import { ContextTracker } from "@lezer/lr";
import { BlockComment, LineComment, space, newline } from "./syntax.terms";

export const trackNewline = new ContextTracker({
    start: false,
    shift(context, term) {
        return term == LineComment || term == BlockComment || term == space
            ? context
            : term == newline;
    },
    strict: false
});

// export const ignoreInlineComments = new ExternalTokenizer(
//     (input, stack) => {
//         // let { next } = input;
//         console.log(input, stack);
//     },
//     { contextual: true, fallback: true }
// );
