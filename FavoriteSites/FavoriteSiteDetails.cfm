<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfif isDefined("url.deleteItem")>
	<cfquery name="deleteItem" datasource="#application.PhamDataSource#">
		DELETE FROM portal
		WHERE ctrl_panel_id = "#url.deleteItem#"
	</cfquery>
	<!---<cflocation url="index.cfm">--->
</cfif>

<script>
	var favoriteSitesCFC = new FavoriteSitesCFC();
	favoriteSitesCFC.setHTTPMethod("POST");
		
	DeleteThisItem = function(ctrl_panel_id)
	{
		var DeleteConfirm = confirm('Are you sure you want to delete this item');
		try
		{
			if(DeleteConfirm)
			{
				var DeleteItemStatus = favoriteSitesCFC.fDeleteThisItem(ctrl_panel_id);
			}	
		}
		catch(e)
		{
			alert(e.message);
		}
	}
</script>

<style>
	table.FavoriteDetailTable{
		border-collapse:collapse;
		width:100%;
		overflow-y: scroll;
	}

	table.FavoriteDetailTable td{
		border: 0px solid gray;
		border-right: 1px solid gray;
		border-bottom: 1px solid gray;
		height:25px;
		font-family: Century Gothic;
		font-size: 14px;
		padding:3px;
	}

	table.FavoriteDetailTable td:hover{
		text-decoration: underline;
	}	
	
	a{
		text-decoration: none;
		color: blue;
	}

	.vertical-align-content {
	  border: 0px solid black;
	  height:200px;
	  display:flex;
	  align-items:center;
	  /* Uncomment next line to get horizontal align also */
	  justify-content:center; 
	}	
		
</style>
<cfajaxproxy cfc="FavoriteSitesCFC" jsclassname="FavoriteSitesCFC">
<cfparam name="url.categoryId_pk" default="0">
<cfparam name="url.searchText" default="">

<cfif url.categoryId_pk NEQ 0>
	<cfinvoke component="FavoriteSitesCFC" method="getPortal" categoryId_pk="#url.categoryId_pk#" returnvariable="queryGetPortal">	
	<cfif NOT queryGetPortal.recordCount>
		<div class="vertical-align-content">
			No record(s) found.
		</div>
	</cfif>
<cfelseif url.searchText NEQ ''>
	<cfinvoke component="FavoriteSitesCFC" method="fSearchPortal" searchText="#url.searchText#" returnvariable="queryGetPortal">	
	<cfif NOT queryGetPortal.recordCount>
		<div class="vertical-align-content">
			<cfoutput>#url.searchText#</cfoutput> is not found.
		</div>
	</cfif>	
</cfif>

<cfif queryGetPortal.recordCount>
	<input id="temp" value="<cfoutput>#queryGetPortal.category#</cfoutput>" type="hidden"></input>
	<script>
		document.getElementById('searchDiv').style.display = 'block';
		document.getElementById('selectedCategory').innerHTML = document.getElementById('temp').value;
	</script>

				
	<div style="border:1px solid black; border-top:0px solid black; height:700px; overflow-y:scroll;width:700px">	
    	<table id="listItem" class="FavoriteDetailTable">
    		<cfoutput query="queryGetPortal">
    			<cfif currentRow MOD 2 EQ 1>
    				<cfset rowBackgroundColor = 'white'>
    			<cfelse>
    				<cfset rowBackgroundColor = '##f2f3f4'>
    			</cfif>
    			<tr style="background-color: #rowBackgroundColor#; cursor: pointer; ">
    				<td style="width: 80%"><a href="#queryGetPortal.url#" target="_blank">#queryGetPortal.name# [#queryGetPortal.category#][#queryGetPortal.ctrl_panel_id#]</a></td>
					<td style="text-align: center"><i class="fa fa-edit" style="font-size: 20px; text-align:center;color: green"onclick="alert()"></i></td>
					<td style="text-align: center"><i class="fa fa-trash" style="font-size: 20px;text-align:center;color:##a52a2a" onclick="DeleteThisItem(#queryGetPortal.ctrl_panel_id#)"></i></td>
    			</tr>
    		</cfoutput>
    	</table>
	</div>
</cfif>


