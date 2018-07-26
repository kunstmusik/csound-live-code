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

    if line.startswith('/*'):
        lastComment = [line]
        state = 3
    if state == 0:
        if line.startswith('opcode'):
            args = line[6:].split(',')
            udo = {'name': args[0].strip(), 'outtypes': args[1].strip(), 
                    'intypes': args[2].strip(), 'xin': '', 'xout': '',
                    'doc': '\n'.join(lastComment) if lastComment != None else ''}
            state =1
        elif line.startswith('instr'):
            # print(lastComment)
            instr = {'name': line[5:].split(';')[0], 
                    'doc': '\n'.join(lastComment) if lastComment != None else ''}
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
        lastComment.append(line)
        if line.endswith('*/'): 
            state = 0
        else:
            pass
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
f.write("|Instrument Name | Description |\n")
f.write("| ---- | ---- | \n")
for i in instrs:
    f.write("| {0} | {1} | \n".format(i['name'], ''))
f.flush()
f.close()

print "Generated cheatsheet.md"


f = open("reference.md", "w")
# f.write("# Live Code - Instruments\n\n")
# f.write("|Instrument Name | Description |\n")
# f.write("| ---- | ---- | \n")
# for i in instrs:
#     f.write("| {0} | {1} | \n".format(i['name'], i['doc']))
f.flush()
f.close()

print "Generated reference.md"
