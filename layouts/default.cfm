<cfset request.layout = false>
<cfoutput>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Schema Viewer</title>
        <link href="assets/css/vendor/chosen.css" rel="stylesheet">
		<link href="assets/css/core.css" rel="stylesheet">
	</head>
	<body>

		<nav id="menu" role="navigation">
			<h1>Schema viewer</h1>
            <p>Works out a database schema by the column naming convention where no foreign keys are defined</p>
			<ul>
				<li><a class="navbar-brand" href="#buildUrl("")#">Table selector</a></li>
			</ul>
		</nav>
    	<hr>
		<section>
			#body#
		</section>
        
        
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