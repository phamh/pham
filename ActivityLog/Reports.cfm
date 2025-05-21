<!---<cfinclude template="Header.cfm" >--->
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<style >
    span.label {
    font-weight: bold;
    color: purple;
    font-size:12px;
    }
</style>
<cfquery name="getMonthlyActivity_X"  datasource="#application.PhamDataSource#" >
    SELECT 	DISTINCT PeriodEnding
    FROM	activitylog
    <!---WHERE 	ActivityDate = <cfqueryparam value="#NewActivityDate#" cfsqltype="cf_sql_date">  --->             
</cfquery>

<script>

	RunMonthlyReport=function()
	{
 		var StartPeriodEnding = $('#StartPeriodEnding').val();
		var EndPeriodEnding = $('#EndPeriodEnding').val();
		var TaskOrderId_fk = $('#SelectedTaskOrderNumber').val();
		ColdFusion.navigate('ActivityLog/MonthlyReport.cfm?StartPeriodEnding='+StartPeriodEnding+'&EndPeriodEnding='+EndPeriodEnding+'&TaskOrderId_fk='+TaskOrderId_fk, 'MonthlyReportContain');
		//$("#ActivityLogItem").load(location.href + " #ActivityLogItem");
	}
</script>	    
<cfinvoke component="ActivityLog" method="getTaskOrderNumber"  returnvariable="qGetTaskOrderNumber">
<cfinvoke component="ActivityLog" method="GetPeriodEnding"  returnvariable="qGetPeriodEnding">

<div style="width: 100%; padding:10px;border: 0px dotted gray;">
	<span class="label">Start Period Ending:</span>
	<select id="StartPeriodEnding">
		<!---<option value="0">Select your option</option>--->
		<cfoutput query="qGetPeriodEnding">
			<option value="#PeriodEnding#">#DateFormat(PeriodEnding,'long')#</option>
		</cfoutput>
	</select>

	&nbsp;&nbsp;<span class="label">End Period Ending:</span>
	<select id="EndPeriodEnding">
		<!---<option value="0">Select your option</option>--->
		<cfoutput query="qGetPeriodEnding">
			<option value="#PeriodEnding#">#DateFormat(PeriodEnding,'long')#</option>
		</cfoutput>
	</select>

	&nbsp;&nbsp;<span class="label">Select Task Number:</span>
	<select id="SelectedTaskOrderNumber">
		<option value="0">All</option>
		<cfoutput query="qGetTaskOrderNumber">
			<option value="#TASKORDERID_PK#">
				#TaskOrderNumber# - #TASKORDERDESCRIPTION#
			</option>
		</cfoutput>
	</select>	
    <input onclick="RunMonthlyReport();"class="button" value="  Run Report  " type="button"></input>
    <input onclick="RunMonthlyReport();"class="button" value="  Run 1248-B Weekly Report  " type="button"></input>		
<!---    <input onclick="window.location.href='MonthlyReport_excel.cfm';"class="button" id="ExportExcelButton" value="Export To Excel" type="button"></input>--->
</div>

<div id="MonthlyReport">
	<cfdiv id="MonthlyReportContain" name="MonthlyReportContain" bind="url:ActivityLog/MonthlyReport.cfm"/>
</div>

<!---<cfinclude template="Footer.cfm" >--->