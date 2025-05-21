<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<script>
	$("#CategoryID").on("change",function() {
	    //alert(this.value);
	});
</script>

<cfquery name="queryGetThisCategory" datasource="#application.PhamDataSource#">
	SELECT category_id, category, active, orderID
	FROM portal_category
	WHERE category_id = <cfqueryparam value="#url.Id_pk#" cfsqltype="cf_sql_integer">
</cfquery>

<div style="margin:20px;">
    <label for="CategoryID" style="font-weight:bold">Category: </label>
    <input style="width:200px" type="text" name="CategoryID" id="CategoryID" value="<cfoutput>#queryGetThisCategory.category#</cfoutput>">
</div>

