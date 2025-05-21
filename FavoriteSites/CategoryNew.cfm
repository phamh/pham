<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<div style="margin:20px;">
    <label for="CategoryID" style="font-weight:bold">Category: </label>
    <input style="width:200px" type="text" name="CategoryID" id="CategoryID">
</div>
