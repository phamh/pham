<cfif application.dumpSrcFilenames OR 1 EQ 1>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfdump var="#getDirectoryFromPath(getCurrentTemplatePath())#">
<cfdirectory directory="#getDirectoryFromPath(getCurrentTemplatePath())#" name="DirFiles" action="list" recurse="true" filter="*.cfm|*.cfc" type="file" >
<cfdump var="#DirFiles#">