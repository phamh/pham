<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfset theFile=GetDirectoryFromPath(GetCurrentTemplatePath()) & "Reports\ActivityLog.xlsx">

<!---It will error out if we pass an empty string into function fGetThisAcomplishment --->
<cfif url.AccomplishmentMonthID_fk EQ ''>
	<cfset url.AccomplishmentMonthID_fk = 0>	
</cfif>
	
<cfinvoke component="ActivityLog" method="fGetThisAcomplishment" AccomplishmentMonthID_fk = "#url.AccomplishmentMonthID_fk#" returnvariable="qGetThisAcomplishment">
<cfspreadsheet action="write" fileName="#theFile#" query="qGetThisAcomplishment" overwrite=true sheetname = "HighLevelAccomlishment">

<!---Open the excel file Automatically --->
<cfheader name="content-disposition" value="attachment;filename=#theFile#">
<cfcontent type="application/msexcel"  file="#theFile#">


