import json
import sys

file = sys.argv[1]
stackList = sys.argv[2]
f=open(file)
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

# print(enabledKeys)
new_list = list(set(stackList).intersection(enabledKeys))

print(new_list)
