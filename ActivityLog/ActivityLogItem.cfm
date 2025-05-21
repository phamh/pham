<cfinclude template="../CheckAccess.cfm" >
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

	var preRow = '';
	var preRowBgColor = 'white';
	var selectedMenuIdColor = '#add8e6';	
	var newFieldColor = 'oldlace';
	var exitMessagePage = "Your changes will be lost if you click on [Leave this page].\n \nClick on [Stay on this page] to stay on the current page.";
	var theBrowser = navigator.appName;	
	var remarkWidth = 110;

	var cfc = new ActivityLogCFC();
	cfc.setHTTPMethod("POST");
	
	DislayThisDailyActivity=function(DailyActivityId)
	{
		ColdFusion.navigate('ActivityLog/ActivityLogItem.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
		//$("#ActivityLogItem").load(location.href + " #ActivityLogItem");
	}
	
	DeleteThisActivity=function(ActivityLogItemID_pk, DailyActivityId)
	{
		try
        {
			var TheConfirm = confirm('Are you sure you want to delete this task?');
			if(TheConfirm)
			{
				var jsDeleteThisActivity = cfc.DeleteThisActivity(ActivityLogItemID_pk);
				//$("#ActivityLogList").load(location.href + " #ActivityLogList");
				ColdFusion.navigate('ActivityLog/ActivityLogItem.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');	
			}        	
        }
        catch(e)
        {
        	alert(error.message);
        }
	}
	

	EditThisActivity=function(ActivityLogItemID_pk, DailyActivityId)
	{
		//alert(ActivityLogItemID_pk);
		try
		{
			//alert(document.getElementById('WorkPerformed_'+ActivityLogItemID_pk));
			document.getElementById('WorkPerformed_'+ActivityLogItemID_pk).disabled = false;
			document.getElementById('TaskOrderNumber_'+ActivityLogItemID_pk).disabled = false;
			document.getElementById('Hours_'+ActivityLogItemID_pk).disabled = false;
			document.getElementById('Save_'+ActivityLogItemID_pk).style.display = 'block';
			document.getElementById('Reset_'+ActivityLogItemID_pk).style.display = 'block';
			
			document.getElementById('AddNewActivityButton').style.display = 'none';			
			document.getElementById('Edit_'+ActivityLogItemID_pk).style.display = 'none';
			
			
			//ColdFusion.Window.create('edit_task_window', '', 'ActivityLog/ActivityLogItem_EditTask.cfm?ActivityLogItemID_pk='+ActivityLogItemID_pk , config);	
		}
		catch(error)
		{
			//alert(error.message);
		}
		return true;
	}

	SubmitEditActivity_NEW=function(ActivityLogItemID_pk,DailyActivityId)
	{
		try
	    {
			
			var TempTaskNumber = $('#TaskOrderNumber_'+ActivityLogItemID_pk).val();
			var WorkPerformed = $('#WorkPerformed_'+ActivityLogItemID_pk).val();
			var Hours = $('#Hours_'+ActivityLogItemID_pk).val();
			var myArray = TempTaskNumber.split("_");
		
			var TaskNumber = myArray[0];
			var TaskOrderDescription = myArray[1];
			document.getElementById('TaskOrderDescription_'+ActivityLogItemID_pk).innerHTML = TaskOrderDescription;
			
			if(TaskNumber == '' || WorkPerformed == '' || Hours == '')
			{
				$('#requiredMessage').css("color", "transparent");
				setTimeout(function(){ $('#requiredMessage').css("color", "red")}, 400);
			}
				else
			{
				var jsEditThisActivity = cfc.EditThisActivity(ActivityLogItemID_pk, TaskNumber, WorkPerformed, Hours);
				//$("#ActivityLogList").load(location.href + " #ActivityLogList");
				//ColdFusion.navigate('ActivityLog/ActivityLogItem.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
				//CloseEditActivityWindow();
			}
		
	
			document.getElementById('WorkPerformed_'+ActivityLogItemID_pk).disabled = true;
			document.getElementById('TaskOrderNumber_'+ActivityLogItemID_pk).disabled = true;
			document.getElementById('Hours_'+ActivityLogItemID_pk).disabled = true;
			
			document.getElementById('Save_'+ActivityLogItemID_pk).style.display = 'none';
			/*document.getElementById('Reset_'+ActivityLogItemID_pk).style.display = 'none';*/
			document.getElementById('Edit_'+ActivityLogItemID_pk).style.display = 'block';
			document.getElementById('AddNewActivityButton').style.display = '';
			
						
	    }
	    catch(e)
	    {
	    	alert('error= ' + e);
	    }
	}			

	ResetEditActivity_NEW=function(ActivityLogItemID_pk,DailyActivityId)
	{
		try
	    {
			//alert(ActivityLogItemID_pk);
/*			var TempTaskNumber = $('#TaskOrderNumber_'+ActivityLogItemID_pk).val();
			var WorkPerformed = $('#WorkPerformed_'+ActivityLogItemID_pk).val();
			var Hours = $('#Hours_'+ActivityLogItemID_pk).val();
			var myArray = TempTaskNumber.split("_");
		
			var TaskNumber = myArray[0];
			var TaskOrderDescription = myArray[1];
			document.getElementById('TaskOrderDescription_'+ActivityLogItemID_pk).innerHTML = TaskOrderDescription;
			
			if(TaskNumber == '' || WorkPerformed == '' || Hours == '')
			{
				$('#requiredMessage').css("color", "transparent");
				setTimeout(function(){ $('#requiredMessage').css("color", "red")}, 400);
			}
				else
			{
				var jsEditThisActivity = cfc.EditThisActivity(ActivityLogItemID_pk, TaskNumber, WorkPerformed, Hours);
				//$("#ActivityLogList").load(location.href + " #ActivityLogList");
				//ColdFusion.navigate('ActivityLog/ActivityLogItem.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
				//CloseEditActivityWindow();
			}
		*/
	 
			document.getElementById('WorkPerformed_'+ActivityLogItemID_pk).disabled = true;
			document.getElementById('TaskOrderNumber_'+ActivityLogItemID_pk).disabled = true;
			document.getElementById('Hours_'+ActivityLogItemID_pk).disabled = true;
			
			document.getElementById('Save_'+ActivityLogItemID_pk).style.display = 'none';
			document.getElementById('Reset_'+ActivityLogItemID_pk).style.display = 'none';
			document.getElementById('Edit_'+ActivityLogItemID_pk).style.display = 'block';
			
						
	    }
	    catch(e)
	    {
	    	alert('error= ' + e);
	    }
	}	
			
	AddNewActivity=function(DailyActivityId, TaskOrderId_pk, TaskOrderNumber)
	{
	try
		{
			var TaskOrderIdArray = TaskOrderId_pk.split(',');
			var TaskOrderNumberArray = TaskOrderNumber.split(',');
			//document.getElementById('AddNewActivityButton').disabled = true;
			
			document.getElementById('AddNewActivityButton').style.display = 'none';
			
			
			var rowID = 1;
			theTable = document.getElementById('ActivityLogItemTable');

			//INSERT NEW ROW
			var newRow = theTable.insertRow();
			newRow.id = 'trRemark_' + rowID;			
			$('#newRow.id').css("background-color", "red");
			//newRow.style.backgroundColor = newFieldColor;
			
			/* Add TaskNumber */
			var td_TaskNumber = newRow.insertCell();
			var TaskNumberSelect = document.createElement('select');
			TaskNumberSelect.style.border = '1px gray dotted';
			TaskNumberSelect.name = TaskNumberSelect.id = 'input_NewTaskNumber' + rowID;
			TaskNumberSelect.style.fontSize = '12px';
			//TaskNumberSelect.style.fontFamily = 'Arial';		
			TaskNumberSelect.style.backgroundColor = newFieldColor;
			
			var i = 0;
			while(i<TaskOrderIdArray.length)
			{
				var myOption = document.createElement('option');
				myOption.value = TaskOrderIdArray[i];
				myOption.text = TaskOrderNumberArray[i];
				TaskNumberSelect.options.add(myOption);
				i++;
			}
			td_TaskNumber.appendChild(TaskNumberSelect);

			/* Add Dummy Sub Task */
			var td_SubTask = newRow.insertCell();		

			/* Add Work Performed */
			var td_WorkPerformed = newRow.insertCell();
			var inputWorkPerformed = document.createElement('input');
			inputWorkPerformed.style.width = '100%';
			inputWorkPerformed.style.border = '1px gray dotted';
			inputWorkPerformed.name = inputWorkPerformed.id = 'input_NewWorkPerformed' + rowID;
			inputWorkPerformed.style.backgroundColor = newFieldColor;		
			inputWorkPerformed.value = inputWorkPerformed.id;
			td_WorkPerformed.appendChild(inputWorkPerformed);

			/* Add Hours */
			var td_Hours = newRow.insertCell();
			var inputHours = document.createElement('input');
			inputHours.style.width = '100%';
			inputHours.style.border = '1px gray dotted';
			inputHours.name = inputHours.id = 'input_NewHours' + rowID;
			inputHours.style.backgroundColor = newFieldColor;		
			inputHours.value = 0;
			inputHours.onblur = function(){return roundItToTwo(this.id)};
			inputHours.onkeypress = function(){return isDecimalNumber(this,event)};
			td_Hours.appendChild(inputHours);

			//Add empty TD
			var td_save = newRow.insertCell();	
			td_save.align = 'center';
			td_save.style.width = '200px'
			td_save.style.borderTop = '1px solid black';
			td_save.style.paddingTop = td_save.style.paddingBottom =  '5px ';
			
			var saveButton = document.createElement('span');	
			saveButton.innerHTML = 'Save';
			saveButton.style.color = 'green';
			saveButton.style.cursor = 'pointer';
			//delButton.className = 'smallerInputText';
			//delButton.style.fontWeight = 'bold';
			saveButton.onclick = function(){SaveNewActivity(newRow.id,DailyActivityId)};
			td_save.appendChild(saveButton);			
	
			//Add Delete Button
			var td_delete = newRow.insertCell();	
			td_delete.align = 'center';
			td_delete.style.width = '200px'
			td_delete.style.borderTop = '1px solid black';
			td_delete.style.paddingTop = td_delete.style.paddingBottom =  '5px ';
			
			var delButton = document.createElement('span');	
			delButton.innerHTML = 'Cancel';
			delButton.style.color = 'green';
			delButton.style.cursor = 'pointer';
			//delButton.className = 'smallerInputText';
			//delButton.style.fontWeight = 'bold';
			delButton.onclick = function(){cancelNewRow(newRow.id)};
			td_delete.appendChild(delButton);							
		}
		
		catch(error)
		{
			alert('error on function AddNewActivity: '+ error.message)
		}	
	
		//ColdFusion.navigate('AccomplishmentDetail.cfm?DailyActivityId=2', 'AccomplishmentItemContain')
	}
	
	SaveNewActivity = function(rowID,DailyActivityId)
	{
		
		var TaskNumber = document.getElementById('input_NewTaskNumber1').value;
		var WorkPerformed = document.getElementById('input_NewWorkPerformed1').value;
		var Hours = document.getElementById('input_NewHours1').value;

		var jsAddNewTask = cfc.AddNewTask(DailyActivityId, TaskNumber, WorkPerformed, Hours);
					
		ColdFusion.navigate('ActivityLog/ActivityLogItem.cfm?DailyActivityId='+DailyActivityId, 'ActivityLogItemContain');
		document.getElementById('AddNewActivityButton').disabled = false;
		document.getElementById('AddNewActivityButton').style.display = '';
		//$("#ActivityLogList_2").load(location.href + " #ActivityLogList_2");
	}

	deleteRow=function(rowID)
	{	
		//alert(rowID);
		document.getElementById(rowID).style.border ='2px red solid';
		//document.getElementById(rowID).style.border = '2px red solid';
		var confirmed = window.confirm("Are you sure you wish to delete this row?");
		if (confirmed == false)
		{	
			document.getElementById(rowID).style.border ='';
			return false;
		}
		else
		{
			document.getElementById(rowID).parentNode.deleteRow(document.getElementById(rowID).sectionRowIndex);	
			document.getElementById('AddNewActivityButton').disabled = false;
			document.getElementById('AddNewActivityButton').style.display = '';
		}
	}

	cancelNewRow=function(rowID)
	{	

		document.getElementById(rowID).parentNode.deleteRow(document.getElementById(rowID).sectionRowIndex);	
		document.getElementById('AddNewActivityButton').disabled = false;
		document.getElementById('AddNewActivityButton').style.display = '';

	}

	cancelEditRow=function(rowID)
	{	
		//alert(rowID);
		//document.getElementById(rowID).parentNode.deleteRow(document.getElementById(rowID).sectionRowIndex);	
		document.getElementById('AddNewActivityButton').disabled = false;
		document.getElementById('AddNewActivityButton').style.display = '';

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
</script>

<div style="margin-top:10px;color: red;text-align: center" id="requiredMessage">All fields are required</div>
	
			
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

<div style="width:1000px; border:1px solid gray; font-size:12px;margin-left:5px; padding:10px; height:500px">
	<cfif url.DailyActivityId EQ 'Hide'>
		<cfabort>
	</cfif>
	<cfinvoke component="ActivityLog" method="GetActivityDate" DailyActivityId = "#url.DailyActivityId#" returnvariable="qGetActivityDate">
	
	<cfinvoke component="ActivityLog" method="GetActivityLogItem" DailyActivityId = "#url.DailyActivityId#" returnvariable="qGetActivityLogItem">
	<cfinvoke component="ActivityLog" method="getTaskOrderNumber"  returnvariable="qGetTaskOrderNumber">
	
	<cfset variables.TaskOrderId_pk = valueList(qGetTaskOrderNumber.TaskOrderID_pk)>
	<cfset variables.TaskOrderNumber = valueList(qGetTaskOrderNumber.TaskOrderNumber)>

	<cfif url.DailyActivityId EQ 0>
		&larr; Please select the Activity Date
		<cfabort>
	</cfif>
	
	<div style="font-weight: bold; margin-bottom:10px">
		Daily Activity Log on <cfoutput>#DateFormat(qGetActivityDate.activityDate, 'long')#</cfoutput>
	</div>
	
	<div style="margin-bottom:10px">
		<input value="<cfoutput>#DailyActivityId#</cfoutput>" id="DailyActivityId" type="hidden"></input>
		<input type="button" value=" New Activity " onclick="AddNewActivity(<cfoutput>#DailyActivityId#</cfoutput>,<cfoutput>'#variables.TaskOrderId_pk#'</cfoutput>,<cfoutput>'#variables.TaskOrderNumber#'</cfoutput>)" title="Add New Activity" class="AddNewButton" id="AddNewActivityButton">		
		<input type="button" class="AddNewButton" data-toggle="modal" data-target="#myModal" value ="New Activity" onclick="alert(1)"></input>
	</div>
	
	<div id="ActivityLogList">
		<form>
		<table class="ActivityLogItem" id="ActivityLogItemTable">
			<tr>
<!---				<th>Daily Activity Log ID</th>
				<th>Activity Log Item ID</th>--->
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
<!---					<td>#DailyActivityId#</td>
					<td>#ActivityLogItemID_pk#</td>--->
					<td><!---#ActivityLogItemID_pk#--->
						<select id="TaskOrderNumber_#ActivityLogItemID_pk#" disabled="disabled">
							<cfloop query="qGetTaskOrderNumber">
								<option value="#TASKORDERID_PK#_#TASKORDERDESCRIPTION#" <cfif qGetTaskOrderNumber.TASKORDERID_PK EQ qGetThisTask.TASKORDERID_FK> selected="selected"</cfif>>
									#TASKORDERNUMBER#<!--- -  #TASKORDERDESCRIPTION#--->
								</option>
							</cfloop>
						</select>			
					</td>
					<td id="TaskOrderDescription_#ActivityLogItemID_pk#">#TaskOrderDescription#</td>
					<td>
						<input type="text" value="#WORKPERFORMED#"  style="width:100%" disabled="disabled"  id="WorkPerformed_#ActivityLogItemID_pk#"></input>

					</td>
					<td>
						<input type="text" value="#Hours#" style="width:100%" disabled="disabled" id="Hours_#ActivityLogItemID_pk#" onkeypress="return isDecimalNumber(this,event)" onblur="roundItToTwo(this.id)"></input>
					</td>
					<td style="text-align: center">
						<span id="Edit_#ActivityLogItemID_pk#" class="edit" onclick="EditThisActivity(#ActivityLogItemID_pk#, #DailyActivityId#)" style="display: block">Edit</span>
						<input id="Reset_#ActivityLogItemID_pk#" type="reset" style="display: none; border:0px solid gray; color: green; background-color: transparent" value="Cancel" onclick="cancelEditRow()"></input>
						<span id="Save_#ActivityLogItemID_pk#"class="edit" onclick="SubmitEditActivity_NEW(#ActivityLogItemID_pk#, #DailyActivityId#)" style="display: none">Save</span>
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

<script>
$('.openBtn').on('click',function(){
    $('.modal-body').load('test.cfm',function(){
        $('#myModal').modal({show:true});
    });
});
</script>

<input type="button" class="AddNewButton" data-toggle="modal" data-target="#myModal" value ="New Activity" onclick="alert(1)"></input>

<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-success openBtn" id="openBtn">Open Modal</button>

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Modal with Dynamic Content</h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>