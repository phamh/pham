<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfajaxproxy cfc="ActivityLog" jsclassname="ActivityLogCFC">

<cfparam name="url.AccomplishmentMonthID" default="0">
<cfif url.AccomplishmentMonthID EQ 0>
	&larr; Please select the Accomplishment Month
	<cfabort>
</cfif>
<script>
	var preRow = '';
	var preRowBgColor = 'white';
	var selectedMenuIdColor = '#add8e6';	
	var newFieldColor = 'oldlace';
	var exitMessagePage = "Your changes will be lost if you click on [Leave this page].\n \nClick on [Stay on this page] to stay on the current page.";
	var theBrowser = navigator.appName;	
	var remarkWidth = 110;

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
		}
	}

	AddAccomplishment=function()
	{
	try
		{
			document.getElementById("NumberOfAccomplishments").value++;
			rowID = document.getElementById("NumberOfAccomplishments").value;
			theTable = document.getElementById('AcomplishmentDetailTable');

			//INSERT NEW ROW
			var newRow = theTable.insertRow();
			newRow.id = 'trRemark_' + rowID;			
			$('#newRow.id').css("background-color", "red");
			newRow.style.backgroundColor = newFieldColor;

	
			//Insert New Delete
			var td_delete = newRow.insertCell();	
			td_delete.align = 'center';
			td_delete.style.width = '20px'
			td_delete.style.borderTop = '1px solid black';
			td_delete.style.paddingTop = td_delete.style.paddingBottom =  '5px ';
			
			var delButton = document.createElement('input');	

			//delButton.innerHTML = '[Delete]';
			delButton.type = 'button';
			delButton.value = 'Delete';
			delButton.style.color = 'red';
			delButton.style.cursor = 'pointer';
			delButton.className = 'smallDeleteButton';
			delButton.style.fontWeight = 'normal';
			delButton.onclick = function(){deleteRow(newRow.id)};
			td_delete.appendChild(delButton);

			var td_remark = newRow.insertCell();
			var inputRemark = document.createElement('input');
			inputRemark.style.width = '100%';
			inputRemark.style.border = '1px gray dotted';
			inputRemark.name = inputRemark.id = 'input_Accomplishment' + rowID;
			inputRemark.style.backgroundColor = newFieldColor;		
			inputRemark.value = inputRemark.id;
			td_remark.appendChild(inputRemark);
		}
		
		catch(error)
		{
			alert('error on function AddAccomplishment: '+ error.message)
		}	
	
		//ColdFusion.navigate('AccomplishmentDetail.cfm?DailyActivityId=2', 'AccomplishmentItemContain')
	}
	
	SaveAccomplishment=function(AccomplishmentMonthID)
	{
		try
        {
			var newRemarkArray = new Array();
			var arrayIndex = 0;
			var ErrorMessage = 'no error';
			for(i = 1; i <= (document.getElementById('NumberOfAccomplishments').value); i++)
			{
				if(document.getElementById("trRemark_"+i) == null || document.getElementById("trRemark_"+i)== 'undefined')
				{
					//alert('no');
				}
				else
				{
					if(document.getElementById("input_Accomplishment"+i).value == '')
					{
						document.getElementById("input_Accomplishment"+i).style.border = '2px red solid';
						ErrorMessage = 'All fields are required';
					}
					else
					{
						newRemarkArray[arrayIndex] = document.getElementById("input_Accomplishment"+i).value;			
					}
				}
				arrayIndex++;
			}
			if(ErrorMessage != 'no error')
			{
				alert('All fields are required.');
				return false;
			}   
			var cfc = new ActivityLogCFC();
			cfc.setHTTPMethod("POST");		
			var SaveAccomplishmentStatus = cfc.fSaveAccomplishment(newRemarkArray,AccomplishmentMonthID);

			ShowActionMessageStatus('SaveMessage', 'Accomplishment is updated successfully');
							
			//alert(SaveAccomplishmentStatus)
        }
        catch(e)
        {
        	alert('an error occured on function SaveAccomplishment: '+e)
        }
	}

	ShowActionMessageStatus_OLD = function( documentId,message)
	{
		$('#'+documentId).show();
		$('#'+documentId).html(message);
		setTimeout(function()	{$('#'+documentId).hide();},1000);		
	}
		
