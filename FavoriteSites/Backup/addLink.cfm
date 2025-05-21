	<cfif isDefined('form.load')>
			<cfquery name="insertDocument" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
					INSERT INTO youtube(description, url, dateLink)
					VALUES ('#form.linkDescription#', '#form.link#', #now()#)
			</cfquery>
			<cflocation url="phamPortal.cfm">
	</cfif>
	
	<cfform  name="updateAdvertiserForm" method="post"  enctype="multipart/form-data">
		<table>
			<tr>
				<th>Title/Song: </th> <td><cfinput name="linkDescription" type="text" required="yes" message="Description is required" size="100"></td>
			</tr>
			<tr>
				<th>Link: </th><td><cfinput name="link" type="text" required="yes" message="Link is required" size="100"></td>

			</tr>
			<tr>
				<th colspan="2">
					<cfinput name="load" type="submit" value="Submit">
					<cfinput name="cancel" type="button"  value="Cancel" onClick="history.go(-1)">
				</th>
			</tr>			
		</table>
		
	</cfform>
	