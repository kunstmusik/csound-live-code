f = open("../livecode.orc", "r")
lines = f.readlines()
f.close()


state = 0

udos = []
udo = None

instrs = []
instr = None

lastComment = None 

for i,l  in enumerate(lines):
    line = l.strip()

    if line.startswith('/**'):
        if line.endswith('*/'): 
            lastComment = [line[3:-2]]
        else:
            lastComment = [line[3:]]
            state = 3
    elif state == 0:
        if line.startswith('opcode'):
            args = line[6:].split(',')
            udo = {'name': args[0].strip().replace("_", "\\_"), 'outtypes': args[1].strip().replace("_", "\\_"), 
                    'intypes': args[2].strip().replace("_", "\\_"), 'xin': '', 'xout': '',
                    'doc': lastComment if lastComment else ''}
            state =1
        elif line.startswith('instr'):
            # print(lastComment)
            instr = {'name': line[5:].split(';')[0], 
                    'doc': lastComment if lastComment else ''}
            state =2
    elif state == 1:
        if line.endswith('endop'): 
            udos.append(udo)
            udo = None
            state = 0
            lastComment = None
        elif 'xin' in line:
            udo['xin'] = line[:-3]
        elif 'xout' in line:
            udo['xout'] = line[4:].split(',')
        else:
            pass
    elif state == 2:
        if line.endswith('endin'): 
            instrs.append(instr)
            instr = None
            state = 0
            lastComment = None
        else:
            pass
    elif state == 3:
        if line.endswith('*/'): 
            lastComment.append(line[:-2])
            state = 0
        else:
            lastComment.append(line)

    elif len(line) == 0:
        pass
    else:
        lastComment = None

udoTable = ''

for i in udos:
    out = i['outtypes'] 
    out = '' if (out == '0') else out + 'val'
    xin = i['xin']
    xin = '' if (xin == '0') else xin
    # v = "{0:8}\t{1:12}\t{2}".format(out, i['name'], xin)
    v = "| {0} | **{1}** | {2} |\n".format(out, i['name'], xin)
    # print v 
    udoTable = udoTable + v

f = open("cheatsheet.md", "w")
f.write("# Live Code Cheatsheet\n\n")
f.write("## User-Defined Opcodes\n\n")
f.write("|Outputs | Opcode | Inputs |\n")
f.write("| ---- | ---- | ---- |\n")
f.write(udoTable)
f.write("## Instruments\n\n")
f.write("|Instrument Name | \n")
f.write("| ---- | \n")
for i in instrs:
    if(i['doc']):
        f.write("| {0} | \n".format(i['name']))
f.flush()
f.close()

print "Generated cheatsheet.md"


f = open("reference.md", "w")
f.write("# Live Code Reference\n\n")
f.write("## Opcodes\n\n")

for i in udos:
    out = i['outtypes'] 
    out = None if (out == '0') else out + 'val'
    xin = i['xin']
    xin = None if (xin == '0') else xin.strip()
    # v = "{0:8}\t{1:12}\t{2}".format(out, i['name'], xin)
    if(out):
        v = "{0} = **{1}**({2})\n".format(out, i['name'], xin)
    else:
        v = "**{0}**({1})\n".format(i['name'], xin)
    f.write(v)
    doc = '\n'.join(i['doc'])[1:].replace("_", "\\_")
    f.write("\n{0}\n\n---\n\n".format(doc)) 

f.write("## Instruments\n\n")
f.write("|Instrument Name | Description |\n")
f.write("| ---- | ---- | \n")
for i in instrs:
    if(i['doc']):
        doc = ' '.join(i['doc'])[1:].replace("_", "\\_")
        f.write("| {0} | {1} | \n".format(i['name'], doc))

f.flush()
f.close()

print "Generated reference.md"
