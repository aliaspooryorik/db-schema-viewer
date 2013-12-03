<cfcomponent output="false" accessors="true" hint="I interact with the database">

	<!--- // ------------------------ DEPENDANCIES ------------------------ // --->
	<cfproperty name="config" setter="true" getter="false">

	<!--- // ------------------------ CONSTANTS ------------------------ // --->
	<cfset variables.PRIMARY_KEY_TYPE = "PRI">


	<!--- // ------------------------ CONSTRUCTOR ------------------------ // --->
	<cffunction name="init" returntype="SchemaDAO" output="false" hint="pseudo constructor">
		<cfreturn this>
	</cffunction>

	<!--- // ------------------------ PUBLIC ------------------------ // --->

	<!--- // ------------------------ PACKAGE ------------------------ // --->

	<cffunction name="getTableColumns" returntype="query" access="package" output="false" hint="returns a list of columns for the given table">
		<cfargument name="tablename" required="true" type="string">
		<cfargument name="primarykey" required="false" default="false" type="boolean" hint="return just the primary key">
		<cfset local.q = "">

		<cfquery name="local.q" datasource="#variables.config.DATASOURCE#">
			select
				isc.table_schema as tableschema,
				isc.table_name as tablename,
				isc.column_key as columnkey,
				isc.column_name as columnname,
				isc.column_type as datatype,
				case when isc.column_key = '#variables.PRIMARY_KEY_TYPE#' then 1 else 0 end as isprimarykey
			from information_schema.columns as isc
			where table_name = <cfqueryparam value="#arguments.tablename#" cfsqltype="cf_sql_varchar">
				and table_schema = <cfqueryparam value="#variables.config.SCHEMA#" cfsqltype="cf_sql_varchar">
			<cfif arguments.primarykey>
				and column_key = <cfqueryparam value="#variables.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
			</cfif>
			order by isprimarykey desc
		</cfquery>

		<cfreturn local.q>
	</cffunction>

	<cffunction name="getTableNameFromPK" returntype="query" access="package" output="false" hint="returns the table name for the given primary key">
		<cfargument name="primarykeycolumn" required="true" type="string" hint="column name of the primary key">

		<cfreturn getTablesWithColumn(arguments.primarykeycolumn, true)>
	</cffunction>

	<cffunction name="getTablesWithColumn" returntype="query" access="package" output="false" hint="returns the table name for the given primary key">
		<cfargument name="column" required="true" type="string" hint="column name">
        <cfargument name="isprimarykey" required="false" default="false" type="boolean" hint="return just the primary key">

		<cfset local.q = "">

		<cfquery name="local.q" datasource="#variables.config.DATASOURCE#">
			select
				isc.table_schema as tableschema,
				isc.table_name as tablename,
				isc.column_key as columnkey,
				isc.column_name as columnname,
				isc.column_type as datatype,
                case when column_key = '#variables.PRIMARY_KEY_TYPE#' then 1 else 0 end as isprimarykey,
				case when dt.pkcount > 1 then 1 else 0 end as iscompoundkey
			from information_schema.columns as isc
				inner join (
					select
						table_name,
						count(*) as pkcount
					from information_schema.columns
					where column_key = <cfqueryparam value="#variables.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
					group by table_name
				) as dt on dt.table_name = isc.table_name
			where column_name = <cfqueryparam value="#arguments.column#" cfsqltype="cf_sql_varchar">
				and table_schema = <cfqueryparam value="#variables.config.SCHEMA#" cfsqltype="cf_sql_varchar">
            <cfif arguments.isprimarykey>
				and column_key = <cfqueryparam value="#variables.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
            </cfif>
            order by isprimarykey desc, iscompoundkey, tablename
		</cfquery>

		<cfreturn local.q>
	</cffunction>

	<cffunction name="listTables" returntype="query" access="package" output="false" hint="returns a list of tables as a query">
		<cfset local.q = "">

		<cfquery name="local.q"  datasource="#variables.config.DATASOURCE#" cachedwithin="#CreateTimeSpan(0,0,15,0)#">
			select table_name as tablename
				, engine
				, table_rows as tablerows
				, table_collation as tablecollation
				, table_comment as tablecomment
			from information_schema.tables
			where table_schema = <cfqueryparam value="#variables.config.SCHEMA#" cfsqltype="cf_sql_varchar">
			order by table_name
		</cfquery>

		<cfreturn local.q>
	</cffunction>

	<cffunction name="listLinkedTables" returntype="query" access="package" output="false" hint="returns a list of tables as a query">
		<cfargument name="tablename" required="true">
		<cfset local.q = "">

		<cfquery name="local.q" datasource="#variables.config.DATASOURCE#">
			select table_schema as tableschema
				, table_name as tablename
				, column_key as columnkey
			from information_schema.columns
			where table_schema = <cfqueryparam value="#variables.config.SCHEMA#" cfsqltype="cf_sql_varchar">
				and column_key <> <cfqueryparam value="#variables.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
				and column_name IN (
					select column_name
					from information_schema.columns
					where table_name = <cfqueryparam value="#arguments.tablename#" cfsqltype="cf_sql_varchar">
						and column_key = <cfqueryparam value="#variables.PRIMARY_KEY_TYPE#" cfsqltype="cf_sql_varchar">
				)
			order by table_name
		</cfquery>

		<cfreturn local.q>
	</cffunction>

	<!--- // ------------------------ PRIVATE ------------------------ // --->
</cfcomponent>
