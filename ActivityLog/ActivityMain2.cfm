<cfinclude template="../CheckAccess.cfm" >
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfajaxproxy cfc="ActivityLog" jsclassname="ActivityLogCFC">

<cfquery name="gGetLastPeriodEnding" datasource="#application.PhamDataSource#">
	SELECT 	PeriodEnding
	FROM	ActivityLog
	ORDER BY ActivityDate DESC
	LIMIT 1
</cfquery>

<cfset variables.currentPeriodEnding = dateFormat(gGetLastPeriodEnding.PeriodEnding,'yyyy-mm-dd')>
<input id="lastEndingPeriod" type="hidden" value="<cfoutput>#variables.currentPeriodEnding#</cfoutput>"></input>

<cfparam name="url.ThisMenu" default="ActivityLogMenu">
<script>
	/* wait until the document loaded then run the this script */
/*    $(document).ready(function() {
    	ChangePeriodEnding($('#lastEndingPeriod').val());
    });*/

	/* When user select a diff Period Ending Date */
	ChangePeriodEnding=function(ChangePeriodEnding)
	{
		ColdFusion.navigate('ActivityLog/ActivityDateItem.cfm'+'?PeriodEnding='+ChangePeriodEnding, 'ActivityDateContain');
		if(ChangePeriodEnding == 0)
		{
			ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId=Hide', 'ActivityLogItemContain');
		}

		else
		{
			ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId=0', 'ActivityLogItemContain');
		}
	}
</script>

<!---This is to open a modal dialog window --->
<div id="ActivityDialog"></div>

<cfif url.ThisMenu EQ 'ActivityLogMenu'>
	<cfquery name="GetDistinctPeriodEnding" datasource="#application.PhamDataSource#">
		SELECT 	Distinct PeriodEnding
		FROM	ActivityLog
	</cfquery>

	<cfquery name="gGetLastPeriodEnding" datasource="#application.PhamDataSource#">
		SELECT 	PeriodEnding
		FROM	ActivityLog
		ORDER BY ActivityDate DESC
		LIMIT 1
	</cfquery>


	<div style="margin-bottom:3px; margin-left:6px;" id="PeriodEndingDiv">
		<span class="label">Period Ending:</span>
		<select id="PeriodEnding" name="PeriodEnding" onchange="ChangePeriodEnding(this.value)">
			<option value="0">Select</option>
			<cfoutput query="GetDistinctPeriodEnding">
				<option value="#PeriodEnding#"  selected="<cfif variables.currentPeriodEnding EQ GetDistinctPeriodEnding.PeriodEnding>selected</cfif>">#DateFormat(PeriodEnding,'mm/dd/yyyy')#</option>
			</cfoutput>
		</select>
	</div>
</cfif>
<div style="border: 0px solid gray;padding:5px">

<!---	<div style="margin-bottom:3px" id="PeriodEndingDiv">
		<span class="label">Period Ending:</span>
		<select id="PeriodEnding" name="PeriodEnding" onchange="ChangePeriodEnding(this.value)">
			<option value="0">Select</option>
			<cfoutput query="GetDistinctPeriodEnding">
				<option value="#PeriodEnding#"  selected="<cfif variables.currentPeriodEnding EQ GetDistinctPeriodEnding.PeriodEnding>selected</cfif>">#DateFormat(PeriodEnding,'mm/dd/yyyy')#</option>
			</cfoutput>
		</select>
	</div>--->

<cfswitch expression="#url.ThisMenu#">
	<cfcase value="ActivityLogMenu" >
		<table>
			<tr style="vertical-align:top">
				<td>
					<cfdiv id="ActivityDateContain" name="ActivityDateContain" bind="url:ActivityLog/ActivityDateItem.cfm?PeriodEnding=0"/>
				</td>
				<td
					<div id="ActivityLogItem">
						<cfdiv id="ActivityLogItemContain" name="ActivityLogItemContain" />
					</div>
				</td>
			</tr>
		</table>
	</cfcase>

	<cfcase value="AccomplishmentMenu" >
		<table>
			<tr style="vertical-align:top">
				<td>
					<cfdiv id="ActivityDateContain" name="ActivityDateContain" bind="url:ActivityLog/AccomplishmentMenu.cfm"/>
				</td>
				<td
					<div id="ActivityLogItem">
						<cfdiv id="ActivityLogItemContain" name="ActivityLogItemContain" />
					</div>
				</td>
			</tr>
		</table>
	</cfcase>

	<cfcase value="ReportMenu" >
		<table>
			<tr style="vertical-align:top">
				<td>
					<cfdiv id="ActivityDateContain" name="ActivityDateContain" bind="url:ActivityLog/Reports.cfm"/>
				</td>
<!---				<td
					<div id="ActivityLogItem">
						<cfdiv id="ActivityLogItemContain" name="ActivityLogItemContain" />
					</div>
				</td>--->
			</tr>
		</table>
	</cfcase>

	<cfdefaultcase>
		<cfdump var="#url.ThisMenu#">
	</cfdefaultcase>
</cfswitch>



