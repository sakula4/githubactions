import json;
import sys;
import os;
import ast;


print(os.getenv('metadata_stack'))
print(os.getenv('update_stack'))
print(os.getenv('baseline_stack'))
print(os.getenv('networking_stack'))
print(os.getenv('tableau_stack'))
print(os.getenv('datalake_stack'))

metadata_stack = ast.literal_eval(os.getenv('metadata_stack'))
update_stack = ast.literal_eval(os.getenv('update_stack'))
baseline_stack = ast.literal_eval(os.getenv('baseline_stack'))
networking_stack = ast.literal_eval(os.getenv('networking_stack'))
tableau_stack = ast.literal_eval(os.getenv('tableau_stack'))
abc_stack = ast.literal_eval(os.getenv('abc_stack'))
datalake_stack = ast.literal_eval(os.getenv('datalake_stack'))

print(metadata_stack)
print(update_stack)
print(baseline_stack)
print(networking_stack)
print(tableau_stack)
print(abc_stack)
print(datalake_stack)



fileName = sys.argv[1];

f= open(fileName);
enabledKeys = []
data = json.load(f)

localData = data['locals']
for x in localData:
    keys = x.keys();
    for key in keys:
        internalData = localData[0][key];
        if type(internalData) is dict:
            internalKeys = internalData.keys()
            for internalKey in internalKeys:
                if (internalKey == 'enabled' and internalData.get('enabled')) :
                    enabledKeys.append(key);

metadata_layers = list(set(metadata_stack).intersection(enabledKeys))
datadog_layers = list(set(update_stack).intersection(enabledKeys))
baseline_layers = list(set(baseline_stack).intersection(enabledKeys))
networking_layers = list(set(networking_stack).intersection(enabledKeys))
tableau_layers = list(set(tableau_stack).intersection(enabledKeys))
abc_layers = list(set(abc_stack).intersection(enabledKeys))
datalake_layers = list(set(datalake_stack).intersection(enabledKeys))


print(metadata_layers)
print(datadog_layers)
print(baseline_layers)
print(networking_layers)
print(tableau_layers)
print(abc_layers)
print(datalake_layers)
