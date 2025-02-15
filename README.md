# GTM Item Array Transformation

A Google Tag Manager (GTM) custom variable template designed to transform arrays of objects by remapping attribute keys. This template simplifies the process of structuring data for analytics, tagging, or other integrations.

## Features

- **Flexible Attribute Mapping**: Map old keys to new keys using a user-defined table.
- **Ecommerce Items Source Selection**: Choose between GA4's `ecommerce.items` array or a custom variable.
- **Efficient Data Handling**: Validates input arrays and ensures proper mapping.
- **Dynamic Transformations**: Handles complex transformations dynamically and reliably.
- **Data Formatting Options**: Convert attributes to numbers, integers, or strings.
- **Static Key-Value Assignments (Optional)**: Define static attributes with fixed values for all items.

## Use Cases

- Restructuring ecommerce data layers for custom tracking.
- Converting object keys to align with third-party integration requirements.
- Adapting data layers for use in multi-platform analytics.

## Template Configuration

### 1. Select Items Array Source

Users must first choose the **Ecommerce Items Array Source (Array of Objects)**:

| Option                            | Description                                                               |
| --------------------------------- | ------------------------------------------------------------------------- |
| **Use GA4 Ecommerce Items Array** | Automatically fetches the `ecommerce.items` array from the GA4 dataLayer. |
| **Use Custom Variable**           | Requires users to provide a variable containing the items array.          |

After selecting the source, proceed with attribute mapping and optional data formatting.

### 2. Attribute Key Mapping

| Field Name            | Description                           |
| --------------------- | ------------------------------------- |
| **Attribute Mapping** | A table mapping old keys to new keys. |

### 3. Data Formatting Options

Users can apply transformations to selected attributes:

- **Convert to Number**
- **Convert to Integer**
- **Convert to String**

### 4. Static Key-Value Assignments (Optional)

| Field Name            | Description                                     |
| --------------------- | ----------------------------------------------- |
| **Static Attributes** | A table mapping fixed attribute keys to values. |

## Transformation Example

### Example 1: Basic Attribute Mapping

#### Input Array

```json
[
  { "oldKey1": "value1", "oldKey2": "value2" },
  { "oldKey1": "value3", "oldKey2": "value4" }
]
```

#### Attribute Mapping Table

| Old Key | New Key |
| ------- | ------- |
| oldKey1 | newKey1 |
| oldKey2 | newKey2 |

#### Output

```json
[
  { "newKey1": "value1", "newKey2": "value2" },
  { "newKey1": "value3", "newKey2": "value4" }
]
```

### Example 2: Attribute Mapping with Static Key-Value Assignments

#### Static Key-Value Table

| Static Key | Static Value |
| ---------- | ------------ |
| fixedKey   | fixedValue   |

#### Output

```json
[
  { "newKey1": "value1", "newKey2": "value2", "fixedKey": "fixedValue" },
  { "newKey1": "value3", "newKey2": "value4", "fixedKey": "fixedValue" }
]
```

### Example 3: Data Formatting (Numbers & Strings)

#### Input Array

```json
[
  { "price": "10.99", "quantity": "5" }
]
```

#### Data Formatting Rules

| Attribute | Format  |
| --------- | ------- |
| price     | Number  |
| quantity  | Integer |

#### Output

```json
[
  { "price": 10.99, "quantity": 5 }
]
```

## Installation

1. Download the JSON file for the custom template from this repository.
2. Import it into your Google Tag Manager account.
3. Configure the fields as per your requirements.

## Author

Created by **Jude Nwachukwu Onyejekwe**.

This template is part of the [Dumbdata.co Measurement Resource Hub](https://dumbdata.co), which provides resources designed to simplify measurement strategies and implementations.

## License

This project is licensed under the Apache License.

