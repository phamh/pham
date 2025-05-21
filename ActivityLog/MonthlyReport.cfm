<cfinclude template="../CheckAccess.cfm" >
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfparam name="url.TaskOrderId_fk" default="0" >
<cfparam name="url.StartPeriodEnding" default="0" >
<cfparam name="url.EndPeriodEnding" default="0" >

<cfif url.StartPeriodEnding EQ 0 OR url.EndPeriodEnding EQ 0>
	<div style="color: black; padding:10px">
		Please select your options and click on Run Report button
	</div>
	<cfabort>
</cfif>
<cfset qGetActivityLogReport =QueryNew("Date, Task_Order, Sub_Task, WorkPerformed, Hours, PeriodEnding", "Varchar, Varchar, Varchar,Varchar,Varchar,Varchar")>

<div style="width: 100%; padding:10px;border-top: 0px solid gray">
	<cfif url.StartPeriodEnding EQ '' OR url.EndPeriodEnding EQ ''>
	<cfelse>
	   	<cfquery name="qMonthlyReport"  datasource="#application.PhamDataSource#" >
	    	SELECT 		*, activityDate
	    	FROM		activitylogitem,activityLog
	    	WHERE		activitylogitem.DailyActivityID_fk = activityLog.DailyActivityID_pk AND
	    				<cfif url.TaskOrderId_fk NEQ 0>
	    					activitylogitem.TaskOrderId_fk = <cfqueryparam value="#url.TaskOrderId_fk#" cfsqltype="cf_sql_integer"> AND
	    				</cfif>
	    				<!---(PeriodEnding BETWEEN <cfqueryparam value="#url.StartPeriodEnding#" cfsqltype="cf_sql_date" > AND <cfqueryparam value="#url.EndPeriodEnding#" cfsqltype="cf_sql_date">)--->
	    				activityLog.PeriodEnding >= <cfqueryparam value="#url.StartPeriodEnding#" cfsqltype="cf_sql_date" > AND
	    				activityLog.PeriodEnding <= <cfqueryparam value="#url.EndPeriodEnding#" cfsqltype="cf_sql_date" >
	    	ORDER BY	activitylogitem.DailyActivityID_fk, TASKORDERID_FK
	    </cfquery>

	    <cfif qMonthlyReport.recordCount EQ 0>
	    	<span style="color: red">No record(s) found. Check your selections then click Run Monthly Report button again.</span>
		<cfelse>
			<!---Export Excel button --->
			<div style="margin-bottom:5px">
    			<!---<input onclick="window.location.href='ActivityLog/MonthlyReport_excel.cfm';"class="button" value="Export To Excel" type="button"></input>--->
    			<input onclick="downloadThisFile('ActivityLog\\ActivityLog.xlsx')"class="button" value="Export To Excel" type="button"></input>
			</div>
		    <cfquery name="qMonthlyReport_GroupByWeekEndDate"  datasource="#application.PhamDataSource#" >
		    	SELECT 		*, activityDate
		    	FROM		activitylogitem,activityLog
		    	WHERE		DailyActivityID_fk = activityLog.DailyActivityID_pk AND
		    				activityLog.PeriodEnding >= <cfqueryparam value="#url.StartPeriodEnding#" cfsqltype="cf_sql_date" > AND
		    				activityLog.PeriodEnding <= <cfqueryparam value="#url.EndPeriodEnding#" cfsqltype="cf_sql_date" >
		    	GROUP BY 	activityLog.PeriodEnding
		    </cfquery>

			<table style="border-top:0px solid red; border-collapse:collapse; width:100%">
				<cfset showHeader = 0>
				<cfoutput query="qMonthlyReport_GroupByWeekEndDate">
				<cfset Total = 0>
				<tr>
				    <cfquery name="qMonthlyReport_GroupByDailyActivityDate"  dbtype="query" >
				    	SELECT 		DISTINCT DAILYACTIVITYID_FK,activityDate
				    	FROM		qMonthlyReport
				    	WHERE		PeriodEnding = <cfqueryparam value="#qMonthlyReport_GroupByWeekEndDate.PeriodEnding#" cfsqltype="cf_sql_date">
				    </cfquery>
				    <td>
				    	<table style="border:1px solid gray; border-collapse:collapse; margin-bottom:10px;">
				    		<cfloop query="#qMonthlyReport_GroupByDailyActivityDate#">
							<cfif currentRow MOD 2 EQ 0>
								<cfset bgColor = '##eceaf2'>
							<cfelse>
								<cfset bgColor = 'white'>
							</cfif>
			    			<tr style="background-color:#bgColor#; border-bottom: 1px double gray">
							    <cfquery name="qMonthlyReport_GroupByDailyActivityID"  dbtype="query" >
							    	SELECT 		*
							    	FROM		qMonthlyReport
							    	WHERE		DAILYACTIVITYID_FK = <cfqueryparam value="#qMonthlyReport_GroupByDailyActivityDate.DAILYACTIVITYID_FK#" cfsqltype="cf_sql_integer" >
							    </cfquery>
							    <td>
							    	<table style="border:0px solid blue;border-collapse:collapse; ">
							    		<cfif showHeader EQ 0>
											<tr style="background-color:lightgray; ">
												<th style="text-align:center; font-weight: bold; border-right: 1px solid gray;padding:5px">Date</th>
												<th style="text-align:center; font-weight: bold; border-right: 1px solid gray;padding:5px">Task Order Number</th>
												<th style="text-align:center; font-weight: bold; border-right: 1px solid gray;padding:5px">Sub Task</th>
												<th style="text-align:center; font-weight: bold; border-right: 1px solid gray;padding:5px">Work Performed</th>
												<th style="text-align:center; font-weight: bold; border-right: 0px solid gray;padding:5px">Hours (0.1 - 8)</th>
											</tr>
											<cfset queryAddrow(qGetActivityLogReport)>
											<cfset querySetCell(qGetActivityLogReport, "Date", 'Date')>
											<cfset querySetCell(qGetActivityLogReport, "Task_Order", 'Task Order Number')>
											<cfset querySetCell(qGetActivityLogReport, "Sub_Task", 'Sub Task')>
											<cfset querySetCell(qGetActivityLogReport, "WorkPerformed", 'Work Performed')>
											<cfset querySetCell(qGetActivityLogReport, "PeriodEnding", 'Period Ending')>
											<cfset querySetCell(qGetActivityLogReport, "Hours", 'Hours (0.1-8)')>
											<cfset showHeader = 1>
							    		</cfif>

							    		<cfloop query="#qMonthlyReport_GroupByDailyActivityID#">
										    <cfquery name="GetTaskNumber" datasource="#application.PhamDataSource#" >
										    	SELECT 		*
										    	FROM		taskorder
										    	WHERE		TaskOrderID_pk = <cfqueryparam value="#qMonthlyReport_GroupByDailyActivityID.TaskOrderID_fk#" cfsqltype="cf_sql_integer" >
										    </cfquery>
											<cfset queryAddrow(qGetActivityLogReport)>
											<cfset querySetCell(qGetActivityLogReport, "Date", DateFormat(activityDate, 'long'))>
											<cfset querySetCell(qGetActivityLogReport, "Task_Order", GetTaskNumber.TaskOrderNumber)>
											<cfset querySetCell(qGetActivityLogReport, "Sub_Task", GetTaskNumber.TaskOrderDescription)>
											<cfset querySetCell(qGetActivityLogReport, "WorkPerformed", qMonthlyReport_GroupByDailyActivityID.WORKPERFORMED)>
											<cfset querySetCell(qGetActivityLogReport, "PeriodEnding", qMonthlyReport_GroupByDailyActivityID.PERIODENDING)>
											<cfset querySetCell(qGetActivityLogReport, "Hours", NumberFormat(qMonthlyReport_GroupByDailyActivityID.Hours, '_.00'))>
							    			<tr>
							    				<td style="border-top: 1px solid gray; border-right: 1px solid gray; padding:5px; width:150px; font-weight:bold">#DateFormat(activityDate, 'DDD mmm dd, yyyy')#</td>
							    				<td style="border-top: 1px solid gray; border-right: 1px solid gray; padding:5px; width:150px">#GetTaskNumber.TaskOrderNumber#</td>
							    				<td style="border-top: 1px solid gray; border-right: 1px solid gray; padding:5px; width:250px">#GetTaskNumber.TaskOrderDescription#</td>
							    				<td style="border-top: 1px solid gray; border-right: 1px solid gray; padding:5px; width:600px">#qMonthlyReport_GroupByDailyActivityID.WORKPERFORMED#</td>
							    				<td style="border-top: 1px solid gray; border-right: 0px solid gray; padding:5px; width:120px; text-align:right">#qMonthlyReport_GroupByDailyActivityID.Hours#</td>
							    				<cfset total = evaluate(total + qMonthlyReport_GroupByDailyActivityID.Hours)>
							    			</tr>
							    		</cfloop>
							    	</table>
							    </td>
			    			</tr>
				    		</cfloop>
				    		<tr>
				    			<td style="font-weight:bold; color: black;border: 0px solid gray; text-align: right;">
							    	<table style="border:0px solid blue;border-collapse:collapse; width:100% ">
										<tr>
							    			<td colspan="4" style="border-top: 1px solid gray; border-right: 1px solid gray; padding:5px;; font-weight:bold; color:green">
							    				Period Ending: #DateFormat(qMonthlyReport_GroupByWeekEndDate.PeriodEnding,'long')#
							    			</td>
							    			<td style="border-top: 1px solid gray; border-right: 0px solid gray; padding:5px; width:120px; text-align:right;color:green">
							    				#NumberFormat(total, '_.00')#
							    			</td>
										</tr>
							    	</table>
				    			</td>
				    		</tr>
				    	</table>
				    </td>
				</tr>
					<cfset queryAddrow(qGetActivityLogReport)>
					<cfset querySetCell(qGetActivityLogReport, "WorkPerformed", 'Period Ending:' & DateFormat(qMonthlyReport_GroupByWeekEndDate.PeriodEnding,'long'))>
					<cfset querySetCell(qGetActivityLogReport, "Hours", total)>
				</cfoutput>
			</table>
	    </cfif>

		<cfset session.qGetActivityLogReport = qGetActivityLogReport>
		<!---<cfdump var="#qGetActivityLogReport#">--->
		<CFQuery Name="weekyReport" dbtype="query">
			SELECT DISTINCT PeriodEnding
			FROM qGetActivityLogReport
			WHERE Task_Order = <cfqueryparam value="1248" cfsqltype="cf_sql_varchar" >
		</cfquery>
		<!---<cfdump var="#weekyReport#">--->
		<cfset qGetWeeklyReport =QueryNew("WorkPerformed, PeriodEnding, Hours", "Varchar, Varchar, Varchar")>

		<cfoutput query="weekyReport">
			<CFQuery Name="theReport" dbtype="query">
				SELECT *
				FROM qGetActivityLogReport
				WHERE PeriodEnding = <cfqueryparam value="#weekyReport.PeriodEnding#" cfsqltype="cf_sql_varchar" ><!--- AND
						Task_Order = <cfqueryparam value="1248" cfsqltype="cf_sql_varchar" >--->

			</cfquery>
			<cfloop query="#theReport#">
				<cfset queryAddrow(qGetWeeklyReport)>
				<cfset querySetCell(qGetWeeklyReport, "WorkPerformed", theReport.WorkPerformed)>
				<cfset querySetCell(qGetWeeklyReport, "Hours", theReport.Hours)>
				<cfset querySetCell(qGetWeeklyReport, "PeriodEnding", theReport.PeriodEnding)>
			</cfloop>
		</cfoutput>
		<cfspreadsheet action = "write" filename="ActivityLog.xlsx" query="qGetActivityLogReport" overwrite="true">
	</cfif>
</div>