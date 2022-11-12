import fs from "fs"
import { execSync } from "child_process";

const f = process.argv[2]

if(!f) {
    console.error("Error: no file given");
    process.exit(1)
}

const orc = fs.readFileSync(f).toString();

const csd = `
<CsoundSynthesizer>
<CsOptions>
-Wdo out.wav -m0
</CsOptions>
<CsInstruments>

sr	= 48000	
ksmps	=	64
nchnls	=	2
0dbfs	=	1

#include "livecode.orc"

${orc}

event_i("e", 0, 60)

</CsInstruments>
</CsoundSynthesizer>
`
fs.writeFileSync('temp.csd', csd)
// console.log(csd)

execSync('csound temp.csd')