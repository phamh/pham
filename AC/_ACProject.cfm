<cfinclude template="../CheckAccess.cfm" >
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfinclude template="_AC_JS.cfm">

<style>
	table.EstimateMenu{
		border-collapse:collapse;
		width:100%;
		height: 100px;
		overflow-y: scroll;
	}

	table.EstimateMenu td{
		border: 0px solid gray;
		border-right: 1px solid gray;
		border-bottom: 1px solid gray;
		color: blue;
		font-weight: bold;
	}

	table.EstimateMenu td:hover{
		text-decoration: underline;
	}

	.vertical-align-content {
	  background-color:lightGray;
	  border: 1px solid black;
	  border-bottom: 0px solid black;
	  height:36px;
	  display:flex;
	  align-items:center;
	  /* Uncomment next line to get horizontal align also */
	  justify-content:center;
	}

</style>

<script>
AddNewProject = function()
{
	var errorMessage = '';
    $("#dialog_newEstimate").dialog({
      	modal: true,
      	width:650,
      	height:600,
      	show: 'slide',//scale, fold, slide, fade,explode, drop, bounce,blind
      	hide: 'slide',
       	draggable: true,
       	cache: false,
       	title: "New Estimate",
		buttons:
		[
		    {	//What If button 3333
		        id : "submitButton",
		        text: "Update",
		        cache: false,
		        click: function()
		        {
					alert('OK');
					$(this).dialog('destroy');
					$(this).dialog('close');
		       	}
		    },

		    {
		    	//Cancel Button
		        text: "Cancel",
		        id: "cancelButton",
		        cache: false,
		        click: function()
		        {
					$(this).dialog('destroy');
					$(this).dialog('close');
		        }
		    }
		  ]
    });
}

</script>

<cfquery name="qGetAllEstimates" datasource="#application.PhamDataSource#">
    SELECT 		*,estimateNumber, estimateId_pk
    FROM		estimate
    WHERE		DeletedFlag <> 1
    ORDER BY 	estimateID_pk DESC
</cfquery>

<div id="dialog_newEstimate" title="New Estimate" style="display:none">
	<cfdump var="#now()#">
</div>

<div style="width: 100%; border:0px solid red; padding:5px" id="EstimateMenuDiv">
	<table>
		<tr>
			<td style="vertical-align:top">
				<div class="vertical-align-content">
					<input type="button" value="[+] New Project" class="button" onclick="AddNewProject()">
				</div>
				<div style="border:1px solid black; height:700px; overflow-y:scroll;width:120px">

					<table class="EstimateMenu" id="estimateMenuTable">
						<cfoutput query="qGetAllEstimates">
							<cfif currentRow MOD 2 EQ 1>
								<cfset rowBackgroundColor = 'white'>
							<cfelse>
								<cfset rowBackgroundColor = '##eceaf2'>
							</cfif>
							<tr style="height:25px;background-color: #rowBackgroundColor#; cursor: pointer" onclick="selectThisMenu_NEW(#estimateId_pk#,#estimateNumber#,'estimateDetails_View.cfm')" id="currentRow_#currentRow#" >
								<td id="data" style="font-size:14px;">#EstimateNumber#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
			</td>
			<td style="vertical-align:top">
				<div id="EstimateDetails"></div>
			</td>
		</tr>
	</table>
</div>





