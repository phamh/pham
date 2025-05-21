<!DOCTYPE html>
<html>
<head>
       <link href="../assets/styles.min.css" rel="stylesheet">
       <title>jQuery UI Autocomplete: Using Label-Value Pairs</title>
       <link href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/start/jquery-ui.min.css" rel="stylesheet">
       <script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
       <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
</head>

<body>

	<cfquery name="qGetRoles" datasource="#application.PhamDataSource#">
	  SELECT	rolename as label,rolenameid_fk
	  FROM		Roles
	</cfquery>
	<cfdump var="#qGetRoles#">
	<cfset temp = serializeJSON(qGetRoles, "struct")>


</script>
	<input id="ROLENAME" type="text" placeholder="U.S. state name">
	<input id="ROLENAMEID" type="text"></p>
   	<script>
		<cfoutput>
			var #toScript(deserializeJson(temp), "dynamicData2")#;
		</cfoutput>
		try {alert(dynamicData2)
		    $(function () {
		        $("#ROLENAME").autocomplete({
		            source: dynamicData2,
		            focus: function (event, ui) {
		                // prevent autocomplete from updating the textbox
		                event.preventDefault();
		                // manually update the textbox
		                $(this).val(ui.item.label);
		            },

		            select: function (event, ui) {
		                // prevent autocomplete from updating the textbox
		                event.preventDefault();
		                // manually update the textbox and hidden field
		                //$(this).val(ui.item.label);
		                $("#ROLENAMEID").val(ui.item.rolenameid_fk);
		            },
		        });
		    });
		} catch (e) {
		    alert(e.message);
		}
   	</script>
</body>
</html>










