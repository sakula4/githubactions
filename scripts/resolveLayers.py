import json
import sys
import ast

file = sys.argv[1]
stackList = sys.argv[2]
f=open(file)
enabledKeys = []
data = json.load(f)
stackList2 = ast.literal_eval(stackList)
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

# print(type(enabledKeys))
print(type(stackList2))
enabledStackLayers = list(set(stackList2).intersection(enabledKeys))

print(enabledStackLayers)
