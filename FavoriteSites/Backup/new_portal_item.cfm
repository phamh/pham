<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PHAM Control Panel</title>
<link rel="stylesheet" type="text/css" href="pham.css">
</head>

<body>

<cfif not isDefined('SESSION.email') OR #SESSION.email# EQ ''>
	<cflocation url="login.cfm">	
</cfif>

<cfif isDefined('form.save')>
	<cfif '#form.category_id#' EQ ''>
		<script type="text/javascript">
			alert('Category is required value');
		</script>
	<cfelse>	
	
		<cfquery name="saveItem" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
			INSERT INTO portal(	
				category_id, url, name, login_info)
			VALUES (						
				'#form.category_id#','#form.url#','#form.name#', '#form.login_info#')
		</cfquery>
	</cfif>
</cfif>

<cfquery name="getCategory" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
	SELECT category_id, category, CONCAT(category, ' ', category_id) AS test
	FROM portal_category
	ORDER BY category
</cfquery>
	
<cfform>
<div id="bodyContent" align="center">
	<h3>New Item</h3>
	<table id="newItem">
		<tr>
			<th>Category: </th>
			<td>
				<cfselect name="category_id" 
					query="getCategory" 
					display="test" 
					value="category_id" 
					required="yes" message="Category is required value"
					queryPosition="below"><option value="">-select-</option>
				</cfselect>
			</td>
		</tr>
		
		<tr>
			<th>URL:</th>
			<td><cfinput name="url" type="text" size="60" maxlength="200" required="yes" message="URL is required value"></td>
		</tr>
		
		<tr>
			<th>Description:</th>
			<td><cfinput name="name" type="text" size="60" maxlength="100" required="yes" message="Description is required value"></td>
		</tr>	
		
		<tr>
			<th>Login Info:</th>
			<td><cfinput name="login_info" type="text" size="60" maxlength="100" required="no" message="Description is required value"></td>
		</tr>	
														
		<tr>
			<th>&nbsp;</th>
			<td>
				<cfinput name="save" type="submit" value="Save" class="button">
				<cfinput name="cancel" type="button" value="Cancel" class="button" onClick="location.href='index.cfm'">
			</td>
		</tr>							
	</table>	
</cfform>
<!---
<table>
	<cfoutput query="getCategory">
	<tr>
		<td>#CATEGORY#</td><td>#CATEGORY_ID#</td>
	</tr>
	</cfoutput>
</table>--->

	

</div>	
</body>
</html>
