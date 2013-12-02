component accessors="true" hint="I am the public facade for the Schema package"{

	// ------------------------ DEPENDANCIES ------------------------ //

	property name="SchemaDAO";

	// ------------------------ CONSTRUCTOR ------------------------ //

	SchemaService function init(){
		return this;
	}
	
	// ------------------------ PUBLIC ------------------------ //

	any function getTableNameFromPK(required primarykeycolumn){
		return variables.SchemaDAO.getTableName(primarykeycolumn=arguments.primarykeycolumn);
	}

	SchemaIterator function getTableDetails(required tablename){
		var rs = variables.SchemaDAO.getTableColumns(tablename=arguments.tablename);
		return new SchemaIterator(rs);
	}

	query function listTables(){
		return variables.SchemaDAO.listTables();
	}

	query function listLinkedTables(required tablename){
		return variables.SchemaDAO.listLinkedTables(arguments.tablename);
	}

	// ------------------------ PACKAGE ------------------------ //

	// ------------------------ PRIVATE ------------------------ //

}