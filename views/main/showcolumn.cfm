<cfoutput>
<h1>Viewing column: &lsquo;#rc.column#&rsquo;</h1>
<table>
	<thead>
		<tr>
			<th>Table</th>
			<th>Data Type</th>
			<th>Key Type</th>
		</tr>
	</thead>
	<tbody>
<cfloop condition="#rc.tableinfo.hasNext()#">
		<tr class="keytype_#rc.tableinfo.isprimarykey()#">
			<td>
				<a href="#buildUrl(action=".showtable",querystring="pk=#rc.tableinfo.getcolumnname()#")#">#rc.tableinfo.gettablename()#</a>
			</td>
			<td>#rc.tableinfo.getdatatype()#</td>
			<td>#rc.tableinfo.getkeytype()#</td>
		</tr>
</cfloop>
	</tbody>
</table>

<p>Note: If the column is a Primary Key in multiple tables it is part of a composite key</p>
</cfoutput>