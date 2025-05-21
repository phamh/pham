<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<!---<cfset session.borderWidth = '0px'>--->
<cfinvoke component="ActivityLog" method="getTaskOrderNumber"  returnvariable="qGetTaskOrderNumber">
<script>

CloseEditActivityWindow=function()
{
	//ColdFusion.Window.hide('new_activity_window');
	ColdFusion.Window.destroy('edit_task_window');
}

SubmitEditActivity=function(ActivityLogItemID_pk)
{
	try
    {

		var DailyActivityId = $('#DailyActivityId').val();
		var TaskNumber = $('#TaskNumber').val();
		var WorkPerformed = $('#WorkPerformed').val();
		var Hours = $('#Hours').val();
		if(TaskNumber == '' || WorkPerformed == '' || Hours == '')
		{
			$('#requiredMessage').css("color", "transparent");
			setTimeout(function(){ $('#requiredMessage').css("color", "red")}, 400);

		}
		else
		{
			var cfc = new ActivityLogCFC();
			cfc.setHTTPMethod("POST");
			var jsEditThisActivity = cfc.EditThisActivity(ActivityLogItemID_pk, TaskNumber, WorkPerformed, Hours);
			//$("#ActivityLogList").load(location.href + " #ActivityLogList");
			ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
			CloseEditActivityWindow();
		}
    }
    catch(e)
    {
    	alert('error= ' + e);
    }
}

</script>
<style>
    table.NewActivityTable {
        border-collapse: collapse;
        border: 0px solid green;
        width: 100%;
    }
    table.NewActivityTable th {
        font-weight: bold;
        width: 15%;
        text-align: right;
    }

    table.NewActivityTable td {
        width: 30%;
        margin-bottom: 2px;
        padding: 2px;
    }
</style>
<cfinvoke component="ActivityLog" method="GetThisTask" ActivityLogItemID_pk="#url.ActivityLogItemID_pk#" returnvariable="qGetThisTask">
	<table class="NewActivityTable">
		<tr>
			<th style="border: 0px solid red">Task Number: </th>
			<td style="border: 0px solid red">
				<select id="TaskNumber">
					<cfoutput query="qGetTaskOrderNumber">
						<option value="#TASKORDERID_PK#" <cfif TASKORDERID_PK EQ qGetThisTask.TASKORDERID_FK> selected="selected"</cfif>>#TASKORDERNUMBER# -  #TASKORDERDESCRIPTION#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr>
			<th>Hours:</th>
			<td><input type="text" value="<cfoutput>#qGetThisTask.Hours#</cfoutput>" id="Hours"></td>
		</tr>
		<tr>
			<th>Work Performed:</th>
			<td>
				<input maxlength="1000" type="text" value="<cfoutput>#qGetThisTask.WORKPERFORMED#</cfoutput>" id="WorkPerformed"  size="70" >
			</td>
		</tr>

		<tr>
			<th>&nbsp;</th>
			<td style="border: 0px solid red;">
				<div style="text-align: left; margin-top: 5px">
<!---					<input type="submit" value="   Submit   " onclick="SubmitEditActivity(<cfoutput>#url.ActivityLogItemID_pk#</cfoutput>)" class="AddNewButton" id="SubmitButtonID">
					<input type="button" value="   Cancel   " onclick="CloseEditActivityWindow()" class="AddNewButton">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--->
					<span id="requiredMessage" style="color: red;">All fields are required</span>
				</div>
			</td>
		</tr>
	</table>

<cfquery name="qSearchDupActivityDate"  datasource="#application.PhamDataSource#" >
	SELECT 	*
	FROM 	activitylogitem;
</cfquery>

<cfset totalOrgCodes = qSearchDupActivityDate.recordCount>
<cfset count = 1>
<script>

    $(function() {
       var availableTags = [<cfloop query="qSearchDupActivityDate">
				                  <cfoutput>
				                  "#WORKPERFORMED#"
				                  	<cfif count lt totalOrgCodes>,</cfif>
				                  </cfoutput>
				                  <cfset count = count + 1 />
				              </cfloop>
           					];

           $( "#WorkPerformed" ).autocomplete({
                  source: availableTags
           });
    });

	$("#WorkPerformed").change(function(){
	  //alert(this.value);
	});

</script>