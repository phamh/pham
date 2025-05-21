
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfset  qActivityLog = session.qGetActivityLogReport>

<!---
black, brown, olive_green, dark_green, dark_teal, dark_blue,
indigo, grey_80_percent, orange, dark_yellow, green, teal, blue,
blue_grey, grey_50_percent, red, light_orange, lime, sea_green, aqua,
light_blue, violet, grey_40_percent, pink, gold, yellow, bright_green,
turquoise, dark_red, sky_blue, plum, grey_25_percent, rose, light_yellow,
light_green, light_turquoise, light_turquoise, pale_blue, lavender, white,
cornflower_blue, lemon_chiffon, maroon, orchid, coral, royal_blue, green
light_cornflower_blue.



Bottomborder: A border format, any of the following:
none (default), thin, medium, dashed, hair, thick,
double, dotted, medium_dashed, dash_dot, medium_dash_dot, dash_dot_dot, medium_dash_dot_dot, slanted_dash_dot



SpreadsheetMergeCells(spreadsheetObj, startRow, endRow, startColumn, endColumn)
SpreadsheetSetCellValue(spreadsheetObj, value, row, column)
SpreadsheetFormatCell(spreadsheetObj, format, row, column)
SpreadSheetSetColumnWidth(spreadhsheetobj, column number, width)1
--->

<cfset pageReportFontSize = 14>
<cfset formatFontSize = 10>
<cfset formatFontColor = 'black'>
<cfset formatFontStyle = 'Arial'>

<cfset theFile=GetDirectoryFromPath(GetCurrentTemplatePath()) & "Reports\ActivityLog.xlsx">

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="reportName">
	<cfinvokeargument name="color" value="blue">
	<cfinvokeargument name="bold" value="true">
	<cfinvokeargument name="alignment" value="center">
	<cfinvokeargument name="bottomborder" value="0">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="0">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="0">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="0">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#pageReportFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="reportDate">
	<cfinvokeargument name="color" value="black">
	<cfinvokeargument name="bold" value="true">
	<cfinvokeargument name="alignment" value="center">
	<cfinvokeargument name="bottomborder" value="0">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="0">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="0">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="0">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="header">
	<cfinvokeargument name="color" value="black">
	<cfinvokeargument name="bold" value="true">
	<cfinvokeargument name="alignment" value="center">
	<cfinvokeargument name="bottomborder" value="thin">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="thin">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="thin">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="thin">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="grey_50_percent">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="data">
	<cfinvokeargument name="color" value="black">
	<cfinvokeargument name="bold" value="false">
	<cfinvokeargument name="alignment" value="center">
	<cfinvokeargument name="bottomborder" value="thin">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="thin">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="thin">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="thin">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="dataLeft">
	<cfinvokeargument name="color" value="black">
	<cfinvokeargument name="bold" value="false">
	<cfinvokeargument name="alignment" value="left">
	<cfinvokeargument name="bottomborder" value="thin">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="thin">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="thin">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="thin">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="dataRight">
	<cfinvokeargument name="color" value="black">
	<cfinvokeargument name="bold" value="false">
	<cfinvokeargument name="alignment" value="right">
	<cfinvokeargument name="bottomborder" value="thin">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="thin">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="thin">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="thin">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="PeriodEnding_dataRight">
	<cfinvokeargument name="color" value="green">
	<cfinvokeargument name="bold" value="true">
	<cfinvokeargument name="alignment" value="right">
	<cfinvokeargument name="bottomborder" value="double">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="thin">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="thin">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="thin">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfinvoke component="ActivityLog" method="function_getCellFormat"  returnvariable="PeriodEnding">
	<cfinvokeargument name="color" value="green">
	<cfinvokeargument name="bold" value="true">
	<cfinvokeargument name="alignment" value="right">
	<cfinvokeargument name="bottomborder" value="double">
	<cfinvokeargument name="bottombordercolor" value="black">
	<cfinvokeargument name="topborder" value="thin">
	<cfinvokeargument name="topbordercolor" value="black">
	<cfinvokeargument name="leftborder" value="thin">
	<cfinvokeargument name="leftbordercolor" value="black">
	<cfinvokeargument name="rightborder" value="thin">
	<cfinvokeargument name="rightbordercolor" value="black">
	<cfinvokeargument name="fgcolor" value="white">
	<cfinvokeargument name="fontsize" value="#formatFontSize#">
	<cfinvokeargument name="verticalalignment" value="vertical_center">
	<cfinvokeargument name="font" value="#formatFontStyle#">
	<cfinvokeargument name="textwrap" value="true">
	<cfinvokeargument name="underline" value="false">
