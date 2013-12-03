component accessors="true"{

	// ------------------------ DEPENDANCIES ------------------------ //

	property name="SchemaService";

	// ------------------------ CONSTRUCTOR ------------------------ //

	void function init(required any fw){
		variables.fw = arguments.fw;
	}

	// ------------------------ PUBLIC METHODS ------------------------ //

	void function default(required struct rc){

	}

	void function showcolumn(required struct rc){
		rc.tableinfo = variables.SchemaService.getTablesWithColumn(rc.column);
	}

	void function showtable(required struct rc){
		if(structkeyexists(rc,"pk")){
			rc.table = variables.SchemaService.getTableNameFromPK(rc.pk).tablename;
		}

		rc.tableinfo = variables.SchemaService.getTableDetails(rc.table);
		rc.linkedtables = variables.SchemaService.listLinkedTables(rc.table);
	}

}