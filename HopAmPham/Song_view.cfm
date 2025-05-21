
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfparam name="url.HopAmPhamID_pk" default="0">

<cfquery name="qGetThisSong" datasource="#application.PhamDataSource#">
    SELECT 	HopAmPhamID_pk, SongName, SongWriter, PoemWriter, SongTypeID_fk, SongCreatedDate, MainTone, SongContent,SongTypeDescription,songLink
    FROM	hopampham, SongType
   	WHERE 	HopAmPhamID_pk = <cfqueryparam value="#url.HopAmPhamID_pk#" cfsqltype="cf_sql_integer"> AND
   			SongTypeID_fk = SongTypeID_pk
</cfquery>

<cfif qGetThisSong.recordCount>
	<input type="button" value="Delete This Song" class="DeleteButton" onclick="DeleteThisSong(<cfoutput>#url.HopAmPhamID_pk#</cfoutput>)">
	<input type="button" value="Edit This Song" class="button" onclick="EditThisSong(<cfoutput>#url.HopAmPhamID_pk#</cfoutput>)">
	<table style="margin-top:5px">
		<cfoutput query="qGetThisSong">
		<tr>
			<th colspan="9">
				<span style="font-weight:bold; font-size:16px">#qGetThisSong.SongName#</span><br>
				Sáng tác: #qGetThisSong.SongWriter# | Thể loại: #SongTypeDescription# | MainTone: #MainTone#
				<br>
			</th>
		</tr>
		<th colspan="9">
			<td>&nbsp;</td>
		</tr>
		<tr style="height:20px;">
			<td style="border: 1px solid gray; text-align:center; width:30px" title="Giam Tone">b</td>
			<td style="border: 1px solid gray; text-align:center; width:30px; color:red">[#MainTone#]</td>
			<td style="border: 1px solid gray; text-align:center; width:30px" title="Tang Tone">##</td>
			<td style="border: 1px solid gray; text-align:center; width:30px">&nbsp;</td>
			<td style="border: 1px solid gray; text-align:center; width:30px">&nbsp;</td>
			<td style="border: 1px solid gray; text-align:center; width:30px">&nbsp;</td>
			<td style="border: 1px solid gray; text-align:center; width:30px">&nbsp;</td>
			<td style="border: 1px solid gray; text-align:center; width:30px">&nbsp;</td>
			<td style="border: 1px solid gray; text-align:center; width:30px">&nbsp;</td>
		</tr>
		<th colspan="9">
			<td>&nbsp;</td>
		</tr>
		<tr>
			<cfset session.changeToneDirection = 'down'>
			<cfset tempString = SongContent>
			<cfoutput>

				<cfset tempString = replace(tempString,'C##]', 'xxCxx]','All')>
				<cfset tempString = replace(tempString,'D##]', 'xxEbxx]','All')>
				<cfset tempString = replace(tempString,'F##]', 'xxFxx]','All')>
				<cfset tempString = replace(tempString,'E##]', 'xxExx]','All')>
				<cfset tempString = replace(tempString,'F##]', 'xxFxx]','All')>
				<cfset tempString = replace(tempString,'G##]', 'xxGxx]','All')>
				<cfset tempString = replace(tempString,'A##]', 'xxAxx]','All')>
				<cfset tempString = replace(tempString,'B##]', 'xxBxx]','All')>

				<cfset tempString = replace(tempString,'C##m]', 'xxCmxx]','All')>
				<cfset tempString = replace(tempString,'D##m]', 'xxEbmxx]','All')>
				<cfset tempString = replace(tempString,'F##m]', 'xxFmxx]','All')>
				<cfset tempString = replace(tempString,'E##m]', 'xxEmxx]','All')>
				<cfset tempString = replace(tempString,'F##m]', 'xxFmxx]','All')>
				<cfset tempString = replace(tempString,'G##m]', 'xxGmxx]','All')>
				<cfset tempString = replace(tempString,'A##m]', 'xxAmxx]','All')>
				<cfset tempString = replace(tempString,'B##m]', 'xxBmxx]','All')>


				<cfset tempString = replace(tempString,'Cbm]', 'xxBm]xx','All')>
				<cfset tempString = replace(tempString,'Dbm]', 'xxCm]xx','All')>
				<cfset tempString = replace(tempString,'Ebm]', 'xxDm]xx','All')>
				<cfset tempString = replace(tempString,'Fbm]', 'xxEbm]xx','All')>
				<cfset tempString = replace(tempString,'Gbm]', 'xxFm]xx','All')>
				<cfset tempString = replace(tempString,'Abm]', 'xxGm]xx','All')>
				<cfset tempString = replace(tempString,'Bbm]', 'xxAm]xx','All')>

				<cfset tempString = replace(tempString,'[C', '[xxBxx','All')>
				<cfset tempString = replace(tempString,'[D', '[xxC***','All')>
				<cfset tempString = replace(tempString,'[E', '[xxEbxx','All')>
				<cfset tempString = replace(tempString,'[F', '[xxExx','All')>
				<cfset tempString = replace(tempString,'[G', '[xxF***','All')>
				<cfset tempString = replace(tempString,'[A', '[xxAbxx','All')>
				<cfset tempString = replace(tempString,'[B', '[xxBbxx','All')>

				<cfset tempString = replace(tempString,'xx', '','All')>
				<cfset tempString = replace(tempString,'***', '##','All')>
			</cfoutput>
			<td colspan="5" style="font-weight:normal; font-size:16px; font:Arial"><pre>#SongContent#</pre></td>
			<td colspan="4" style="font-weight:normal; font-size:16px; font:Arial; color:green"><pre>#tempString#</pre></td>
		</tr>
		<th colspan="9">
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="9">
			<cfset startPosition = Find('=',songLink) + 1>
			<cfset endPosition = len(songLink)>
			<cfset tempString = Mid(songLink,startPosition,endPosition)>
			<iframe height="200" width="300" src="https://www.youtube.com/embed/#tempString#"></iframe>
			</td>
		</tr>
		</cfoutput>
	</table>
</cfif>