</cfinvoke>

<cfset theSheet = spreadsheetNew("ActivityLog","true")>zzzz<cfabort>

<!---
<cfloop from="1" to= "25" index="theRow">
	<cfloop from="1" to="16" index="theColumn">
		<cfset SpreadsheetFormatCell(theSheet, versionNumber, theRow,theColumn)>
	</cfloop>
</cfloop>--->


<!---Blank line --->

<!---<cfset SpreadsheetMergeCells(theSheet,2,5,1,1)>--->
<cfset SpreadsheetFormatCell(theSheet, Header, 1,1)>
<cfset SpreadsheetFormatCell(theSheet, Header, 1,2)>
<cfset SpreadsheetFormatCell(theSheet, Header, 1,3)>
<cfset SpreadsheetFormatCell(theSheet, Header, 1,4)>
<cfset SpreadsheetFormatCell(theSheet, Header, 1,5)>

<!---Overall Mission Resource Status --->

<cfset SpreadsheetSetCellValue(theSheet,"Date",1,1)>
<cfset SpreadsheetSetCellValue(theSheet,"Task Order Number",1,2)>
<cfset SpreadsheetSetCellValue(theSheet,"Sub Task",1,3)>
<cfset SpreadsheetSetCellValue(theSheet,"Work Performed",1,4)>
<cfset SpreadsheetSetCellValue(theSheet,"Hours (0.1 - 8)",1,5)>

<cfset SpreadSheetSetColumnWidth(theSheet,1,30)>
<cfset SpreadSheetSetColumnWidth(theSheet,2,30)>
<cfset SpreadSheetSetColumnWidth(theSheet,3,50)>
<cfset SpreadSheetSetColumnWidth(theSheet,4,80)>
<cfset SpreadSheetSetColumnWidth(theSheet,5,15)>

<cfset rowDataCounter = 2>
<cfset columDataCounter = 1>
<cfset currentActivityDate = qActivityLog.ActivityDate>
<cfloop query="qActivityLog">
	<cfif qActivityLog.WorkPerformed CONTAINS 'Period Ending'>
		<cfset UseThisFormat = PeriodEnding>
		<cfset UseThisRight = PeriodEnding_dataRight>
	<cfelse>
		<cfset UseThisRight = dataRight>
		<cfset UseThisFormat = dataLeft>
	</cfif>
	<cfset SpreadsheetSetCellValue(theSheet,qActivityLog.ActivityDate,rowDataCounter,1)>
	<cfset SpreadsheetFormatCell(theSheet, UseThisFormat,rowDataCounter,1)>

	<cfset SpreadsheetSetCellValue(theSheet,qActivityLog.Task_Order,rowDataCounter,2)>
	<cfset SpreadsheetFormatCell(theSheet, UseThisFormat,rowDataCounter,2)>

	<cfset SpreadsheetSetCellValue(theSheet,qActivityLog.Sub_Task,rowDataCounter,3)>
	<cfset SpreadsheetFormatCell(theSheet, UseThisFormat,rowDataCounter,3)>

	<cfset SpreadsheetSetCellValue(theSheet,qActivityLog.WorkPerformed,rowDataCounter,4)>
	<cfset SpreadsheetFormatCell(theSheet, UseThisFormat,rowDataCounter,4)>

	<cfset SpreadsheetSetCellValue(theSheet,NumberFormat(qActivityLog.Hours, '_.00'),rowDataCounter,5)>
	<cfset SpreadsheetFormatCell(theSheet, UseThisRight,rowDataCounter,5)>

	<cfset rowDataCounter = rowDataCounter + 1>
</cfloop>

<!---<cfspreadsheet action = "write" filename="ActivityLog.xlsx" query="theSheet" overwrite="true">--->

<!---<cfheader name="content-disposition" value="inline;filename=KaiPham.xlsx">
<cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(theSheet)#" reset="true">--->

