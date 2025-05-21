<!---
Created by Al Kuo 3/23/2022
Description: it exports a list of FTTRW records to Excel
Related file(s): EmployeeForms/dspRemoteJustificationList.cfm/classes/EmployeeFormsAPL.cfc
Date       Modified      Description
05/02/2022	Kha Pham	Modified the method of the codes so it does not use session variables. changed some labels and added more fields
05/17/2022	Hung Pham	SWB-874: Displays active records on landing pageo.
						Auto-sorts PASS BUE records to the top of the list by timer (negative to positive).
						All other active records by timer (negative to positive)

--->


<cfinvoke component="classes.EmployeeFormsAPL" method="fGetFTTRWAPLList" returnvariable="qGetFTTRWAPLList">
	<cfinvokeargument name="viewStatus" value="#viewStatus#">
	<cfif isDefined("COUNDOWN_48_HR")><cfinvokeargument name="COUNDOWN_48_HR" value="#COUNDOWN_48_HR#"></cfif>
	<cfif isDefined("remote_id")><cfinvokeargument name="remote_id" value="#remote_id#"></cfif>
	<cfif isDefined("org_code")><cfinvokeargument name="org_code" value="#org_code#"></cfif>
	<cfif isDefined("bargain_unit_stat_descr")><cfinvokeargument name="bargain_unit_stat_descr" value="#bargain_unit_stat_descr#"></cfif>
	<cfif isDefined("emp_name")><cfinvokeargument name="emp_name" value="#emp_name#"></cfif>
	<cfif isDefined("location_requested")><cfinvokeargument name="location_requested" value="#location_requested#"></cfif>
	<cfif isDefined("total_proj_cost_save")><cfinvokeargument name="total_proj_cost_save" value="#total_proj_cost_save#"></cfif>
	<cfif isDefined("status_rwa")><cfinvokeargument name="status_rwa" value="#status_rwa#"></cfif>
	<cfif isDefined("status_dt")><cfinvokeargument name="status_dt" value="#status_dt#"></cfif>
</cfinvoke>

<cfset TempQuery = QueryNew('COUNDOWN_48_HR, RW_APL_FORM_ID, hr_org_code,BARGAIN_UNIT_STAT_DESCR, employee_name, PRO_DUTY_STN_DESCR, TOTAL_PROJ_COST_SAVE, WORKFLOW_NAME,EDIT_DT_MM_DD_YYYY',
							'VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR')>

<cffunction name="AllQueriesTogetherForExcel"  returntype="query">
	<cfargument name="TheQuery" type="query">
	<cfloop query="#TheQuery#">
		<cfset QueryAddRow(TempQuery, 1)>
		<cfset QuerySetCell(TempQuery, "COUNDOWN_48_HR", COUNDOWN_48_HR)>
		<cfset QuerySetCell(TempQuery, "RW_APL_FORM_ID", RW_APL_FORM_ID)>
		<cfset QuerySetCell(TempQuery, "hr_org_code", hr_org_code)>
		<cfset QuerySetCell(TempQuery, "bargain_unit_stat_descr", bargain_unit_stat_descr)>
		<cfset QuerySetCell(TempQuery, "employee_name", employee_name)>
		<cfset QuerySetCell(TempQuery, "PRO_DUTY_STN_DESCR", PRO_DUTY_STN_DESCR)>
		<cfset QuerySetCell(TempQuery, "TOTAL_PROJ_COST_SAVE", TOTAL_PROJ_COST_SAVE)>
		<cfset QuerySetCell(TempQuery, "WORKFLOW_NAME", WORKFLOW_NAME)>
		<cfset QuerySetCell(TempQuery, "EDIT_DT_MM_DD_YYYY", EDIT_DT_MM_DD_YYYY)>
	</cfloop>
	<cfreturn TempQuery>
</cffunction>


<cfinvoke component="classes.EmployeeFormsAPL" method="fSearchFormByTimer" returnvariable="qGetFTTRWAPLListByPass_Overdue">
	<cfinvokeargument name="TheQuery" value="#qGetFTTRWAPLList#">
	<cfinvokeargument name="SearchType" value="1"><!---Pass Overdue TIMER--->
	<cfinvokeargument name="SortDirection" value="ASC">
	<cfinvokeargument name="ColumnToBeSorted" value="MINUTES_COUNTDOWN">
</cfinvoke>

<cfinvoke component="classes.EmployeeFormsAPL" method="fSearchFormByTimer" returnvariable="qGetFTTRWAPLListByPass_Positive">
	<cfinvokeargument name="TheQuery" value="#qGetFTTRWAPLList#">
	<cfinvokeargument name="SearchType" value="2"><!---Pass Positive TIMER, Approve, Disapprove, Cancel, Return --->
	<cfinvokeargument name="SortDirection" value="ASC">
	<cfinvokeargument name="ColumnToBeSorted" value="COUNDOWN_48_HR">
</cfinvoke>

