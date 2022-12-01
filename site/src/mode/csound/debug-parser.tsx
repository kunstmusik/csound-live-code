import React from "react";
import { Tree } from "@lezer/common";
import { parser } from "./syntax.grammar";
import { printTree } from "./print-tree";

const instrBlock = `


<CsoundSynthesizer>
<CsInstruments>
sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1
struct TypeX val1:i
declare myFun(arg1:TypeX):(TypeX)
instr 1
  varX:TypeX init 1
  varY:TypeX = myFun(varX)
  print(varY.val1)
endin
opcode myFun(arg1:TypeX):TypeX
  retVal:TypeX init arg1.val1 + 1
  xout(retVal)
endop
</CsInstruments>
<CsScore>
i1 0 0
e
</CsScore>
</CsoundSynthesizer>

`;

export const ParserDebugger = () => {
    const [value, setValue] = React.useState(instrBlock);

    React.useEffect(() => {
        try {
            console.log(printTree(parser.parse(value) as Tree, instrBlock));
        } catch (error) {
            console.log(value);
            console.error(error);
        }
    }, [value]);

    return (
        <>
            <style>{`h1 {color: white;}`}</style>
            <textarea
                value={value}
                style={{ minWidth: 500, minHeight: 800 }}
                onChange={(event: any) => setValue(event.target.value)}
            ></textarea>
        </>
    );
};