</script>	


<style>
     table.ActivityLogItem {
        width: 100%;
        border-collapse: collapse;
        border: 1px solid black;
    }

    table.ActivityLogItem th {
        font-weight: bold;
        border: 1px solid black;
        background-color: lightGrey;
        text-align: center;
        padding: 3px;
    }

    table.ActivityLogItem th,
    table.ActivityLogItem td {
        border: 1px solid black;
        padding: 3px;
        font-family: Arial, Helvetica, sans-serif;
        font-size: 12px;
    }


    input.AddNewButton {
        font-size: 12px;
        color: black;
        padding-left: 10px;
        padding-right: 10px;
        border: 1px solid gray;
        border-radius: 5px;   

    }

    input.smallDeleteButton {
        font-size: 12px;
        color: red;
        padding-left: 10px;
        padding-right: 10px;
        border: 1px solid gray;
        border-radius: 5px;   
    }
 
    input.AddNewButton:hover,
    smallDeleteButton:hover {
        background-color: gray;
    }

            
</style>

<cfinvoke component="ActivityLog" method="fGetThisAcomplishment" AccomplishmentMonthID_fk = "#url.AccomplishmentMonthID#" returnvariable="qGetThisAcomplishment">
<div style="width:1000px; border:0px solid gray; font-size:12px;margin-left:5px; padding:10px; height:500px">
	
	<div style="font-weight: normal; margin:5px">
		<span style="font-weight: bold"><cfoutput>#DateFormat(url.AccomplishmentMonth,  'MMMM YYYY')#</cfoutput>&nbsp;&nbsp;</span>
		<input value="New Accomplishment" type="button" class="button" onclick="AddAccomplishment()"></input>		
		<input value="Save Accomplishment(s)" type="button" class="button"  onclick="SaveAccomplishment(<cfoutput>#url.AccomplishmentMonthID#</cfoutput>)"></input>
		<input value="Export To Excel" type="button" class="button" onclick="window.location.href='ActivityLog/AccomplishmentExcel.cfm?AccomplishmentMonthID_fk=<cfoutput>#qGetThisAcomplishment.AcomplishmentMonthID_fk#</cfoutput>'"></input>	
	</div>
	
	<input type="hidden" value="<cfoutput>#qGetThisAcomplishment.recordCount#</cfoutput>" id="NumberOfAccomplishments" size="5">
	
	<table class="ActivityLogItem" id="AcomplishmentDetailTable">
		<tr>
			<th style="width: 10%"></th>
			<th style="width:80%">Accomplishment Description</th>
		</tr>
		<cfoutput query="qGetThisAcomplishment">
			<tr id="trRemark_#currentRow#" style="border: 1px solid red;">
				<td style="text-align:center; color: red;width: 10%">
					<input type="button" class="smallDeleteButton" value="Delete" onclick="deleteRow('trRemark_'+#currentRow#)"></input>
				</td>
				<td style="width: 60%">
					<input class="dottedBorder" id="input_Accomplishment#currentRow#" value="#High_Level_Accomplishment#" maxlength="300"></input>
				</td>
			</tr>
		</cfoutput>
	</table>
</div>
<!---	<table class="ActivityLogItem" style="border: 0px solid gray; margin-top:10px">
		<tr>
			<td style="border: 0px solid gray">
				<input type="button" value="Save Accomplishment(s)" class="button" onclick="SaveAccomplishment(<cfoutput>#url.AccomplishmentMonthID#</cfoutput>)"></input>
			</td>
		</tr>
	</table>--->