<cfinvoke component="classes.EmployeeFormsAPL" method="fSearchFormByTimer" returnvariable="qGetFTTRWAPLListByNonePass_Overdue">
	<cfinvokeargument name="TheQuery" value="#qGetFTTRWAPLList#">
	<cfinvokeargument name="SearchType" value="3"><!---None Pass Overdue TIMER --->
	<cfinvokeargument name="SortDirection" value="ASC">
	<cfinvokeargument name="ColumnToBeSorted" value="MINUTES_COUNTDOWN">
</cfinvoke>

<cfinvoke component="classes.EmployeeFormsAPL" method="fSearchFormByTimer" returnvariable="qGetFTTRWAPLListByNonePass_Positive">
	<cfinvokeargument name="TheQuery" value="#qGetFTTRWAPLList#">
	<cfinvokeargument name="SearchType" value="4"><!---None Pass Positive TIMER, Approve, Disapprove, Cancel, Return --->
	<cfinvokeargument name="SortDirection" value="ASC">
	<cfinvokeargument name="ColumnToBeSorted" value="COUNDOWN_48_HR">
</cfinvoke>


<!---I TRIED TO USE SELECT/UNION TO UNION ALL QUERIES TOGETHER, BUT BY DOING THAT THE SORT ORDER IS LOST
	SO I HAVE STORE EACH QUERY INTO A TEMP QUERY
 --->
<cfset qTemp = AllQueriesTogetherForExcel(#qGetFTTRWAPLListByPass_Overdue#)>
<cfset qTemp = AllQueriesTogetherForExcel(#qGetFTTRWAPLListByPass_Positive#)>
<cfset qTemp = AllQueriesTogetherForExcel(#qGetFTTRWAPLListByNonePass_Overdue#)>
<cfset qTemp = AllQueriesTogetherForExcel(#qGetFTTRWAPLListByNonePass_Positive#)>

<cfset qGetFTTRWAPLListForExcel = TempQuery>

<cfoutput>
	<cfset variables.rptTitle ="APL Full-Time Telework or Remote Work (FTTRW)">
	<cfset header_row_ctr = 2>

	<cfset variables.xlFileName = "APL_FTTRW_Report_#DateFormat(now(),'mmddyyyy')#.xlsx">
	<cfset variables.rptObject = spreadsheetNew("true")><!---initiallize object--->

	<cfset variables.Column_Header = "TIMER (HH:MM),ID NUMBER,ORGANIZATION CODE,BUS DESCRIPTION,EMPLOYEE,REQUESTED LOCATION,TOTAL PROJECTED ANNUAL COST,CURRENT STATUS,STATUS DATE">

	<!---there are 10 or 11 columns in to export; column number and the width in pixels--->
	<cfset spreadSheetSetColumnWidth(variables.rptObject,1,12)><!---TIMER --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,2,14)><!---ID NUMBER --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,3,20)><!---ORGANIZATION CODE --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,4,40)><!---BUS DESCR --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,5,25)><!---EMPLOYEE NAME --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,6,40)><!---REQUESTED LOCATION --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,7,25)><!---TOTAL PROJ COST/SAVING  --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,8,20)><!---STATUS  --->
    <cfset spreadSheetSetColumnWidth(variables.rptObject,9,20)><!---STATUS DATE --->

	<!---This is report title on 1st col and row 1st row--->
	<cfset today_date = "#DateFormat(now(),'mm/dd/yyyy')#">
	<cfset SpreadsheetAddRow(variables.rptObject,"#variables.rptTitle#,,,,,,Export Date: #today_date#,,",1,1)><!---total of 9 columns--->

	<!---freeze header starts at #header_row_ctr#--->
	<cfset spreadsheetAddFreezePane(variables.rptObject, 0, #header_row_ctr#)>
	<cfset SpreadSheetAddAutoFilter(variables.rptObject,"A#header_row_ctr#:I#header_row_ctr#")>

	<!---Syntax: SpreadsheetMergeCells(spreadsheetObj,startRow,endRow,startColumn, endColumn)--->
	<cfset SpreadsheetMergeCells(variables.rptObject, 1, 1, 1, 6)><!---Merge col 1 to 6--->
	<cfset SpreadsheetMergeCells(variables.rptObject, 1,1,7,9)><!---Merge col 7 to 9--->

	<cfset spreadsheetAddRow(variables.rptObject, "#variables.Column_Header#")>
	<cfset spreadsheetAddRows(variables.rptObject, qGetFTTRWAPLListForExcel)>

	<cfset spreadsheetFormatRow(variables.rptObject, {
	   bold=true,
	   fontsize="14",
	   textwrap="true"
	 }, "1")>

	<cfset spreadsheetFormatRow(variables.rptObject, {
	   bold=true,
	   fontsize="11",
	   topborder="thin",
	   rightborder="thin",
	   bottomborder="thin",
	   leftborder="thin",
	   textwrap="true",
	   fgcolor="grey_25_percent"
	 }, "#header_row_ctr#")>

	<cfheader name="content-disposition" value="attachment; filename=#variables.xlFileName#" />
	<cfcontent type="application/vnd.ms-excel" variable="#spreadsheetReadBinary(variables.rptObject)#" reset="true">

</cfoutput>

