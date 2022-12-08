import json;
import sys
import os;
import ast;

stackList = os.getenv('stackList');
stackList = ast.literal_eval(stackList)

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

enabledStackLayers = list(set(stackList).intersection(enabledKeys))

print(enabledStackLayers)
