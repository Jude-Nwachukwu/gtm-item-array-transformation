# GTM Item Array Transformation

A Google Tag Manager (GTM) custom variable template designed to transform arrays of objects by remapping attribute keys. This template simplifies the process of structuring data for analytics, tagging, or other integrations.

## Features
- **Flexible Attribute Mapping**: Map old keys to new keys using a user-defined table.
- **Efficient Data Handling**: Validates input arrays and ensures proper mapping.
- **Dynamic Transformations**: Handles complex transformations dynamically and reliably.
- **Sandboxed Execution**: Fully compliant with GTM's sandboxed JavaScript environment.

## Use Cases
- Restructuring ecommerce data layers for custom tracking.
- Converting object keys to align with third-party integration requirements.
- Adapting data layers for use in multi-platform analytics.

## Template Fields
| Field Name              | Description                                     |
|-------------------------|-------------------------------------------------|
| **Input Array**         | The array of objects to be transformed.         |
| **Attribute Mapping**   | A table mapping old keys to new keys.           |

## Transformation Example

### Input
**Input Array**  
```json
[
  { "oldKey1": "value1", "oldKey2": "value2" },
  { "oldKey1": "value3", "oldKey2": "value4" }
]
```
# Attribute Mapping Table

| Old Key   | New Key   |
|-----------|-----------|
| oldKey1   | newKey1   |
| oldKey2   | newKey2   |

## Output
### Transformed Array
```json
[
  { "newKey1": "value1", "newKey2": "value2" },
  { "newKey1": "value3", "newKey2": "value4" }
]
```
## Installation
1. Download the JSON file for the custom template from this repository.
2. Import it into your Google Tag Manager account.
3. Configure the fields as per your requirements.

---
### Transform and Format Object Attributes in an Array  

This variable template allows users to transform attribute keys in an array of objects based on a mapping table while also applying optional data formatting.  

#### Features:  
- **Attribute Key Mapping:** Replaces specified attribute keys with new ones using a mapping table.  
- **Data Formatting Options:**  
  - Convert selected attributes to numbers.  
  - Convert selected attributes to integers.  
  - Convert selected attributes to strings.  
- **Flexible Configuration:** Users can enable or disable each formatting option and specify which attributes should be formatted.  

#### Behavior:  
- Processes an array of objects, applying key transformations and formatting where applicable.  
- If the input is invalid, returns `undefined`.

---
## Author

Created by **Jude Nwachukwu Onyejekwe**.

This template is part of the [Dumbdata.co Measurement Resource Hub](https://dumbdata.co), which provides resources designed to simplify measurement strategies and implementations.

---
## License
This project is licensed under the Apache License.
