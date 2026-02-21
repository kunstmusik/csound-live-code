# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "csdoc>=0.1.4",
# ]
# ///

import os

def generate_docs():
    # Determine paths
    script_dir = os.path.dirname(os.path.abspath(__file__))
    root_dir = os.path.dirname(script_dir)
    orc_path = os.path.join(root_dir, "livecode.orc")

    try:
        from csdoc.parser.csound import CsoundParser
    except ImportError:
        print("Error: csdoc library not found. Please ensure it is installed.")
        return

    try:
        parser = CsoundParser()
        entries = parser.parse_project(orc_path)
    except FileNotFoundError:
        print(f"Error: Could not find {orc_path}")
        return

    # Process data
    udos = []
    instrs = []

    for entry in entries:
        if hasattr(entry, "inputs") and hasattr(entry, "outputs"):
            udos.append(entry)
        else:
            instrs.append(entry)

    # Generate cheatsheet.md
    cheatsheet_path = os.path.join(script_dir, "cheatsheet.md")
    with open(cheatsheet_path, "w") as f:
        f.write("# Live Code Cheatsheet\n\n")
        f.write("## User-Defined Opcodes\n\n")
        f.write("|Outputs | Opcode | Inputs |\n")
        f.write("| ---- | ---- | ---- |\n")
        
        for udo in udos:
            out_str = getattr(udo, "outputs", "")
            returns = getattr(udo, "returns", [])
            
            out_names = []
            if out_str and out_str != "void":
                for i, char in enumerate(out_str):
                    # Check if we have a named return in docblock
                    if i < len(returns) and returns[i].name:
                        out_names.append(returns[i].name)
                    else:
                        base = char + "val"
                        # If multiple outputs, autonumber
                        if len(out_str) > 1:
                            out_names.append(f"{base}{i+1}")
                        else:
                            out_names.append(base)
            
            out_formatted = ", ".join(out_names)
            
            args = getattr(udo, "arg_names", [])
            types = getattr(udo, "inputs", "")
            
            in_str = ", ".join(args)
            if not args and types:
                 in_str = types
                 
            name = udo.name.replace("_", "\\_")
            
            f.write(f"| {out_formatted} | **{name}** | {in_str} |\n")

        f.write("## Instruments\n\n")
        f.write("|Instrument Name | \n")
        f.write("| ---- | \n")
        for instr in instrs:
            name = instr.name.replace("_", "\\_")
            f.write(f"| {name} | \n")
            
    print("Generated cheatsheet.md")

    # Generate reference.md
    reference_path = os.path.join(script_dir, "reference.md")
    with open(reference_path, "w") as f:
        f.write("# Live Code Reference\n\n")
        f.write("## Opcodes\n\n")
        
        for udo in udos:
            out_str = getattr(udo, "outputs", "")
            returns = getattr(udo, "returns", [])
            name = udo.name
            
            out_names = []
            if out_str and out_str != "void":
                for i, char in enumerate(out_str):
                    if i < len(returns) and returns[i].name:
                        out_names.append(returns[i].name)
                    else:
                        base = char + "val"
                        if len(out_str) > 1:
                            out_names.append(f"{base}{i+1}")
                        else:
                            out_names.append(base)
                            
            opts_formatted = ", ".join(out_names)
            
            args = getattr(udo, "arg_names", [])
            types = getattr(udo, "inputs", "")
            
            args_formatted = ", ".join(args)
            if not args and types:
                 args_formatted = types
            
            name_escaped = name.replace("_", "\\_")
            
            if opts_formatted:
                header = f"{opts_formatted} = **{name_escaped}**({args_formatted})\n"
            else:
                header = f"**{name_escaped}**({args_formatted})\n"
            
            f.write(header)
            
            doc = getattr(udo, "description", "").replace("_", "\\_")
            f.write(f"\n{doc}\n\n---\n\n")

        f.write("## Instruments\n\n")
        f.write("|Instrument Name | Description |\n")
        f.write("| ---- | ---- | \n")
        
        for instr in instrs:
            name = instr.name.replace("_", "\\_")
            doc = getattr(instr, "description", "").replace("_", "\\_")
            doc = doc.replace("\n", " ")
            f.write(f"| {name} | {doc} | \n")

    print("Generated reference.md")

if __name__ == "__main__":
    generate_docs()
