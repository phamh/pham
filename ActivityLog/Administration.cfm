
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfajaxproxy cfc="ActivityLog" jsclassname="ActivityLogCFC">

<style>
	table.admin
	{
		border: 1px solid gray; 
		border-collapse: collapse; 
		width:800px;
	}

	table.admin th
	{
		border: 1px solid black; 
		font-weight: bold;
		text-align:center;
		background-color:lightgray;
		padding: 5px;
	}

	table.admin td
	{
		text-align:center;
		border: 1px solid black; 
		padding: 5px;
	}
			
</style>	
<script>

	var cfc = new ActivityLogCFC();
	cfc.setHTTPMethod("POST");
	
	TurnApplicationDumpSrcFilenamesStatus = function () {
	    var SetApplicationDumpSrcFilenamesStatus = cfc.SetApplicationDumpSrcFilenames();
	    document.getElementById("DisplaySourceFileStatus").value = "Display Source File: " + SetApplicationDumpSrcFilenamesStatus;
	    location.reload();
	};
	
	ShowCFDUMP = function () {
	    var ShowCFDUMPStatus = cfc.ShowCFDUMP();
	    document.getElementById("showcfdumpValue").value = "Show CFDUMP: " + ShowCFDUMPStatus;
	    //location.reload();
	};
	
	ShowBorderWidth = function () {
	    var ShowBorderStatus = cfc.ShowBorder();
	    document.getElementById("showBorderValue").value = "Show Border: " + ShowBorderStatus;
	    location.reload();
	};
	
	AddNextActivityWeek = function () {
		try
        {

		    if (document.getElementById("NextPeriodEndingWithThisDate").value == "") {
		        document.getElementById("NextPeriodEndingWithThisDate").style.borderColor = "red";
		        alert("The Start With This Date: is required.");
		        return false;
		    }
		
		    var TheConfirm = confirm("Are you sure you want to add Next New Week of Activities?");
		    if (TheConfirm) {
		        var DeleteAllActivityDates = cfc.AddNextActivityWeek(document.getElementById("NextPeriodEndingWithThisDate").value);
		        //$("#ActivityDateLogList").load(location.href + " #ActivityDateLogList");
		        location.reload();
		    }        	
        }
        catch(e)
        {
        	alert(e.message)
        }

	};
	
	ChangeDataSource = function () {
	    var ChangeDataSourceStatus = cfc.ChangeDataSource();
	    document.getElementById("ChangeDataSourceStatus").value = "Change Data Source: " + ChangeDataSourceStatus;
	    document.getElementById("CurrentDataSourceMenu").innerHTML = "Change Data Source: " + ChangeDataSourceStatus;
	    location.reload();
	};
			
	AddNextSetAccomplishmentMonth = function () {
		var TheConfirm = confirm('Are you sure you want to add new set of Accomplishment Month?');
		if(TheConfirm)
		{
			var ChangeDataSourceStatus = cfc.AddNextSetAccomplishmentMonth();
			$("#AdminPage").load(location.href + " #AdminPage");				
		}
	}						

	DeleteActivityDates=function()
	{
		var TheConfirm = confirm('Are you sure you want to delete ALL Activity Dates?');
		if(TheConfirm)
		{
			var cfc = new ActivityLogCFC();
			cfc.setHTTPMethod("POST");
			var DeleteAllActivityDates = cfc.DeleteActivityDates();
			alert(DeleteAllActivityDates);
			//$("#ActivityDateLogList").load(location.href + " #ActivityDateLogList");		
			//ColdFusion.navigate('ActivityDateItem.cfm?PeriodEnding='+ChangePeriodEnding, 'ActivityDateContain');
			location.reload();
		}
	}

</script>

<cfset session.showCFDUMP = 'false'>
<cfset session.BORDERWIDTH  = '0px'>
<table class="admin">
	<tr>
		<th>Description</th>
		<th>Value</th>
		<th>Action</th>
	</tr>
	<tr>
		<td>To SHOW/HIDE BORDER</td>
		<td><cfoutput>#session.showCFDUMP#</cfoutput></td>
		<td>
			<input id="showBorderValue" type="button" value=" Show Border: <cfoutput>#session.showCFDUMP#</cfoutput>" onclick="ShowBorderWidth()" class="AdminButton"></input>
		</td>
	</tr>
	<tr>
		<td>To SHOW/HIDE the CFDUMP</td>
		<td><cfoutput>#session.borderWidth#</cfoutput></td>
		<td>
			<input id="showcfdumpValue" type="button" value=" Show CFDUMP: <cfoutput>#session.showCFDUMP#</cfoutput>" onclick="ShowCFDUMP()" class="AdminButton"></input>
		</td>
	</tr>

	<tr>
		<td>SHOW/HIDE SOURCE FILE NAME</td>
		<td><cfoutput>#application.dumpSrcFilenames#</cfoutput></td>
		<td>
			<input id="DisplaySourceFileStatus" type="button" value=" Display Source File:<cfoutput>#application.dumpSrcFilenames#</cfoutput>" onclick="TurnApplicationDumpSrcFilenamesStatus()" class="AdminButton"></input>
		</td>
	</tr>

	<tr>
		<td>Start With This Date: <br><input id="NextPeriodEndingWithThisDate" type="date"></td>
		<td></td>
		<td>
			<input type="button" value=" Add New Week of Activities " onclick="AddNextActivityWeek()" title="Add New Activity Date" class="AdminButton"></input>
		</td>
	</tr>
	
	<tr>
		<td><!---Start With This Date: <br><input id="NewSetAccomplishmentMonth" type="date">---></td>
		<td></td>
		<td>
			<input type="button" value=" Add Next 12 Months Accomplishment " onclick="AddNextSetAccomplishmentMonth()" title="Add New Set Accomplishment Month" class="AdminButton"></input>
		</td>
	</tr>
	
	<cfif application.Environment EQ 'localhost'>
		<tr>
			<td>Delete entire Database</td>
			<td></td>
			<td>
				<input type="button" value=" Delete All Activity Dates " onclick="DeleteActivityDates()" class="DeleteAllActivityDateButton"></input>
			</td>
		</tr>
	</cfif>

<!---	<tr>
		<td>Change Data Source Between Production and Test</td>
		<td><cfoutput>#application.PhamDataSource#</cfoutput></td>
		<td>
			<input id="ChangeDataSourceStatus" type="button" value=" Change Data Source: <cfoutput>#application.PhamDataSource#</cfoutput>" onclick="ChangeDataSource()" class="AdminButton"></input>
		</td>
	</tr>	--->												
</table>
<cfif findNoCase(cgi.SERVER_NAME,'localhost')>
	session.message = <cfdump var="#session.message#">
	<div id="AdminPage">		
	<cfquery name="qGetAcomplishmentMonth" datasource="#application.PhamDataSource#">
		SELECT * FROM accomplishmentmonth
	</cfquery>
	
	<cfquery name="qGetActivityLog" datasource="#application.PhamDataSource#">
		SELECT 		DailyActivityID_pk, ActivityDate, PeriodEnding
		FROM		activitylog
		ORDER BY 	ActivityDate
	</cfquery> 
	<table>
		<tr style="vertical-align:top">
			<td>
				<cfdump var="#qGetAcomplishmentMonth#" label="accomplishmentmonth" format="html" metainfo="true" >
			</td>
			<td>
				<cfdump var="#qGetActivityLog#" label="Table ActivityLog" format="html" output="browser" >	
			</td>
		</tr>
	</table>
	</div>		
</cfif>

