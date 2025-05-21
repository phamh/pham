<!--- --->
<cfcomponent>
	<Cfset session.message = 'no error'>
	<cffunction name="SearchDupActivityDate" access="remote" returntype="numeric">
		<cfargument name="NewActivityDate"type="date">

	    <cfquery name="qSearchDupActivityDate"  datasource="#application.PhamDataSource#" >
	        SELECT 	ActivityDate
	        FROM	activitylog
	        WHERE 	ActivityDate = <cfqueryparam value="#NewActivityDate#" cfsqltype="cf_sql_date">
	    </cfquery>

		<cfreturn qSearchDupActivityDate.recordCount>
	</cffunction>

	<cffunction name="AddNewActivityDate" access="remote" output="no">
		<cfargument name="NewActivityDate"type="date">
		<cfargument name="PeriodEnding"type="date">

	    <cfquery name="SearchDupActivityDate"  datasource="#application.PhamDataSource#" >
	        SELECT 	ActivityDate
	        FROM	activitylog
	        WHERE 	ActivityDate = <cfqueryparam value="#NewActivityDate#" cfsqltype="cf_sql_date">
	    </cfquery>
	    <cfif SearchDupActivityDate.recordCount>
	    	<cfset session.message = SearchDupActivityDate.recordCount>
	    <cfelse>
		    <cfquery name="InsertNewActivityLog"  datasource="#application.PhamDataSource#" >
		        INSERT INTO activitylog(ActivityDate,PeriodEnding)
		        VALUES
		        (
		            <cfqueryparam value="#arguments.NewActivityDate#" cfsqltype="cf_sql_date">,
		            <cfqueryparam value="#arguments.PeriodEnding#" cfsqltype="cf_sql_date">
		        )
		    </cfquery>
	    </cfif>
		<cfreturn session.message>
	</cffunction>

	<cffunction name="AddNewActivity" access="remote" output="no">
		<cfargument name="NewActivityDate"type="date">
		<cfargument name="TaskOrderNumber"type="string">
		<cfargument name="WorkPerformed"type="string">
		<cfargument name="Hours"type="numeric">
		<cfargument name="PeriodEnding"type="date">
	    <cfquery name="InsertNewActivityLog"  datasource="#application.PhamDataSource#" >
	        INSERT INTO activitylog(TaskOrderID_fk, ActivityDate)
	        VALUES
	        (
	            <cfqueryparam value="#arguments.TaskOrderNumber#" cfsqltype="cf_sql_integer">,
	            <cfqueryparam value="#arguments.NewActivityDate#" cfsqltype="cf_sql_date">,
	            <cfqueryparam value="#arguments.WorkPerformed#" cfsqltype="cf_sql_char">,
	            <cfqueryparam value="#arguments.Hours#" cfsqltype="cf_sql_float">,
	            <cfqueryparam value="#arguments.PeriodEnding#" cfsqltype="cf_sql_date">
	        )
	    </cfquery>

		<cfreturn session.message>
	</cffunction>

	<cffunction name="getTaskOrderNumber"  returntype="query">

			<cfquery name="qGetTaskOrderNumber" datasource="#application.PhamDataSource#">
				SELECT *
				FROM	taskOrder
				WHERE	DeletedFlag IS NULL OR DeletedFlag = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
				ORDER BY TASKORDERNUMBER
			</cfquery>

		<cfreturn qGetTaskOrderNumber>
	</cffunction>

	<cffunction name="GetActivityLog" returntype="query" access="remote">
		<cfargument name="LastPeriodEnd"type="Date">
		<cfquery name="qGetActivityLog" datasource="#application.PhamDataSource#">
			SELECT 		DailyActivityID_pk, ActivityDate, PeriodEnding
			FROM		activitylog
			WHERE		PeriodEnding  = <cfqueryparam value="#arguments.LastPeriodEnd#" cfsqltype="cf_sql_date">
			ORDER BY 	ActivityDate
		</cfquery>
		<cfreturn qGetActivityLog>
	</cffunction>

	<cffunction name="GetActivityLogItem" returntype="query">
		<cfargument name="DailyActivityId"type="numeric">
		<cfquery name="gGetActivityLogItem" datasource="#application.PhamDataSource#">
			SELECT 		logItem.ActivityLogItemID_pk, logItem.DailyActivityID_fk, logItem.TaskOrderID_fk, logItem.Hours,logItem.WorkPerformed,
						TaskOrder.TaskOrderNumber, TaskOrder.TaskOrderDescription,
						AL.activityDate
			FROM		activitylogitem AS logItem, taskorder AS TaskOrder,
						activitylog AS AL
			WHERE 		logItem.DailyActivityID_fk = <cfqueryparam value="#arguments.DailyActivityId#" cfsqltype="cf_sql_integer"> AND
						logItem.TaskOrderID_fk = TaskOrder.TaskOrderID_pk AND
						logItem.DailyActivityID_fk = AL.DailyActivityID_pk
		</cfquery>

		<cfreturn gGetActivityLogItem>
	</cffunction>

	<cffunction name="AddNewTask" access="remote" output="no">
		<cfargument name="DailyActivityId"type="numeric">
		<cfargument name="TaskNumber"type="numeric">
		<cfargument name="WorkPerformed"type="string">
		<cfargument name="Hours"type="numeric">

	    <cfquery name="qAddNewTask"  datasource="#application.PhamDataSource#" >
	        INSERT INTO activitylogitem(DailyActivityID_fk, TaskOrderID_fk, WorkPerformed, Hours)
	        VALUES
	        (
	            <cfqueryparam value="#arguments.DailyActivityId#" cfsqltype="cf_sql_integer">,
	            <cfqueryparam value="#arguments.TaskNumber#" cfsqltype="cf_sql_integer">,
	            <cfqueryparam value="#arguments.WorkPerformed#" cfsqltype="cf_sql_char">,
	            <cfqueryparam value="#arguments.Hours#" cfsqltype="cf_sql_float">
	        )
	    </cfquery>
		<cfreturn session.message>
	</cffunction>

	<cffunction name="GetActivityDate" returntype="query">
		<cfargument name="DailyActivityId"type="numeric">
		<cfquery name="qGetActivityLogItem" datasource="#application.PhamDataSource#">
			SELECT 		AL.activityDate, AL.PeriodEnding
			FROM		activitylog AS AL
			WHERE 		AL.DailyActivityID_pk = <cfqueryparam value="#arguments.DailyActivityId#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn qGetActivityLogItem>
	</cffunction>

	<cffunction name="GetThisTask" returntype="query">
		<cfargument name="ActivityLogItemID_pk"type="numeric">
		<cfquery name="qGetThisTask" datasource="#application.PhamDataSource#">
			SELECT 		*
			FROM		activitylogitem
			WHERE 		ActivityLogItemID_pk = <cfqueryparam value="#arguments.ActivityLogItemID_pk#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn qGetThisTask>
	</cffunction>

	<cffunction name="EditThisActivity" access="remote">
		<cfargument name="ActivityLogItemID_pk"type="numeric">
		<cfargument name="TaskNumber"type="numeric">
		<cfargument name="WorkPerformed"type="string">
		<cfargument name="Hours"type="numeric">

	    <cfquery name="qEditThisActivity"  datasource="#application.PhamDataSource#" >
	    	UPDATE activitylogitem

	    	SET		TaskOrderID_fk = <cfqueryparam value="#arguments.TaskNumber#" cfsqltype="cf_sql_integer">,
		    		WorkPerformed = <cfqueryparam value="#arguments.WorkPerformed#" cfsqltype="cf_sql_char">,
		    		Hours = <cfqueryparam value="#arguments.Hours#" cfsqltype="cf_sql_float">

	    	WHERE	ActivityLogItemID_pk = <cfqueryparam value="#arguments.ActivityLogItemID_pk#" cfsqltype="cf_sql_integer">
	    </cfquery>
		<cfreturn session.message>
	</cffunction>

	<cffunction name="DeleteThisActivity" access="remote">
		<cfargument name="ActivityLogItemID_pk"type="numeric">
	    <cfquery name="qDeleteThisActivity"  datasource="#application.PhamDataSource#" >
	    	DELETE
	    	FROM	activitylogitem
	    	WHERE	ActivityLogItemID_pk = <cfqueryparam value="#arguments.ActivityLogItemID_pk#" cfsqltype="cf_sql_integer">
	    </cfquery>
		<cfreturn session.message>
	</cffunction>

	<cffunction name="MonthlyReport" access="remote">
		<cfargument name="ReportMonth"type="numeric">
		<cfargument name="ReportYear"type="numeric">

	    <cfquery name="qMonthlyReport"  datasource="#application.PhamDataSource#" >
	    	SELECT *
	    	FROM	activitylogitem
	    </cfquery>
		<cfreturn qMonthlyReport>
	</cffunction>

	<cffunction name="SetApplicationDumpSrcFilenames" access="remote">
		<cfset application.dumpSrcFilenames = !application.dumpSrcFilenames>
		<cfreturn application.dumpSrcFilenames>
	</cffunction>

	<cffunction name="ShowCFDUMP" access="remote">
		<cfset session.showCFDUMP = !session.showCFDUMP>
		<cfreturn session.showCFDUMP>
	</cffunction>

	<cffunction name="ShowBorder" access="remote">
		<!---<cfset session.borderWidth = !session.borderWidth>--->
		<cfif session.borderWidth EQ '0px'>
			<cfset session.borderWidth = '1px'>
		<cfelse>
		<cfset session.borderWidth = '0px'>
		</cfif>
		<cfreturn session.borderWidth>
	</cffunction>

	<cffunction name="GetPeriodEnding" returntype="query">
		<cfquery name="qGetTaskOrderNumber" datasource="#application.PhamDataSource#">
			SELECT 	DISTINCT PeriodEnding
			FROM	ActivityLog
		</cfquery>
		<cfreturn qGetTaskOrderNumber>
	</cffunction>

	<cffunction name="ChangeDataSource" access="remote" returntype="string">
		<!---<cfset session.borderWidth = !session.borderWidth>--->
		<cfif application.PhamDataSource EQ "activitylog">
			<cfset application.PhamDataSource = 'activitylog_test'>
		<cfelse>
			<cfset application.PhamDataSource = 'activitylog'>
		</cfif>
		<cfreturn application.PhamDataSource>
	</cffunction>

	<cffunction name="CalculatePeriodEnding" access="remote"  returntype="string">
		<cfargument name="NewActivityDate"type="date">
		<cfparam name="variables.PeriodEnding" default="">
		<cfif DateFormat(arguments.NewActivityDate,'DDD') EQ 'Sun'>
			<cfset variables.PeriodEnding = arguments.NewActivityDate>
		<cfelse>
			<cfloop from="1" to="7" index="i">
				<cfset PeriodEnding = dateAdd("d",i,arguments.NewActivityDate)>
				<cfif DateFormat(variables.PeriodEnding,'DDD') EQ 'Sun'>
					<cfset variables.PeriodEnding = dateAdd("d",i,arguments.NewActivityDate)>
					<cfbreak>
				</cfif>
			</cfloop>
		</cfif>
		<cfreturn DateFormat(variables.PeriodEnding, 'yyyy-mm-dd')>
	</cffunction>

	<cffunction name="DeleteActivityDates" access="remote" output="no" returntype="string">
		<cftry>
		    <cfquery name="SearchDupActivityDate"  datasource="#application.PhamDataSource#" >
		        DELETE
		        FROM 	ActivityLog
		    </cfquery>
			<cfquery name="LastActivityDate" datasource="#application.PhamDataSource#">
		        DELETE
		        FROM 	ActivityLogItem
			</cfquery>

			<cfquery name="LastActivityDate" datasource="#application.PhamDataSource#">
		        DELETE
		        FROM 	accomplishmentmonth
			</cfquery>
        <cfcatch type="Any" >
        	<cfset session.message = cfcatch.message>
        </cfcatch>
        </cftry>



		<cfreturn session.message>
	</cffunction>

	<cffunction name="AddNextActivityWeek" access="remote" returntype="string">
		<cfargument name="StartWithThiaDate"type="string">
		<cfset MyDateFormat = 'eee  MMM DD, YYYY'>
