
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfparam name="url.HopAmPhamID_pk" default="0">

<cfquery name="qGetThisSong" datasource="#application.PhamDataSource#">
    SELECT 	HopAmPhamID_pk, SongName, SongWriter, PoemWriter, SongTypeID_fk, SongCreatedDate, Tone, SongContent
    FROM	hopampham
   	WHERE 	HopAmPhamID_pk = <cfqueryparam value="#url.HopAmPhamID_pk#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif qGetThisSong.recordCount>
	<input type="button" value="Save" class="button" onclick="SaveThisSong(<cfoutput>#url.HopAmPhamID_pk#</cfoutput>)">
	<input type="button" value="Cancel Edit" onclick="ViewThisSong(<cfoutput>#url.HopAmPhamID_pk#</cfoutput>)"  class="button"></input>
	<table>
		<tr>
			<th><cfoutput>#qGetThisSong.SongName#</cfoutput></th>
		</tr>
		<cfoutput query="qGetThisSong">
		<tr>
			<td>
				<textarea cols="100" rows="50" id="songContent" name="songContent" required="true" placeholder="Required Value">#SongContent#</textarea>
			</td>
		</tr>
		</cfoutput>
	</table>
</cfif>