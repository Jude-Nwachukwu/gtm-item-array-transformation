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
    "valueHint": "Example: {{dlv - ecommerce.items}}",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
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
  },
  {
    "type": "CHECKBOX",
    "name": "enableNumberFormat",
    "checkboxText": "Ensure specific keys are formatted as numbers.",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "enableIntegerFormat",
    "checkboxText": "Ensure specific keys are formatted as integers.",
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "enableStringFormat",
    "checkboxText": "Ensure specific keys are formatted as strings.",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "numberKeys",
    "displayName": "Keys to format as numbers (comma-separated)",
    "simpleValueType": true,
    "valueHint": "e.g., price, quantity",
    "help": "Enter the keys that should be formatted as numbers.",
    "enablingConditions": [
      {
        "paramName": "enableNumberFormat",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "integerKeys",
    "displayName": "Keys to format as integers (comma-separated)",
    "simpleValueType": true,
    "valueHint": "e.g., quantity, stock",
    "help": "Enter the keys that should be formatted as integers.",
    "enablingConditions": [
      {
        "paramName": "enableIntegerFormat",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "stringKeys",
    "displayName": "Keys to format as strings (comma-separated)",
    "simpleValueType": true,
    "valueHint": "e.g., category, brand",
    "help": "Enter the keys that should be formatted as strings.",
    "enablingConditions": [
      {
        "paramName": "enableStringFormat",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Object = require('Object');
const getType = require('getType');
const makeTableMap = require('makeTableMap');
const makeNumber = require('makeNumber');
const makeInteger = require('makeInteger');
const makeString = require('makeString');

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

// Check if formatting is enabled
const formatNumber = data.enableNumberFormat;
const formatInteger = data.enableIntegerFormat;
const formatString = data.enableStringFormat;

// Extract keys for each format type
const numberKeys = formatNumber ? (data.numberKeys ? data.numberKeys.split(',') : []) : [];
const integerKeys = formatInteger ? (data.integerKeys ? data.integerKeys.split(',') : []) : [];
const stringKeys = formatString ? (data.stringKeys ? data.stringKeys.split(',') : []) : [];

// Transform the input array based on the mapping table
const transformedArray = inputArray.map(function (item) {
  const transformedItem = {};

  // Use Object.keys() to check if the original key exists in the item
  Object.keys(keyMapping).forEach(function (originalKey) {
    if (Object.keys(item).indexOf(originalKey) !== -1) {
      let newValue = item[originalKey];
      let newKey = keyMapping[originalKey];
      
      // Apply formatting if enabled and key is in the respective list
      if (formatNumber && numberKeys.indexOf(originalKey) !== -1) {
        newValue = makeNumber(newValue);
      } else if (formatInteger && integerKeys.indexOf(originalKey) !== -1) {
        newValue = makeInteger(newValue);
      } else if (formatString && stringKeys.indexOf(originalKey) !== -1) {
        newValue = makeString(newValue);
      }
      
      transformedItem[newKey] = newValue;
    }
  });

  return transformedItem;
});

return transformedArray;


___TESTS___

scenarios: []


___NOTES___

Created on 1/29/2025, 12:22:34 PM


