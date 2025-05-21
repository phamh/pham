<cfinclude template="../CheckAccess.cfm" >

<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfajaxproxy cfc="ActivityLog" jsclassname="ActivityLogCFC">
<cfparam name="url.PeriodEnding" default="0">
<cfif url.PeriodEnding EQ 0>
	<cfquery name="gGetLastPeriodEnding" datasource="#application.PhamDataSource#">
		SELECT 	PeriodEnding
		FROM	ActivityLog
		ORDER BY ActivityDate DESC
		LIMIT 1
	</cfquery>
	<cfset url.PeriodEnding  = dateFormat(gGetLastPeriodEnding.PeriodEnding,'yyyy-mm-dd')>
</cfif>

<script>
	DislayThisDailyActivity=function(DailyActivityId)
	{
		ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
		//ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
		//$("#ActivityLogItem").load(location.href + " #ActivityLogItem");
	}

</script>

<style>
       table.ActivityDateItem {
        width: 100%;
        border: 1px solid gray;
        border-collapse: collapse;
    }

    table.ActivityDateItem td {
        border: 1px solid gray;
        padding:5px;
        color: blue;
        font-size:12px
    }

    table.ActivityDateItem td:hover {
        text-decoration: underline;
        cursor: pointer;

    }

    table.ActivityDateItem th {
        border: 1px solid gray;
        padding:5px;
        font-weight: bold;
        text-align: center;
        background-color: lightGray;
        font-size:12px
    }
</style>

<style>
    span.label {
        font-weight: bold;
        color: purple;
        font-size:12px;
    }

</style>

<cfinvoke component="ActivityLog" method="GetActivityLog"  LastPeriodEnd = #url.PeriodEnding# returnvariable="gGetActivityLog">

<table class="ActivityDateItem">
	<cfif url.PeriodEnding NEQ 0>
	<tr>
		<th style="width:185px">Activity Dates</th>
	</tr>
	</cfif>
	<cfoutput query="gGetActivityLog">
		<cfif currentRow MOD 2 EQ 0>
			<cfset bgColor = 'white'>
		<cfelse>
			<cfset bgColor = '##eceaf2'>
		</cfif>
		<tr style="border-bottom: 1px solid gray; background-color:#bgColor#">
			<cfset variables.ThisActivityDate = DateFormat(ACTIVITYDATE, 'DDDD mmm dd, yyyy')>
			<cfset variables.ThisPeriodEnding = DateFormat(PeriodEnding,  'mmm dd')>
			<td class="DisplayActivityID" onclick="DislayThisDailyActivity('#gGetActivityLog.DAILYACTIVITYID_PK#')">
				#variables.ThisActivityDate#<!---[Period Ending: #variables.ThisPeriodEnding#]--->
			</td>
		</tr>
	</cfoutput>
</table>

