component extends="lib.org.corfield.framework" {

	this.name = "db-schema-viewer-by-naming-convention";

	this.applicationroot = getDirectoryFromPath(getCurrentTemplatePath());
	this.mappings[ "/lib" ] = this.applicationroot & "lib/";
	this.mappings[ "/model" ] = this.applicationroot & "model/";


	// ------------------------ FW/1 SETTINGS ------------------------ //

	variables.framework = {
		reloadApplicationOnEveryRequest = true
	};

	void function setupApplication(){
		var beanFactory = new lib.org.corfield.ioc("/model", {singletonPattern = "(Service|DAO)$"});
		var Config = {
			DATASOURCE = "your-datasource",
			SCHEMA = "your-schema"
		};
		beanFactory.addBean("config", Config);
		setBeanFactory(beanFactory);
	}

	void function setupView(){
		// stuff needed to build the layout
		rc.tables = getBeanFactory().getBean("SchemaService").listTables();
	}

}