<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfinvoke component="ActivityLog" method="getTaskOrderNumber"  returnvariable="qGetTaskOrderNumber">

<script>

CloseNewActivityWindow=function()
{
	//ColdFusion.Window.hide('new_activity_window');
	ColdFusion.Window.destroy('new_task_window');
}

SubmitNewActivity=function()
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
			var jsAddNewTask = cfc.AddNewTask(DailyActivityId, TaskNumber, WorkPerformed, Hours);
			//$("#ActivityLogList").load(location.href + " #ActivityLogList");
			ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
			CloseNewActivityWindow();
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
<div style="border:0px solid red; width: 100%; padding:10px;">
	<div style="text-align:center; font-weight:bold; font-size:20px; margin-bottom:10px">New Activity</div>
	<table class="NewActivityTable">
		<tr>
			<th style="border: 0px solid red">Task Number: </th>
			<td style="border: 0px solid red">
				<select id="TaskNumber">
					<cfoutput query="qGetTaskOrderNumber">
						<option value="#TASKORDERID_PK#">#TASKORDERNUMBER# -  #TASKORDERDESCRIPTION#</option>
					</cfoutput>
				</select>
			</td>
		</tr>
		<tr>
			<th>Hours:</th>
			<td><input type="text" id="Hours"></td>
		</tr>
		<tr>
			<th>Work Performed:</th>
			<td>
				<input type="text" id="WorkPerformed"  size="70" maxlength="1000" >

			</td>

		</tr>
<!---		<tr>
			<th>&nbsp;</th>
			<td style="border: 0px solid red;">
				<span id="requiredMessage" style="color: red;">All fields are required</span>
			</td>
		</tr>--->

		<tr>
			<th>&nbsp;</th>
			<td style="border: 0px solid red;">
				<div style="text-align: left; margin-top: 5px">
<!---					<input type="submit" value="  Submit  " onclick="SubmitNewActivity()" class="AddNewButton" id="SubmitButtonID">
					<input type="button" value="  Cancel  " onclick="CloseNewActivityWindow()" class="AddNewButton">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--->
					<span id="requiredMessage" style="color: red;">All fields are required</span>
				</div>
			</td>
		</tr>


	</table>

</div>