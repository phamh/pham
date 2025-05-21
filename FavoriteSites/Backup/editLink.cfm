	<cfquery name="getLink" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
		SELECT * FROM youtube	WHERE ID = #url.editThisLink#
	</cfquery>
	
	<cfif isDefined('form.update')>
			<cfquery name="updateYouTube" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
				UPDATE youtube	
				SET  	description = '#form.linkDescription#',
							url = '#form.link#',
							dateLink = #now()#
				WHERE id = '#url.editThisLink#'						
			</cfquery>
			<cflocation url="phamPortal.cfm">
	</cfif>
	
	<cfform  name="upDateThisLink" method="post"  enctype="multipart/form-data">
		<table>
			<cfoutput query="getLink">
			<tr>
				<th>Title/Song: </th> <td><cfinput name="linkDescription" type="text" required="yes" message="Description is required" size="100" value="#description#"></td>
			</tr>
			<tr>
				<th>Link: </th><td><cfinput name="link" type="text" required="yes" message="Link is required" size="100" value="#url#"></td>

			</tr>
			</cfoutput>
			<tr>
				<th colspan="2">
					<cfinput name="update" type="submit" value="Submit">
					<cfinput name="cancel" type="button"  value="Cancel" onClick="history.go(-1)">
				</th>
			</tr>			
		</table>
		
	</cfform>
	