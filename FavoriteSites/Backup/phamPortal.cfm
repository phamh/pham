<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="pham.css">
<title>Pham Portal</title>

</head>

<body>

<cfquery name="queryGetCategory" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT category_id, category, active, orderID
		FROM portal_category
		WHERE active = 1
		ORDER BY orderID
</cfquery>

<style>
body
{
font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
font-size:12px;
}
table.alt.td{ background-color:gray}

button.smallerButton
{
	font-size:10px;
}

input.smallerText
{
	font-size:10px;
}

input.normalText
{
	font-size:12px;
}

</style>
<script>
	function changeMenuID(categoryID, id)
	{
		//ColdFusion.navigate('phamPortalContent.cfm?categoryID='+categoryID, 'phamLayoutArea');
		var tds = document.getElementsByTagName('td');
		for(i=0; i<=tds.length;i++)
		{
			if (document.getElementById('tdcurrentMenuID'+i) != null)
			{							
				document.getElementById('tdcurrentMenuID'+i).style.backgroundColor = '';
				document.getElementById('tdcurrentMenuID'+i).style.color = 'black';
			}		
		}
		
		document.getElementById('tdcurrentMenuID'+id).style.backgroundColor = 'navy';
		document.getElementById('tdcurrentMenuID'+id).style.color = 'white';
	}
	
	function login()
	{
		document.getElementById('loginDiv').style.display = 'block';
		document.getElementById('logoutButton').style.display = 'none';
		document.getElementById('loginButton').style.display = 'none';
	}

	function logout()
	{
		document.getElementById('loginDiv').style.display = 'none';
		document.getElementById('loginButton').style.display = 'block';
		document.getElementById('logoutButton').style.display = 'none';
	}
	
</script>
test
<cfset leftMenuWidth = 25>
<cfset rightMenuWidth = 99-leftMenuWidth>
<cfparam name="form.keywords" default="">

<cfif isDefined('form.submit')>
	<cflocation url="searchKeyWords.cfm?keywords=#form.keywords#">
</cfif>

<cfif isDefined('url.logout')>
	<cfscript>
		 StructClear(Session);
	</cfscript>
</cfif>

<p style="padding-left:10px;">
<cfform name="searchKeyword">
	<cfif not isDefined('SESSION.email') OR'#SESSION.email#' EQ ''>
		<a href="login.cfm">Log in</a>
	<cfelse>	
		<a href="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>?logout=y">Log out</a>	 | 
		<a href="new_portal_item.cfm">New Item</a>
	</cfif>&nbsp;&nbsp;
	Keywords: <cfinput name="keywords" type="text" size="30"/>
					<cfinput name="submit" type="submit" value="Submit"> (Seperate keywords by ";")
					
</p>
</cfform>
	
<cfset variables.counter = 0>
<div style="border:1px solid gray; height:402px; width:700px">
	<div style="float:left; border:0px dotted gray; height:400px; width:<cfoutput>#leftMenuWidth#</cfoutput>%; overflow-y: scroll; overflow-x:hidden">
		<table style="border-collapse:collapse" width="100%" border="1">
				<cfoutput query="queryGetCategory">
				<cfset variables.counter = variables.counter + 1>
				<cfset row_number = iif(CurrentRow MOD 2 EQ 0, "'lightgrey'", "'r2'")>
				<tr class="#row_number#" >	       
            <td id="tdcurrentMenuID#variables.counter#" style="background-color:white; cursor:pointer" onclick="javascript:ColdFusion.navigate('phamPortalContent.cfm?categoryID=#queryGetCategory.category_id#', 'photo_frame' );changeMenuID('#queryGetCategory.category_id#', '#variables.counter#')">
						#queryGetCategory.category#
					</td>   
				</tr>
				</cfoutput>
		</table>    
    </div>
    <div style="float:right; border:0px dotted gray; height:auto; width:<cfoutput>#rightMenuWidth#</cfoutput>%;">
			<cfdiv id="photo_frame" name="photo_frame" bind="url:phamPortalContent.cfm"/>

    </div>

</div><br />
<div>
	<cfquery name="getDocuments" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT * FROM document	
	</cfquery>

	<cfquery name="getYouTube" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT * FROM youtube	ORDER BY dateLink DESC
	</cfquery>
		
	<cfif cgi.SERVER_NAME EQ 'localhost'>
		<cfset variables.uploadDocDir = 'C:\ColdFusion11\cfusion\wwwroot\phamPortal\documents\'>
	<cfelse>
		<cfset variables.uploadDocDir = 'C:\Inetpub\vhosts\phamhomesite.com\phamportal\documents\'>
	</cfif>
	
	<cfif isDefined('url.deleteThisDocument')>

			<cffile action="delete" file="#variables.uploadDocDir##url.docName#">			
			<cfquery name="deleteDocument" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
				DELETE FROM document							
				WHERE 	id = #url.deleteThisDocument#
			</cfquery>


			<cflocation url="phamPortal.cfm">
			
	</cfif>

	<cfif isDefined('url.deleteThisLink')>
			<cfquery name="deleteLink" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
				DELETE FROM youtube							
				WHERE 	id = #url.deleteThisLink#
				
			</cfquery>
			<cflocation url="phamPortal.cfm">			
	</cfif>	
	<style>
		table.uploadDocument
		{
			border-collapse:collapse;
			border:1px solid gray;
		}
		
	</style>
	<cfif isDefined('SESSION.email')>
	<table>
		<tr valign="top">
			<td>

			<a href="uploadDocument.cfm">Upload Document</a>
			<table class="uploadDocument" border="1">
				<tr bgcolor="#999999">
					<th>Description</th>
					<th>Name</th>
					<th>Delete?</th>
				</tr>
				<cfoutput query="getDocuments">
					<tr>
						<td>#description#</td>
						<td><a href="documents/#docName#" target="_blank">#docName#</a></td>
						<td><a href="#cgi.SCRIPT_NAME#?deleteThisDocument=#id#&docName=#docName#"  onClick="return confirm('Are you sure you wish to delete this record?');">Delete</a></td>
					</tr>
				</cfoutput>
			</table>			
			</td>
			<td>			
				<a href="addLink.cfm">Add Song</a>
				<table class="uploadDocument" border="1">
					<tr bgcolor="#999999">
						<th>Title/Song</th>
						<th>Date</th>
						<th>Delete?</th>
						<th>Edit?</th>
					</tr>
					<cfoutput query="getYouTube">
						<tr>
							<td><a href="#url#" target="_blank" title="Click to listen #description#">#description#</a></td>
							<td>#DateFormat(dateLink, 'MMM/dd/yyyy')#</td>
							<td><a href="#cgi.SCRIPT_NAME#?deleteThisLink=#id#"  onClick="return confirm('Are you sure you wish to delete this link?');">Delete</a></td>
							<td><a href="editLink.cfm?editThisLink=#id#">Edit</a></td>
						</tr>
					</cfoutput>
				</table>			
			</td>
		</tr>
	</table>
	</cfif>


</div>
</body>
</html>