import sys
import json

# Input JSON file from HPCorpus
input_file = sys.argv[1]

# Directory to store C programs for functions
# Ensure that the directory is created.
output_dir = sys.argv[2]

with open(input_file, 'r', encoding='utf-8') as f:
    i = 0
    for line in f:
        data = json.loads(line.strip())
        code = data['code']
        
        wfile = output_dir + "/" + str(i) + ".c"
        with open(wfile, 'w') as wf:
            wf.write(code)
        i = i + 1
        
