db-schema-viewer
================

Works out a database schema by the column naming convention where no foreign keys are defined

## Usage

in `Application.cfc` set up your datasource and schema name in the config block:

  var Config = {
    DATASOURCE = "db-schema-viewer-dsn",
    SCHEMA = "myschema"
  };

