<cfset request.layout = false>
<cfoutput>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Schema Viewer</title>
        <link href="assets/css/vendor/chosen.css" rel="stylesheet">
		<link href="assets/css/simplegrid.css" rel="stylesheet">
		<link href="assets/css/styles.css" rel="stylesheet">
	</head>
	<body>

		<div class="grid grid-pad">

			<header class="col-1-1 banner">
				<h1>MySQL Schema Viewer</h1>
	            <p>Works out a database schema by the column naming convention where no foreign keys are defined</p>
			</header>

			<div class="col-1-2 toolbar">
				<form action="#buildURL(".showtable")#" method="post">
					<label for="column">Table Name:</label>
					<select name="table">
					<cfloop query="rc.tables">
						<option>#rc.tables.tablename#</option>
					</cfloop>
					</select>
					<input type="submit" name="go" value="view">
				</form>
			</div>
			<div class="col-1-2 toolbar">
				<form action="#buildURL(".showcolumn")#" method="post">
					<label for="column">Column Name:</label>
					<input type="text" name="column" id="column">
					<input type="submit" name="search" value="search">
				</form>
			</div>

			<section class="col-1-1 content">
				#body#
			</section>

			<footer class="col-1-1 footer">
				Found a bug or have an improvement? <a href="https://github.com/aliaspooryorik/db-schema-viewer">Fork me on github</a>
			</footer>

		</div>

        <script src="assets/javascript/vendor/jquery-1.10.2.min.js"></script>
        <script src="assets/javascript/vendor/chosen.jquery.min.js"></script>
        <script>
        jQuery(function($){
            $('[name="table"]').chosen({search_contains:true});
        });
        </script>

	</body>
</html>
</cfoutput>