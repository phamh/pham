<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
	<cfif cgi.SERVER_NAME EQ 'localhost'>
		<cfset variables.uploadDocDir = 'C:\ColdFusion11\cfusion\wwwroot\phamPortal\documents\'>
	<cfelse>
		<cfset variables.uploadDocDir = 'C:\Inetpub\vhosts\phamhomesite.com\phamportal\documents\'>
	</cfif>	

	<cfif isDefined('form.load')>
		<cfif form.loadDocument EQ ''>
			<script>
				alert('test');
			</script>
		<cfelse>
			<cffile action="upload" destination="#variables.uploadDocDir#" filefield="form.loadDocument" nameconflict="makeunique">
			<cfquery name="insertDocument" datasource="#REQUEST.dataSource#">
					INSERT INTO document(description, docName)
					VALUES ('#form.docDescription#', '#cffile.serverFile#')
			</cfquery>
			<cflocation url="phamPortal.cfm">
		</cfif>
	</cfif>
	
	<cfform  name="updateAdvertiserForm" method="post" enctype="multipart/form-data">
	
		<table>
			<tr>
				<th>Description: </th> <td><cfinput name="docDescription" type="text" required="yes" message="Description is required"></td>
			</tr>
			<tr>
				<th>Name: </th><td><cfinput name="loadDocument" type="file" required="yes" message="File is required"></td>

			</tr>
			<tr>
				<th colspan="2">
					<cfinput name="load" type="submit" value="Submit">
					<cfinput name="cancel" type="button"  value="Cancel" onClick="history.go(-1)">
				</th>
			</tr>			
		</table>
		
	</cfform>
	
</body>
</html>