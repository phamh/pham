<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfswitch expression="#url.Id_pk#" >
	<cfcase value="0" >
		<cfinclude template="CategoryNew.cfm" >
	</cfcase>
	<cfdefaultcase>
		<cfinclude template="CategoryEdit.cfm" >
	</cfdefaultcase>
</cfswitch>