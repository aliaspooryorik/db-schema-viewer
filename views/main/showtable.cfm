<cfoutput>
<h1>Viewing table: &lsquo;#rc.table#&rsquo;</h1>

<table>
	<thead>
		<tr>
			<th>Column</th>
			<th>Data Type</th>
			<th>Primary Key</th>
			<th>Foreign Key</th>
		</tr>
	</thead>
	<tbody>
<cfloop condition="#rc.tableinfo.hasNext()#">
		<tr class="keytype_#rc.tableinfo.isprimarykey()#">
			<td>
				<cfif rc.tableinfo.isforeignkey()>
					<a href="#buildUrl(action=".showtable",querystring="pk=#rc.tableinfo.getcolumnname()#")#">#rc.tableinfo.getcolumnname()#</a>
				<cfelse>
					#rc.tableinfo.getcolumnname()#
				</cfif>
			</td>
			<td>#rc.tableinfo.getdatatype()#</td>
			<td>#YesNoFormat(rc.tableinfo.isprimarykey())#</td>
			<td>#YesNoFormat(rc.tableinfo.isforeignkey())#</td>
		</tr>
</cfloop>
	</tbody>
</table>


<h1>Table(s) that reference &lsquo;#rc.table#&rsquo;</h1>

<cfif !rc.linkedtables.recordcount>
	<p>No tables reference &lsquo;#rc.table#&rsquo;</p>

<cfelse>
	<p>#rc.linkedtables.recordcount# tables reference &lsquo;#rc.table#&rsquo;</p>


<table>
	<thead>
		<tr>
			<th>Table</th>
		</tr>
	</thead>
	<tbody>
<cfloop query="rc.linkedtables">
		<tr>
			<td><a href="#buildUrl(action=".showtable",querystring="table=#rc.linkedtables.tablename#")#">#rc.linkedtables.tablename#</a></td>
		</tr>
</cfloop>
	</tbody>
</table>

</cfif>

</cfoutput>