<cfcomponent output="false" hint="I interact with the database">

	<!--- // ------------------------ DEPENDANCIES ------------------------ // --->
	
	<!--- // ------------------------ CONSTANTS ------------------------ // --->

	<cfset this.SCHEMA = "wld">
	<cfset this.PRIMARY_KEY_TYPE = "PRI">
	
	<!--- // ------------------------ CONSTRUCTOR ------------------------ // --->
	<cffunction name="init" returntype="SchemaDAO" output="false" hint="pseudo constructor">
		<cfreturn this>
	</cffunction>
	
	<!--- // ------------------------ PUBLIC ------------------------ // --->
		
	<!--- // ------------------------ PACKAGE ------------------------ // --->
	
	<cffunction name="getTableColumns" returntype="query" access="package" output="false" hint="returns a list of tables as a query">
		<cfargument name="tablename" required="true" type="string">
		<cfargument name="primarykey" required="false" default="false" type="boolean" hint="return just the primary key">
		<cfset local.q = "">
			
		<cfquery name="local.q">
			select table_schema as tableschema, 
				table_name as tablename, 
				column_key as columnkey, 
				column_name as columnname, 
				data_type as datatype, 
				case when column_key = '#this.PRIMARY_KEY_TYPE#' then 1 else 0 end as isprimarykey
			from information_schema.columns
			where table_name = <cfqueryparam value="#arguments.tablename#" cfsqltype="cf_sql_varchar">
				and table_schema = <cfqueryparam value="#this.SCHEMA#" cfsqltype="cf_sql_varchar">
			<cfif arguments.primarykey>
				and column_key = <cfqueryparam value="#this.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
			</cfif>
			order by isprimarykey desc, table_name
		</cfquery>

		<cfreturn local.q>
	</cffunction>
			
	<cffunction name="getTableName" returntype="query" access="package" output="false" hint="returns a list of tables as a query">
		<cfargument name="primarykeycolumn" required="false" default="false" type="string" hint="return just the primary key">
		<cfset local.q = "">
			
		<cfquery name="local.q">
			select table_schema as tableschema, 
				table_name as tablename, 
				column_key as columnkey, 
				column_name as columnname, 
				data_type as datatype
			from information_schema.columns
			where column_name = <cfqueryparam value="#arguments.primarykeycolumn#" cfsqltype="cf_sql_varchar">
				and table_schema = <cfqueryparam value="#this.SCHEMA#" cfsqltype="cf_sql_varchar">
				and column_key = <cfqueryparam value="#this.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
		</cfquery>

		<cfreturn local.q>
	</cffunction>
		
	<cffunction name="listTables" returntype="query" access="package" output="false" hint="returns a list of tables as a query">
		<cfset local.q = "">
			
		<cfquery name="local.q" cachedwithin="#CreateTimeSpan(0,0,15,0)#">
			select table_name as tablename
				, engine 
				, table_rows as tablerows
				, table_collation as tablecollation
				, table_comment as tablecomment
			from information_schema.tables
			where table_schema = <cfqueryparam value="#this.SCHEMA#" cfsqltype="cf_sql_varchar">
			order by table_name
		</cfquery>

		<cfreturn local.q>
	</cffunction>
	
	<cffunction name="listLinkedTables" returntype="query" access="package" output="false" hint="returns a list of tables as a query">
		<cfargument name="tablename" required="true">
		<cfset local.q = "">

		<cfquery name="local.q">
			select table_schema as tableschema
				, table_name as tablename
				, column_key as columnkey
			from information_schema.columns
			where table_schema = <cfqueryparam value="#this.SCHEMA#" cfsqltype="cf_sql_varchar">
				and column_key <> <cfqueryparam value="#this.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
				and column_name = (
					select column_name
					from information_schema.columns
					where table_name = <cfqueryparam value="#arguments.tablename#" cfsqltype="cf_sql_varchar">
					and column_key = <cfqueryparam value="#this.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
				)
			order by table_name
		</cfquery>

		<cfreturn local.q>
	</cffunction>
			
	<!--- // ------------------------ PRIVATE ------------------------ // --->
</cfcomponent>
