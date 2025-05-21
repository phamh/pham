
<!---<cfheader name="Content-Disposition" value="inline; filename=test.xls"> 
<cfset a = spreadhsheetnew()> 
<cfset spreadsheetAddRow(a,"a,b,c")> 
<!---You can do all the processing---> 
<cfset bin = spreadsheetReadBinary(a)> 
<cfcontent type="application/vnd-ms.excel" variable="#bin#" reset="true">--->


<cfquery name="qSearchDupActivityDate"  datasource="#application.PhamDataSource#" >
	SELECT * 
	FROM activitylog_test.activitylogitem;   
</cfquery>