<!---		<cfquery name="LastActivityDate" datasource="#application.PhamDataSource#">
			SELECT 	ActivityDate
			FROM	ActivityLog
			ORDER BY ActivityDate DESC LIMIT  1
		</cfquery>	--->

<!---		<cfif NOT LastActivityDate.recordCount>
			<cfset arguments.NewActivityDate = DateFormat('2021-12-13', MyDateFormat)>
		<cfelse>
			<cfset arguments.NewActivityDate = DateAdd("d",1,LastActivityDate.ActivityDate)>
		</cfif>--->
		<cftry>
			<cfset arguments.NewActivityDate = arguments.StartWithThiaDate>

			<cfloop from="0" to="6" index="i">
				<cfif DateFormat(arguments.NewActivityDate,'DDD') EQ 'Sun'>
					<cfset variables.PeriodEnding = arguments.NewActivityDate>
					<cfset TempDate = dateAdd("d",0,arguments.NewActivityDate)>
				<cfelse>

				<cfset TempDate = dateAdd("d",i,arguments.NewActivityDate)>
				<cfloop from="0" to="7" index="i">
					<cfset PeriodEnding = dateAdd("d",i,TempDate)>
					<cfif DateFormat(variables.PeriodEnding,'DDD') EQ 'Sun'>
						<cfset variables.PeriodEnding = dateAdd("d",i,TempDate)>
						<cfbreak>
					</cfif>
				</cfloop>
				</cfif>

			    <cfquery name="InsertNewActivityLog"  datasource="#application.PhamDataSource#" >
			        INSERT INTO activitylog(ActivityDate,PeriodEnding)
			        VALUES
			        (
			            <cfqueryparam value="#TempDate#" cfsqltype="cf_sql_date">,
			            <cfqueryparam value="#variables.PeriodEnding#" cfsqltype="cf_sql_date">
			        )
			    </cfquery>
			</cfloop>
		<cfcatch type="Any" >
			<cfset session.message =  cfcatch>
		</cfcatch>
		</cftry>
		<cfreturn session.message>
	</cffunction>

	<cffunction name="function_getCellFormat" returntype="struct">
		<cfargument name="color" type="string" required="true">
		<cfargument name="bold" type="boolean" required="true">
		<cfargument name="alignment" type="string" required="true">
		<cfargument name="bottomborder" type="string" required="true">
		<cfargument name="bottombordercolor" type="string" required="true">
		<cfargument name="topborder" type="string" required="true">
		<cfargument name="topbordercolor" type="string" required="true">
		<cfargument name="leftborder" type="string" required="true">
		<cfargument name="leftbordercolor" type="string" required="true">
		<cfargument name="rightborder" type="string" required="true">
		<cfargument name="rightbordercolor" type="string" required="true">
		<cfargument name="fgcolor" type="string" required="true">
		<cfargument name="fontsize" type="numeric" required="true">
		<cfargument name="verticalalignment" type="string" required="true">
		<cfargument name="font" type="string"  required="true">
		<cfargument name="textwrap" type="string"  required="true">
		<cfargument name="underline" type="boolean"  required="true">

		<cfset thisCellFormat =  StructNew()>
		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.color =  arguments.color>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.bold =  arguments.bold>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.alignment =  arguments.alignment>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.bottomborder =  arguments.bottomborder>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.bottombordercolor =  arguments.bottombordercolor>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.topborder =  arguments.topborder>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.topbordercolor =  arguments.topbordercolor>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.leftborder =  arguments.leftborder>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.leftbordercolor =  arguments.leftbordercolor>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.rightborder =  arguments.rightborder>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.rightbordercolor =  arguments.rightbordercolor>
		</cfif>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.fgcolor =  arguments.fgcolor>
		</cfif>

		<cfset thisCellFormat.fontsize =  arguments.fontsize>

		<cfif arguments.color NEQ ''>
			<cfset thisCellFormat.verticalalignment =  arguments.verticalalignment>
		</cfif>

		<cfset thisCellFormat.font =  arguments.font>

		<cfset thisCellFormat.textwrap =  arguments.textwrap>

		<cfset thisCellFormat.underline =  arguments.underline>

		<cfreturn thisCellFormat>

	</cffunction>

	<cffunction name="AddNextSetAccomplishmentMonth" access="remote" returntype="string">

		<cfquery name="qGetLastAcomplishmentMonth" datasource="#application.PhamDataSource#">
			SELECT *
			FROM accomplishmentmonth
			ORDER BY accomplishmentmonth DESC
			LIMIT 1
		</cfquery>

		<cfif qGetLastAcomplishmentMonth.recordCount EQ 0>
			<cfset StartDate = now()>

		<cfelse>
			<cfset startDate = DateAdd("m",1,qGetLastAcomplishmentMonth.ACCOMPLISHMENTMONTH)>
		</cfif>

		<cfloop from="0" to="11" index="i">
		    <cfquery name="InsertNewActivityLog"  datasource="#application.PhamDataSource#" >
		        INSERT INTO accomplishmentmonth(AccomplishmentMonth)
		        VALUES
		        (
		            <cfqueryparam value="#DateAdd("m",i,StartDate)#" cfsqltype="cf_sql_date">
		        )
		    </cfquery>
		</cfloop>

		<cfreturn session.message>
	</cffunction>

	<cffunction name="fSaveAccomplishment" access="remote" returntype="string">
		<cfargument name="newRemarkArray"  type="array">
		<cfargument name="AccomplishmentMonthID"  type="numeric">
		<cfset session.newRemarkArray = arguments.newRemarkArray>
		<cftry>
			<cftransaction >
	            <cfquery name="qSaveAccomplishment"  datasource="#application.PhamDataSource#" >
	                DELETE
	                FROM 	accomplishment
	                WHERE 	AcomplishmentMonthID_fk = <cfqueryparam value="#arguments.AccomplishmentMonthID#" cfsqltype="cf_sql_integer">
	            </cfquery>

		        <cfloop from="1" to="#ArrayLen(newRemarkArray)#" index="i">
		            <cfquery name="qSaveAccomplishment"  datasource="#application.PhamDataSource#" >
		                INSERT INTO accomplishment(AcomplishmentMonthID_fk, AccomplishmentDescription)
		                VALUES
		                (
		                    <cfqueryparam value="#arguments.AccomplishmentMonthID#" cfsqltype="cf_sql_integer">,
		                    <cfqueryparam value="#newRemarkArray[i]#" cfsqltype="cf_sql_char">
		                )
		            </cfquery>
		        </cfloop>
	        </cftransaction>
	        <cfcatch type="Any" >
				<cfset session.message = cfcatch.message>
	        </cfcatch>
        </cftry>
        <cfif session.message EQ 'no error'>
			<cfset session.message = 'Accomplishment is updated successfully.'>
        </cfif>
		<cfreturn session.message>
	</cffunction>

	<cffunction name="fGetThisAcomplishment" returntype="query">
		<cfargument name="AccomplishmentMonthID_fk" type="numeric">
		<cfquery name="qGetThisAcomplishment" datasource="#application.PhamDataSource#">
			SELECT 		AccomplishmentID_pk, AcomplishmentMonthID_fk, AccomplishmentDescription AS High_Level_Accomplishment
			FROM		accomplishment
			WHERE 		AcomplishmentMonthID_fk = <cfqueryparam value="#arguments.AccomplishmentMonthID_fk#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn qGetThisAcomplishment>
	</cffunction>

</cfcomponent>

