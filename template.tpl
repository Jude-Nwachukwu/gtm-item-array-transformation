___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Item Array Transformation",
  "description": "Transform an array of items by mapping existing attribute keys to new ones. This will return a new array where each item has transformed keys based on your specified mappings.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "inputArrayVar",
    "displayName": "Items Array Variable",
    "simpleValueType": true,
    "help": "Enter the variable that contains the array of items you want to transform.",
    "valueHint": "Example: {{dlv - ecommerce.items}}"
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "attrArrayTransformation",
    "displayName": "Attribute Key Mapping",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Original Attribute Key",
        "name": "exAttrKey",
        "type": "TEXT"
      },
      {
        "defaultValue": "",
        "displayName": "New Attribute Key",
        "name": "newAttrKey",
        "type": "TEXT"
      }
    ],
    "help": "Map each existing attribute key in the item objects to a new attribute key.",
    "newRowButtonText": "Add Mapping"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Object = require('Object');
const getType = require('getType');
const makeTableMap = require('makeTableMap');

// Input array and mapping table
const inputArray = data.inputArrayVar;
const mappings = data.attrArrayTransformation;

// Check if inputArrayVar is a valid array
if (getType(inputArray) !== 'array') {
  return undefined;
}

// Convert the attribute mapping table into a Map using makeTableMap
const keyMapping = makeTableMap(mappings, 'exAttrKey', 'newAttrKey');

// If the mapping is invalid or could not be created, return undefined
if (!keyMapping) {
  return undefined;
}

// Transform the input array based on the mapping table
const transformedArray = inputArray.map(function (item) {
  const transformedItem = {};

  // Use Object.keys() to check if the original key exists in the item
  Object.keys(keyMapping).forEach(function (originalKey) {
    if (Object.keys(item).indexOf(originalKey) !== -1) {
      transformedItem[keyMapping[originalKey]] = item[originalKey];
    }
  });

  return transformedItem;
});

return transformedArray;


___TESTS___

scenarios: []


___NOTES___

Created on 1/28/2025, 11:03:50 AM


