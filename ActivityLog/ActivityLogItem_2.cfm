
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfparam name="url.DailyActivityId"  default="Hide">
<style>
	table.ActivityLogItem
	{
		width: 100%;
		border-collapse:collapse;
		border: 0px solid red;
	}

	table.ActivityLogItem td
	{
		font-size:12px
	}

</style>

<script>

	var cfc = new ActivityLogCFC();
	cfc.setHTTPMethod("POST");

	DeleteThisActivity=function(ActivityLogItemID_pk, DailyActivityId)
	{
		try
        {
			var TheConfirm = confirm('Are you sure you want to delete this task?');
			if(TheConfirm)
			{
				var jsDeleteThisActivity = cfc.DeleteThisActivity(ActivityLogItemID_pk);
				//$("#ActivityLogList").load(location.href + " #ActivityLogList");
				ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
			}
        }
        catch(e)
        {
        	alert(error.message);
        }
	}

	EditThisActivity = function(ActivityLogItemID_pk, DailyActivityId)
	{
		//ColdFusion.navigate('gallery_displayThisPicture.cfm?pictureId='+pictureId, 'pictureDiv');
		//ColdFusion.Window.create('new_guest_window', 'New Guest', 'guest_new.cfm' , {height:220,width:450, modal:true, closable:true,  draggable:true, resizable:true, center:true ,initshow:true});
		var config = new Object();
		config.width = 750;
		config.height =250;
		config.modal = true;
		config.closable= false;
		config.draggable= true;
		config.resizable= true;
		config.center= true;
		config.initshow= true;
		try
		{
			ColdFusion.Window.create('edit_task_window', '', 'ActivityLog/ActivityLogItem_EditTask.cfm?ActivityLogItemID_pk='+ActivityLogItemID_pk , config);
		}
		catch(error)
		{
			alert(error.message);
		}
	}


	EditThisActivity_NEW=function(ActivityLogItemID_pk, DailyActivityId)
	{
		var errorMessage = '';
	    $("#ActivityDialog").dialog({
            modal: true,
            height: 300,
            width: 800,
            show: 'slide',//scale, fold, slide, fade,explode, drop, bounce,blind
            cache: false,
            title: 'Edit This Activity',
            open: function ()
            {
               $(this).load('ActivityLog/ActivityLogItem_EditTask.cfm?ActivityLogItemID_pk='+ActivityLogItemID_pk);
            },

 			buttons:
			[
			    {
			        id : "UpdateButton",
			        text: "Update",
			        cache: false,
			        click: function()
			        {

						var DailyActivityId = $('#DailyActivityId').val();
						var TaskNumber = $('#TaskNumber').val();
						var WorkPerformed = $('#WorkPerformed').val();
						var Hours = $('#Hours').val();
						if(TaskNumber == '' || WorkPerformed == '' || Hours == '')
						{
							$('#requiredMessage').css("color", "transparent");
							setTimeout(function(){ $('#requiredMessage').css("color", "red")}, 400);
							return false;
						}
						else
						{
							var cfc = new ActivityLogCFC();
							cfc.setHTTPMethod("POST");
							var jsEditThisActivity = cfc.EditThisActivity(ActivityLogItemID_pk, TaskNumber, WorkPerformed, Hours);
							//$("#ActivityLogList").load(location.href + " #ActivityLogList");
							ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
						}

						$(this).dialog('close');
						//$(this).dialog('destroy').remove();

			       	}
			    },

			    {
			    	//Cancel Button
			        text: "Cancel",
			        id: "CancelButton",
			        cache: false,
			        click: function()
			        {
						//$(this).dialog('destroy').remove();
						$(this).dialog('close');
			        }
			    }
			 ]
	    });
	}

	isDecimalNumber=function(sender, evt)
	{
		try
		{
			var txt = sender.value;
			var dotcontainer = txt.split('.');
			var charCode = (evt.which) ? evt.which : event.keyCode;
			var len = sender.value.length;
			var index = sender.value.indexOf('.');

			if (!(dotcontainer.length == 1 && charCode == 46) && charCode > 31 && (charCode < 48 || charCode > 57))
			{
				return false;
			}
		}

		catch(error)
		{
			alert('error message function isDecimalNumber: ' + error.message)
		}

		return true;
	}

	roundItToTwo=function(id)
	{
		try
		{
			var theValue= Number(document.getElementById(id).value).toFixed(2);
			document.getElementById(id).value = theValue;
		}

		catch(error)
		{
			alert('error message function roundItToTwo: ' + error.message)
		}
	}

	onMouse=function(rowId, orignalBackgroundColor, mouseStatus)
	{
		if(mouseStatus == 'over')
		{
			document.getElementById(rowId).style.background= 'lightBlue';
		}
		else
		{
			document.getElementById(rowId).style.background= orignalBackgroundColor;
		}
	}

	OpenNewTaksWindow=function()
	{
		//ColdFusion.navigate('gallery_displayThisPicture.cfm?pictureId='+pictureId, 'pictureDiv');
		//ColdFusion.Window.create('new_guest_window', 'New Guest', 'guest_new.cfm' , {height:220,width:450, modal:true, closable:true,  draggable:true, resizable:true, center:true ,initshow:true});
		var config = new Object();
		config.width = 750;
		config.height = 250;
		config.modal = true;
		config.closable= true;
		config.draggable= true;
		config.resizable= true;
		config.center= true;
		config.initshow= true;
		try
		{
			ColdFusion.Window.create('new_task_window', '', 'ActivityLog/ActivityLogItem_NewTask.cfm' , config);
		}
		catch(error)
		{
			alert(error.message);
		}
	}

	OpenNewTaksWindow_NEW=function()
	{
		var errorMessage = '';
	    $("#ActivityDialog").dialog({
            modal: true,
            height: 300,
            width: 800,
            show: 'slide',//scale, fold, slide, fade,explode, drop, bounce,blind
            cache: false,
            title: 'Add New Activity',
            open: function ()
            {
               $(this).load('ActivityLog/ActivityLogItem_NewTask.cfm');
            },

 			buttons:
			[
			    {
			        id : "SubmitButton",
			        text: "Submit",
			        cache: false,
			        click: function()
			        {
						var DailyActivityId = $('#DailyActivityId').val();
						var TaskNumber = $('#TaskNumber').val();
						var WorkPerformed = $('#WorkPerformed').val();
						var Hours = $('#Hours').val();
						if(TaskNumber == '' || WorkPerformed == '' || Hours == '')
						{
							$('#requiredMessage').css("color", "transparent");
							setTimeout(function(){ $('#requiredMessage').css("color", "red")}, 400);
							return false;
						}
						else
						{
							var cfc = new ActivityLogCFC();
							cfc.setHTTPMethod("POST");
							var jsAddNewTask = cfc.AddNewTask(DailyActivityId, TaskNumber, WorkPerformed, Hours);
							//$("#ActivityLogList").load(location.href + " #ActivityLogList");
							//$(this).dialog('destroy').remove();
							$(this).dialog('close');
							ColdFusion.navigate('ActivityLog/ActivityLogItem_2.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
						}

						$(this).dialog('close');
						//$(this).dialog('destroy').remove();

			       	}
			    },

			    {
			    	//Cancel Button
			        text: "Cancel",
			        id: "CancelButton",
			        cache: false,
			        click: function()
			        {
						//$(this).dialog('destroy').remove();
						$(this).dialog('close');
			        }
			    }
			 ]
	    });
	}

</script>
<style>
    table.ActivityLogItem {
        width: 100%;
        border: 1px solid gray;
        border-collapse: collapse;
    }

    table.ActivityLogItem td {
        border: 1px solid gray;
        padding:5px;
    }

    table.ActivityLogItem th {
        border: 1px solid gray;
        padding:5px;
        font-weight: bold;
        text-align: center;
        background-color: lightGray;
    }

    span.edit{
    	color: green;
    }

    span.delete{
    	color: red;
    }

    span.edit:hover,
    span.delete:hover
    {
    	text-decoration:underline;
    	cursor: pointer;
    }
</style>

<div style="width:1000px; border:0px solid gray; font-size:12px;margin-left:5px; padding:10px; height:500px">
	<cfif url.DailyActivityId EQ 'Hide'>
		<cfabort>
	</cfif>
	<cfinvoke component="ActivityLog" method="GetActivityDate" DailyActivityId = "#url.DailyActivityId#" returnvariable="qGetActivityDate">

	<cfinvoke component="ActivityLog" method="GetActivityLogItem" DailyActivityId = "#url.DailyActivityId#" returnvariable="qGetActivityLogItem">
	<cfinvoke component="ActivityLog" method="getTaskOrderNumber"  returnvariable="qGetTaskOrderNumber">

	<cfset variables.TaskOrderId_pk = valueList(qGetTaskOrderNumber.TaskOrderID_pk)>
	<cfset variables.TaskOrderNumber = valueList(qGetTaskOrderNumber.TaskOrderNumber)>

	<cfif url.DailyActivityId EQ 0>
		<div style="margin-top: 25px; color: black">
		&larr; Please select the Activity Date
		<cfabort>
		</div>
	</cfif>
	<div style="font-weight: bold; margin-bottom:10px">
		Daily Activity on <cfoutput>#DateFormat(qGetActivityDate.activityDate, 'DDDD mmm dd, yyyy')#</cfoutput>
	</div>

	<div style="margin-bottom:10px">
		<input value="<cfoutput>#DailyActivityId#</cfoutput>" id="DailyActivityId" type="hidden"></input>
		<!---<input type="button" value=" New Activity " onclick="OpenNewTaksWindow(<cfoutput>#DailyActivityId#</cfoutput>,<cfoutput>'#variables.TaskOrderId_pk#'</cfoutput>,<cfoutput>'#variables.TaskOrderNumber#'</cfoutput>)" title="Add New Activity" class="button" id="AddNewActivityButton">--->
		<input type="button" value="New Activity" onclick="OpenNewTaksWindow_NEW(<cfoutput>#DailyActivityId#</cfoutput>,<cfoutput>'#variables.TaskOrderId_pk#'</cfoutput>,<cfoutput>'#variables.TaskOrderNumber#'</cfoutput>)" title="Add New Activity" class="button" id="AddNewActivityButton">
	</div>

	<div id="ActivityLogList">
		<form>
		<table class="ActivityLogItem" id="ActivityLogItemTable">
			<tr>
				<th style="width:10%">Task Number</th>
				<th style="width:10%">Sub Task</th>
				<th style="width:50%">Work Performed</th>
				<th style="width:10%">Hours (0.1 - 8)</th>
				<th style="width:10%" colspan="2">&nbsp;</th>
			</tr>
			<cfoutput query="qGetActivityLogItem">
				<cfinvoke component="ActivityLog" method="GetThisTask" ActivityLogItemID_pk="#ActivityLogItemID_pk#" returnvariable="qGetThisTask">
				<cfif currentRow MOD 2 EQ 0>
					<cfset bgColor = '##eceaf2'>
				<cfelse>
					<cfset bgColor = 'white'>
				</cfif>

				<tr id="trRemark_#currentRow#"  style="background-color:#bgColor#" onmouseover="onMouse(this.id,'#bgColor#', 'over')"  onmouseout="onMouse(this.id,'#bgColor#', 'out')">
					<td>
						#qGetActivityLogItem.TASKORDERNUMBER#
<!---						<br>
						#DailyActivityId# [DailyActivityId]
						<br>
						#ActivityLogItemID_pk# [ActivityLogItemID_pk]--->
					</td>
					<td id="TaskOrderDescription_#ActivityLogItemID_pk#">#TaskOrderDescription#</td>
					<td>#WORKPERFORMED#</td>
					<td>#Hours#</td>
<!---					<td style="text-align: center">
						<span id="Edit_#ActivityLogItemID_pk#" class="edit" onclick="EditThisActivity(#ActivityLogItemID_pk#, #DailyActivityId#)" style="display: block">Edit</span>
					</td>--->
					<td style="text-align: center">
						<span id="Edit_#ActivityLogItemID_pk#" class="edit" onclick="EditThisActivity_NEW(#ActivityLogItemID_pk#, #DailyActivityId#)" style="display: block">Edit</span>
						<!---<br>
						<span id="Edit_#ActivityLogItemID_pk#" class="edit" onclick="EditThisActivity(#ActivityLogItemID_pk#, #DailyActivityId#)" style="display: block">Edit OLD</span>--->
					</td>

					<td style="text-align: center">
						<span class="delete" onclick="DeleteThisActivity(#ActivityLogItemID_pk#, #DailyActivityId#)">Delete</span>
					</td>
				</tr>
			</cfoutput>
		</table>
		</form>
	</div>
</div>
<cfset count = 1>





