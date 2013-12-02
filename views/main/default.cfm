<cfoutput>
<h1>Table Selector</h1>

<form action="#buildURL(".showtable")#" method="post">
	<select name="table">
	<cfloop query="rc.tables">
		<option>#rc.tables.tablename#</option>
	</cfloop>
	</select>
	<input type="submit" name="go" value="go">
</form>

</cfoutput>
