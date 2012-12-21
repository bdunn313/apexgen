Custom Objects
==============

Object Metadata
---------------
- `<deploymentStatus>`
- `<enableActivities>`
- `<enableFeeds>`
- `<enableHistory>`
- `<enableReports>`
- `<label>`
- `<listViews>` **NOT NECESSARY**
- `<nameField>`
  - `<label>Dummy Object Name</label>`
  - `<trackHistory>false</trackHistory>`
  - `<type>Text</type>`
- `<pluralLabel>`
- `<sharingModule>ReadWrite</sharingModel>`

Field Metadata
--------------
- `<fullName>` **REQUIRED**
- `<description>`
- `<externalId>false</externalId>`
- `<required>`
- `<inlineHelpText>` **NOT NECESSARY**
- `<label>`
- `<trackHistory>`
- `<type>`

### AutoNumber
- `<displayFormat>AUTO-{0000}</displayFormat>`

### Checkbox
- `<defaultValue>`

### Currency
- `<precision>`
- `<scale>`

### DateTime

### Date

### Email
- `<unique>false</unique>`

### Geolocation (type = Location)
- `<displayLocationInDecimal>false</displayLocationInDecimal>`
- `<scale>`

### Lookup Relationship (type = Lookup)
- `<deleteConstraint>SetNull</deleteConstraint>`
- `<referenceTo>Object_Name__c</referenceTo>`
- `<relationshipLabel>`
- `<relationshipName>`

### Number
- `<precision>`
- `<scale>`
- `<unique>false</unique>`

### Percent
- `<precision>`
- `<scale>`

### Phone

### Picklist
- `<picklist>`
      <picklistValues>
          <fullName>Field 1</fullName>
          <default>false</default>
      </picklistValues>
      <sorted>false</sorted>

### Picklist Mulit (type = MultiselectPicklist)
- Include code from Picklist above
- `<visibleLines>4</visibleLines>`

### TextArea

### LongTextArea
- `<length>`
- `<visibleLines>3</visibleLines>`

### Rich Text Area (type = Html)
- `<length>`
- `<visibleLines>`

### EncryptedText
- `<length>`
- `<maskChar>asterisk</maskChar>`
- `<maskType>all</maskType>`

### Text
- `<length>`
- `<unique>`

### Url