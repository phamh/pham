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

<cfif not isDefined('SESSION.email') OR #SESSION.email# EQ ''>
<cfelse>
	<cfquery name="getExistingItem" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT ctrl_panel_id, category_id, url, name, login_info, more_info, sort_id
		FROM portal
		WHERE ctrl_panel_id = '#url.editItem#'
	</cfquery>
</cfif>

<cfif isDefined('form.updateItem')>
	<cfif '#form.category_id#' EQ ''>
		<script type="text/javascript">
			alert('Category is required value');
		</script>
	<cfelse>	
	
		<cfquery name="saveItem" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#"> 
  	UPDATE portal	
    SET  	category_id = '#form.category_id#',
					url = '#form.url#',
					name = '#form.name#',
					login_info = '#form.login_info#',
					more_info = '#form.more_info#',
					sort_id = #form.sort_id#
		WHERE ctrl_panel_id = '#url.editItem#'
		</cfquery>
	</cfif>
	<cfset Session.editItem = 0> 
	<cflocation url="index.cfm">
</cfif>

<cfquery name="getCategory" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
	SELECT category_id, category, CONCAT(category, ' ', category_id) AS test
	FROM portal_category
	ORDER BY category
</cfquery>
	
<cfform>
<div id="bodyContent" align="center">
	<h3>Edit Item</h3>
	<table id="newItem">
		<tr>
			<th>Category: </th>
			<td>
				<cfselect name="category_id" 
					query="getCategory" 
					display="test" 
					value="category_id" 
					required="yes" message="Category is required value" selected="#getExistingItem.category_id#"
					queryPosition="below"><option value="">-select-</option>
				</cfselect>
			</td>
		</tr>

		<tr>
			<th>URL:</th>
			<td><cfinput name="url" type="text" size="60" maxlength="200" required="no" message="URL is required value" value="#getExistingItem.URL#"></td>
		</tr>

		<tr>
			<th>Sort ID:</th>
			<td><cfinput name="sort_id" type="text" size="5" required="yes" message="Sort ID is required value" value="#getExistingItem.sort_id#"></td>
		</tr>	
				
		<tr>
			<th>Description:</th>
			<td><cfinput name="name" type="text" size="60" maxlength="100" required="yes" message="Description is required value" value="#getExistingItem.name#"></td>
		</tr>	
		
		<tr>
			<th>Login Info:</th>
			<td><cfinput name="login_info" type="text" size="60" maxlength="100" required="no" message="Description is required value" value="#getExistingItem.login_info#"></td>
		</tr>	
		<tr valign="top">
			<th>More Info:</th>
			<td><cftextarea name="more_info" type="text" cols="50" rows="10" value="#getExistingItem.more_info#"></cftextarea>
			</td>
		</tr>	
														
		<tr>
			<th>&nbsp;</th>
			<td>
				<cfinput name="updateItem" type="submit" value="Save" class="button">
				<cfinput name="cancel" type="button" value="Cancel" class="button" onClick="location.href='index.cfm'">
			</td>
		</tr>							
	</table>	
</cfform>

</div>	
</body>
</html>
