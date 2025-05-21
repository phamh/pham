<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PHAM Control Panel</title>
<link rel="stylesheet" type="text/css" href="pham.css">

</head>

<body>

<cfquery name="queryGetCategory" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT category_id, category, active, orderID
		FROM portal_category
		WHERE active = 1
		ORDER BY orderID
</cfquery>

<cfparam name="session.email" default="">
<cfparam name="session.password" default="">
<cfparam name="Session.editItem" default="">


<style type="text/css">
.x-tabs-strip tr {display:block}
.x-tabs-strip td {display:block; float:left}
.x-tabs-strip .on .x-tabs-inner {padding-bottom:4px}
</style>


<cfif isDefined("url.deleteItem")>
	<cfquery name="deleteItem" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
		DELETE FROM portal
		WHERE ctrl_panel_id = "#url.deleteItem#"
	</cfquery>
</cfif>

<cfif isDefined('url.editItem')>
	<cfset Session.editItem = '#url.editItem#'> 
	<cflocation url="edit_portal_item.cfm">
</cfif>

<cfif isDefined('url.logout')>
	<cfscript>
		 StructClear(Session);
	</cfscript>
</cfif>

<cfif isDefined('form.login')>
	<cfquery name="login" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT user_id, email, password
		FROM user
		WHERE email = '#form.email#' and password = '#form.password#'
	</cfquery>
	<cfif #login.recordCount# EQ 1>
		<cfset session.email = '#form.email#'>
		<cfset session.password = '#form.password#'>
	<cfelse>
		<font color="red">Invalid log in</font>
	</cfif>
</cfif>


<div id="bodyContent">
	<p style="padding-left:10px;">
		<cfif not isDefined('SESSION.email') OR'#SESSION.email#' EQ ''>
			<a href="login.cfm">Log in</a>
		<cfelse>	
			<a href="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?logout=y">Log out</a>	 | 
			<a href="new_portal_item.cfm">New Item</a>
		</cfif>
	</p>
	
<div style="font-family: arial; width: 700px; border: 0px solid gray; padding:5px">
<cflayout type="tab" name="myTabs" tabheight="500px">
	<cfloop index="i" from="1" to="#queryGetCategory.recordcount#">
		<cflayoutarea name="#queryGetCategory.category[i]#" title="#queryGetCategory.category[i]#" closable="false" style="padding-bottom:10px">
			<cfinvoke component="pham" method="getPortal" portal_id_in = "#queryGetCategory.category_id[i]#" returnvariable="queryGetPortal">
			<div style="margin:5px">
			<table id="listItem">
				<tr>
					<th colspan="3"><cfoutput>#queryGetCategory.category[i]#</cfoutput></th>
				</tr>
				<!--- Invoke method to retrieve Marshall Star--->
				<cfoutput query="queryGetPortal">
				<cfset row_number = iif(CurrentRow MOD 2 EQ 0, "'r3'", "'r2'")>
				<tr class="#row_number#">						
					<td>
						<a href="#url#" target="_blank">#name#</a>
						<cfif #more_info# NEQ ""><b>?</b></cfif>
					</td>
					<cfif not isDefined('SESSION.email') OR'#SESSION.email#' EQ ''>		
					<cfelse>
						<td>#login_info#</td>
						<td>
							<a href="#cgi.SCRIPT_NAME#?deleteItem=#ctrl_panel_id#" onClick="return confirm('Are you sure you wish to delete this record?');">[Del]</a>&nbsp;
							<a href="#cgi.SCRIPT_NAME#?editItem=#ctrl_panel_id#">[Edit]</a>						
						</td>
					</cfif>	
		
				</tr>
				</cfoutput>
			</table>	
			</div>
		</cflayoutarea>
	</cfloop>

</cflayout>
</div>
</div>
</body>
</html>
