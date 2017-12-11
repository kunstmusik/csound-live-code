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
                    'intypes': args[2]}
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

for i in udos:
    out = i['outtypes'] 
    out = '' if (out == '0') else out + 'val'
    v = "{0:8}\t{1:12}\t{2}".format(out, i['name'], i['xin'])
    print v 
