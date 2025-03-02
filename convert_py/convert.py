sample_ports_signals = """GND18D VCC18D GNDK GND18A VCCK TCKO VCC18A TCKI TEST MS5 MS4 MS3 MS2 MS1 MS0 PDN FRANGE NS0 NS1 NS2 NS3 CKOUT NS4 NS5 CIN FREF"""

def parse_and_format_verilog_corrected(input_str):
    lines = input_str.strip().split('\n')
    formatted_lines = []
    for line in lines:
        ports_signals = line.replace('', '').split()
        for port_signal in ports_signals:
            if '[' in port_signal:
                base_name, index = port_signal.split('[')
                index = index.rstrip(']')
                formatted_lines.append(f".{base_name}[{index}]({base_name}[{index}])")
            else:
                formatted_lines.append(f".{port_signal}({port_signal})")
    return formatted_lines

corrected_formatted_lines = parse_and_format_verilog_corrected(sample_ports_signals)

corrected_formatted_text = "\n".join(corrected_formatted_lines)
corrected_file_path = "formatted_verilog.txt"
with open(corrected_file_path, "w") as file:
    file.write(corrected_formatted_text)

corrected_file_path
