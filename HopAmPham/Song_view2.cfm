
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfparam name="url.HopAmPhamID_pk" default="0">

<cfquery name="qGetThisSong" datasource="#application.PhamDataSource#">
    SELECT 		HopAmPhamID_pk, SongName, SongWriter, PoemWriter, SongTypeID_fk, SongCreatedDate, Tone, SongContent
    FROM		hopampham
   WHERE 	HopAmPhamID_pk = <cfqueryparam value="#url.HopAmPhamID_pk#" cfsqltype="cf_sql_integer">
</cfquery>

<table>
	<cfoutput query="qGetThisSong">
	<tr>
		<td><pre>#SongContent#</pre></td>
	</tr>
	</cfoutput>
</table>