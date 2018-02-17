f = open("../livecode.orc", "r")
lines = f.readlines()
f.close()


state = 0

udos = []
udo = None

for i,l  in enumerate(lines):
    line = l.strip()
    if state == 0:
        if line.startswith('opcode'):
            args = line[6:].split(',')
            udo = {'name': args[0], 'outtypes': args[1].strip(), 
                    'intypes': args[2], 'xin': '', 'xout': ''}
            state =1
    else:
        if 'endop' in line: 
            udos.append(udo)
            udo = None
            state = 0
        elif 'xin' in line:
            udo['xin'] = line[:-3]
        elif 'xout' in line:
            udo['xout'] = line[4:].split(',')
        else:
            pass

udoTable = ''

for i in udos:
    out = i['outtypes'] 
    out = '' if (out == '0') else out + 'val'
    xin = i['xin']
    xin = '' if (xin == '0') else xin
    # v = "{0:8}\t{1:12}\t{2}".format(out, i['name'], xin)
    v = "| {0} | _{1}_ | {2} |\n".format(out, i['name'], xin)
    # print v 
    udoTable = udoTable + v

f = open("cheatsheet.md", "w")
f.write("# Live Code User-Defined Opcodes\n\n")
f.write("|Outputs | Opcode | Inputs |\n")
f.write(udoTable)
f.flush()
f.close()


print "Generated cheatsheet.md"
