import json
import sys

print('Processing:', sys.argv[1])

f = open(sys.argv[1])
perceval_json_data = json.load(f)
repo_metadata = perceval_json_data['data']

print(f'{repo_metadata["clone_url"]},{repo_metadata["created_at"]},{repo_metadata["updated_at"]},{repo_metadata["fork"]}')
