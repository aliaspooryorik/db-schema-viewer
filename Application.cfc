component extends="lib.org.corfield.framework" {

	this.name = "db-schema-viewer-by-naming-convention";

	this.datasource = "db-schema-viewer";

	this.applicationroot = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/lib" ] = this.applicationroot & "lib/";
	this.mappings[ "/model" ] = this.applicationroot & "model/";

	
	// ------------------------ FW/1 SETTINGS ------------------------ //

	variables.framework = {
		reloadApplicationOnEveryRequest = true
	};

	void function setupApplication(){
		var beanFactory = new lib.org.corfield.ioc( "/model", {singletonPattern = "(Service|DAO)$"});
		setBeanFactory(beanFactory);
	}

}