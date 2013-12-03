db-schema-viewer
================

Works out a database schema by the column naming convention where no foreign keys are defined

## Usage

in `Application.cfc` set up your datasource and schema name in the config block:

```
  var Config = {
    DATASOURCE = "db-schema-viewer-dsn",
    SCHEMA = "myschema"
  };
```

## Libraries

This project makes use of other projects they are:

* FW/1https://github.com/framework-one/fw1/
* DI/1 https://github.com/framework-one/di1/
* Chosen http://harvesthq.github.io/chosen/
* Simple Grid http://thisisdallas.github.io/Simple-Grid/

