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
  "displayName": "Advance Item Array Transformation",
  "description": "Transform an array of items by mapping existing attribute keys to new ones. This will return a new array where each item has transformed keys based on your specified mappings.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "itemsArraySource",
    "displayName": "Ecommerce Items Array Source (Array of Object)",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "useGa4Source",
        "displayValue": "Use GA4 Ecommerce Items Array"
      },
      {
        "value": "useCustomSource",
        "displayValue": "Use Custom Variable"
      }
    ],
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
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
    ],
    "enablingConditions": [
      {
        "paramName": "itemsArraySource",
        "paramValue": "useCustomSource",
        "type": "EQUALS"
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
    "newRowButtonText": "Add Mapping",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
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
  },
  {
    "type": "GROUP",
    "name": "advanceConfig",
    "displayName": "Advanced Configuration (Optional)",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "staticKeysValue",
        "displayName": "Configure Static Mapping",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Static Key",
            "name": "staticAttrKey",
            "type": "TEXT",
            "valueHint": "e.g., custom_key or original_attribute",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Corresponding Value",
            "name": "staticAttrValue",
            "type": "TEXT",
            "valueHint": "e.g., static value or {{gtm var}}",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "help": "Use this field only if you want to include static keys or additional keys from existing ones, with values that are either static or retrieved from another variable in the new mapping."
      }
    ],
    "help": "This is an advanced but optional configuration that you can include in the new mapping."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Object = require('Object');
const getType = require('getType');
const makeTableMap = require('makeTableMap');
const makeNumber = require('makeNumber');
const makeInteger = require('makeInteger');
const makeString = require('makeString');
const copyFromDataLayer = require('copyFromDataLayer');

// Determine the source of the items array
let inputArray;
if (data.itemsArraySource === 'useGa4Source') {
  inputArray = copyFromDataLayer('ecommerce.items');
} else {
  inputArray = data.inputArrayVar;
}

// Check if inputArray is a valid array
if (getType(inputArray) !== 'array') {
  return undefined;
}

// Convert the attribute mapping table into a Map using makeTableMap
const keyMapping = makeTableMap(data.attrArrayTransformation, 'exAttrKey', 'newAttrKey');

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

// Convert the static key-value table into a Map if it is configured
let staticKeyMapping = {};
if (getType(data.staticKeysValue) === 'array' && data.staticKeysValue.length > 0) {
  staticKeyMapping = makeTableMap(data.staticKeysValue, 'staticAttrKey', 'staticAttrValue');
}

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

  // Include static key-value mappings if configured
  if (staticKeyMapping) {
    Object.keys(staticKeyMapping).forEach(function (staticKey) {
      if (staticKeyMapping[staticKey] !== undefined) {
        transformedItem[staticKey] = staticKeyMapping[staticKey];
      }
    });
  }

  return transformedItem;
});

return transformedArray;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ecommerce.items"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2/15/2025, 8:02:40 AM


